//
//  MockOtherCityWeatherForecast.swift
//  WeatherForecastTests
//
//  Created by Syed Syeda on 17/03/2023.
//

@testable import WeatherForecast
import Combine
import UIKit

final class MockCurrentCityWeatherForecast: APISRequestFetchable {
    
//    enum SearchResultScenario {
//        case success(model: WeatherDataModel)
//        case failure(error: Error)
//    }
    
    enum CurrentWeatherScenario {
        case success(model: CurrentWeather)
        case failure(error: Error)
    }
    
    enum ForecastWeatherScenario {
        case success(model: ForecastWeatherResponse)
        case failure(error: Error)
    }
    
//    var searchScenario: SearchResultScenario
    var currentWeatherScenario: CurrentWeatherScenario
    var forecastScenario: ForecastWeatherScenario
    
    init(currentWeatherScenario: CurrentWeatherScenario, forecastScenario: ForecastWeatherScenario) {
//        self.searchScenario = searchScenario
        self.currentWeatherScenario = currentWeatherScenario
        self.forecastScenario = forecastScenario
    }
    
    
    func fetchSearchResult(fromURL url: URL) -> AnyPublisher<WeatherForecast.WeatherDataModel, WeatherForecast.APIError> {
        return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
    }
    
    func fetchCurrentWeather(fromURL url: URL) -> AnyPublisher<WeatherForecast.CurrentWeather?, WeatherForecast.APIError> {
        switch currentWeatherScenario {
             case .success(let model):
                 return Just(model)
                .setFailureType(to: APIError.self)
                     .eraseToAnyPublisher()
             case .failure(let error):
            return Fail(error: error as! APIError)
                     .eraseToAnyPublisher()
             }
    }
    
    func fetchForecastWeather(fromURL url: URL) -> AnyPublisher<WeatherForecast.ForecastWeatherResponse?, WeatherForecast.APIError> {
        switch forecastScenario {
             case .success(let model):
                 return Just(model)
                .setFailureType(to: APIError.self)
                     .eraseToAnyPublisher()
             case .failure(let error):
            return Fail(error: error as! APIError)
                     .eraseToAnyPublisher()
             }
    }
    
    
}
