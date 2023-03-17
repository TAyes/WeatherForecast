//
//  MockSearchCityWeather.swift
//  WeatherForecastTests
//
//  Created by Syed Syeda on 17/03/2023.
//

@testable import WeatherForecast
import Combine
import UIKit


final class MockSearchCityWeather: APISRequestFetchable {
    
        enum SearchResultScenario {
            case success(model: WeatherDataModel)
            case failure(error: Error)
        }
    
    var searchScenario: SearchResultScenario
    
    init(searchScenario: SearchResultScenario) {
        self.searchScenario = searchScenario
    }
    
    func fetchSearchResult(fromURL url: URL) -> AnyPublisher<WeatherForecast.WeatherDataModel, WeatherForecast.APIError> {
        switch searchScenario {
             case .success(let model):
                 return Just(model)
                .setFailureType(to: APIError.self)
                     .eraseToAnyPublisher()
             case .failure(let error):
            return Fail(error: error as! APIError)
                     .eraseToAnyPublisher()
             }
       
    }
    
    func fetchCurrentWeather(fromURL url: URL) -> AnyPublisher<WeatherForecast.CurrentWeather?, WeatherForecast.APIError> {
        return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
    }
    
    func fetchForecastWeather(fromURL url: URL) -> AnyPublisher<WeatherForecast.ForecastWeatherResponse?, WeatherForecast.APIError> {
        return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
    }
    
}
