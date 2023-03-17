//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by Syed Syeda on 16/03/2023.
//

import XCTest
import Combine
@testable import WeatherForecast

final class WeatherForecastTests: XCTestCase {
    
    var searchCityViewModel: WeatherViewModel!
    var mockSearchCityWeather: MockSearchCityWeather!
    
    
    var currentCityWeatherForecastViewModel: CurrentCityViewModel!
    var mockCurrentCityWeatherForecast : MockCurrentCityWeatherForecast!
    
    private var disposables = Set<AnyCancellable>()

    override func setUp() {

        mockSearchCityWeather = MockSearchCityWeather(searchScenario: .failure(error: APIError.request(message: "Invalid URL")))
        searchCityViewModel = .init(loginFetcher: mockSearchCityWeather)
    
    }
    
    override func tearDownWithError() throws {
        
        searchCityViewModel = nil
        mockSearchCityWeather = nil
        
        currentCityWeatherForecastViewModel = nil
        mockCurrentCityWeatherForecast = nil
         try super.tearDownWithError()
     }
    
    

    func testCurrentCityWeatherFailure() {
        mockCurrentCityWeatherForecast = MockCurrentCityWeatherForecast(currentWeatherScenario: .failure(error: APIError.request(message: "Invalid URL")), forecastScenario: .success(model: ForecastWeatherResponse()))
        currentCityWeatherForecastViewModel = .init(loginFetcher: mockCurrentCityWeatherForecast)
        let expectation = XCTestExpectation(description: "State is set to populated")

       currentCityWeatherForecastViewModel.loginFetcher.fetchCurrentWeather(fromURL: URL(string: "www.abc.com")!).sink { value in
           XCTAssertEqual(value, .failure(APIError.request(message: "Decode Data Error")))
           expectation.fulfill()
        } receiveValue: { result in
            XCTAssertEqual(result?.timezone, 5)
            XCTAssertEqual(result?.name, "Karachi")
            XCTAssertEqual(result?.visibility, 10)
            XCTAssertEqual(result?.code, 10)
        }.store(in: &disposables)
      
        expectation.fulfill()

        wait(for: [expectation], timeout: 1)
        
    }
    
    func testCurrentCityWeatherSuccess() {
        
        mockCurrentCityWeatherForecast = MockCurrentCityWeatherForecast(currentWeatherScenario: .success(model: CurrentWeather(timezone: 5, name: "Karachi", visibility: 10, code: 10)), forecastScenario: .success(model: ForecastWeatherResponse()))
        
        
        currentCityWeatherForecastViewModel = .init(loginFetcher: mockCurrentCityWeatherForecast)
        
        
        let expectation = XCTestExpectation(description: "State is set to populated")
        
       currentCityWeatherForecastViewModel.loginFetcher.fetchCurrentWeather(fromURL: URL(string: "www.abc.com")!).sink { value in
           expectation.fulfill()
        } receiveValue: { result in
            XCTAssertEqual(result?.timezone, 5)
            XCTAssertEqual(result?.name, "Karachi")
            XCTAssertEqual(result?.visibility, 10)
            XCTAssertEqual(result?.code, 10)
        }.store(in: &disposables)
      
        expectation.fulfill()

        wait(for: [expectation], timeout: 1)
        
    }
    

    
    func testCurrentCityForecastFailure() {
        mockCurrentCityWeatherForecast = MockCurrentCityWeatherForecast(currentWeatherScenario: .failure(error: APIError.request(message: "Invalid URL")), forecastScenario: .failure(error: APIError.request(message: "Invalid URL")))
        
        currentCityWeatherForecastViewModel = .init(loginFetcher: mockCurrentCityWeatherForecast)
        let expectation = XCTestExpectation(description: "State is set to populated")

       currentCityWeatherForecastViewModel.loginFetcher.fetchForecastWeather(fromURL: URL(string: "www.abc.com")!).sink { value in
           XCTAssertEqual(value, .failure(APIError.request(message: "Decode Data Error")))
           expectation.fulfill()
        } receiveValue: { result in
            XCTAssertEqual(result?.code, "0")
            XCTAssertEqual(result?.message, 0)
            XCTAssertEqual(result?.count, 0)
        }.store(in: &disposables)
      
        expectation.fulfill()

        wait(for: [expectation], timeout: 1)
        
    }
    
    func testCurrentCityForecastSuccess() {
        
        mockCurrentCityWeatherForecast = MockCurrentCityWeatherForecast(currentWeatherScenario: .success(model: CurrentWeather(timezone: 5, name: "Karachi", visibility: 10, code: 10)), forecastScenario: .success(model: ForecastWeatherResponse(code: "122", message: 0, count: 32)))
        
        
        currentCityWeatherForecastViewModel = .init(loginFetcher: mockCurrentCityWeatherForecast)
        
        
        let expectation = XCTestExpectation(description: "State is set to populated")
        
       currentCityWeatherForecastViewModel.loginFetcher.fetchForecastWeather(fromURL: URL(string: "www.abc.com")!).sink { value in
           expectation.fulfill()
        } receiveValue: { result in
            XCTAssertEqual(result?.code, "122")
            XCTAssertEqual(result?.message, 0)
            XCTAssertEqual(result?.count, 32)
        }.store(in: &disposables)
      
        expectation.fulfill()

        wait(for: [expectation], timeout: 1)
        
    }
    
    
    
    func testSearchCityForecastFailure() {
        
        mockSearchCityWeather = MockSearchCityWeather(searchScenario: .failure(error: APIError.request(message: "Invalid URL")))
        searchCityViewModel = .init(loginFetcher: mockSearchCityWeather)
    
        let expectation = XCTestExpectation(description: "State is set to populated")

        searchCityViewModel.loginFetcher.fetchSearchResult(fromURL: URL(string: "www.abc.com")!).sink { value in
           XCTAssertEqual(value, .failure(APIError.request(message: "Decode Data Error")))
           expectation.fulfill()
        } receiveValue: { result in
            XCTAssertEqual(result.timezone_offset, 55)
        }.store(in: &disposables)
      
        expectation.fulfill()

        wait(for: [expectation], timeout: 1)
        
    }
    
    func testSearchCurrentCityForecastSuccess() {
        
        mockSearchCityWeather = MockSearchCityWeather(searchScenario: .success(model:WeatherDataModel(timezone_offset: 55)))
        
        searchCityViewModel = .init(loginFetcher: mockSearchCityWeather)
        
        let expectation = XCTestExpectation(description: "State is set to populated")
        
        searchCityViewModel.loginFetcher.fetchSearchResult(fromURL: URL(string: "www.abc.com")!).sink { value in
           expectation.fulfill()
        } receiveValue: { result in
            XCTAssertEqual(result.timezone_offset, 55)
        }.store(in: &disposables)
      
        expectation.fulfill()

        wait(for: [expectation], timeout: 1)
        
    }

}
