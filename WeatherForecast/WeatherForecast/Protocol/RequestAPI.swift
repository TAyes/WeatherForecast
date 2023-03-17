//
//  MovieLoader.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation
import UIKit
import Combine

// MARK: - protocol
protocol ViewModelType: ObservableObject {
    var error: String { get set}
    var isLoading: Bool { get set }
}

protocol APISRequestFetchable {
    func fetchSearchResult(fromURL url: URL) -> AnyPublisher<WeatherDataModel, APIError>
    func fetchCurrentWeather(fromURL url: URL) -> AnyPublisher<CurrentWeather?, APIError>
    func fetchForecastWeather(fromURL url: URL) -> AnyPublisher<ForecastWeatherResponse?, APIError>
}

class RequestAPI {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension RequestAPI {
    func requiredRequest(fromURL url: URL) throws -> URLRequest {
        return URLRequest(url: url)
    }
}


extension RequestAPI: APISRequestFetchable, Fetchable {
    func fetchSearchResult(fromURL url: URL) -> AnyPublisher<WeatherDataModel, APIError> {
        
        guard let request = try? self.requiredRequest(fromURL: url) else {
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        return fetch(with: request, session: self.session)
    }
    
    func fetchCurrentWeather(fromURL url: URL) -> AnyPublisher<CurrentWeather?, APIError> {
        guard let request = try? self.requiredRequest(fromURL: url) else {
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        return fetch(with: request, session: self.session)
    }
    
    func fetchForecastWeather(fromURL url: URL) -> AnyPublisher<ForecastWeatherResponse?, APIError> {
        guard let request = try? self.requiredRequest(fromURL: url) else {
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        return fetch(with: request, session: self.session)
    }
 
}

