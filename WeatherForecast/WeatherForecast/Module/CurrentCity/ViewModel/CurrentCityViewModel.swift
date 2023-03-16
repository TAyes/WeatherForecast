//
//  CurrentCityViewModel.swift
//  WeatherForecast
//
//  Created by Syed Syeda on 16/03/2023.
//

import SwiftUI
import Combine
import CoreLocation

// MARK: - protocol
protocol CurrentCityViewModelType: ViewModelType {
    
    var stateView: StateView { get set }
    var currentWeather: CurrentWeather { get set }
    var todayWeather: ForecastWeather { get set }
    var hourlyWeathers: [ForecastWeather] { get set }
    var dailyWeathers: [ForecastWeather] { get set }
    var currentDescription: String { get set }
    var stateCurrentWeather: StateView {get}
    var stateForecastWeather: StateView {get}
    func retry()
}


class CurrentCityViewModel: CurrentCityViewModelType {
    
    @Published var error: String = ""
    
    @Published var isLoading: Bool = true

    @Published var stateView: StateView = StateView.loading

    @Published var currentWeather = CurrentWeather.emptyInit()
    
    @Published var todayWeather = ForecastWeather.emptyInit()

    @Published var hourlyWeathers: [ForecastWeather] = []

    @Published var dailyWeathers: [ForecastWeather] = []
    
    @Published var currentDescription = ""
        
    @Published var stateCurrentWeather = StateView.loading
    @Published var stateForecastWeather = StateView.loading
    private let cityId = "1627459" // Serpong City Id
    
    private var disposables = Set<AnyCancellable>()
    private let loginFetcher: APISRequestFetchable
    private var locationDataManager: LocationDataManager
    
    private enum SuffixURL: String {
        case forecastWeather = "forecast"
        case currentWeather = "weather"
    }
    
    // MARK: - Initialization
    init(loginFetcher: APISRequestFetchable, locationDataManager: LocationDataManager = LocationDataManager()) {
        self.loginFetcher = loginFetcher
        self.locationDataManager = locationDataManager
        location()
        getData()
    }
    
    func retry() {
        stateView = .loading
        stateCurrentWeather = .loading
        stateForecastWeather = .loading
        getData()
    }
    
    private func getData() {
        if let location = locationDataManager.locationManager.location {
            loadCurrentData(suffixURL: .currentWeather, with: location)
            loadForecastData(suffixURL: .forecastWeather, with: location)
        } else {
            isLoading = false
        }
    }
        
    private func updateStateView() {
        if stateCurrentWeather == .success, stateForecastWeather == .success {
            stateView = .success
        }
        
        if stateCurrentWeather == .failed, stateForecastWeather == .failed {
            stateView = .failed
        }
    }
    
   private func prepareURL(suffixURL: SuffixURL, with location: CLLocation) -> URL? {
        let coordinate = location.coordinate
        
        guard var urlComps = URLComponents(string: APIs.baseUrl + suffixURL.rawValue) else {return nil}
        
            urlComps.queryItems = [
                URLQueryItem(name: "lat", value: "\(coordinate.latitude)"), URLQueryItem(name: "lon", value: "\(coordinate.longitude)"),
                                   URLQueryItem(name: "APPID", value: APIs.key),
                                   URLQueryItem(name: "units", value: "metric")]
        
        guard let url = urlComps.url else {return nil}
        return url
    }
}


// MARK: - ApiCall
extension CurrentCityViewModel {
    private func loadCurrentData(suffixURL: SuffixURL, with location: CLLocation) {
       
        APIs.checkForAPIKey()
        guard let url = prepareURL(suffixURL: suffixURL, with: location) else {return }
       
       loginFetcher.fetchCurrentWeather(fromURL: url, httpBody: nil, httpMethod: .get).receive(on: DispatchQueue.main)
                   .sink { [weak self] value in
                       
                       switch value {
                       case .failure(let error):
                           self?.stateCurrentWeather = .failed
                           self?.error = error.localizedDescription
                           self?.isLoading = false
                           self?.updateStateView()
                       case .finished:
                           self?.isLoading = false
                       }
                   } receiveValue: { [weak self] result in
                       guard let ws = self else { return }
                       if let currentWeather = result {
                           ws.currentWeather = currentWeather
                           ws.todayWeather = currentWeather.getForecastWeather()
                           ws.currentDescription = currentWeather.description()
                           ws.stateCurrentWeather = .success
                       } else {
                           ws.stateCurrentWeather = .failed
                       }
                       ws.updateStateView()
                   }
                   .store(in: &disposables)
    }
    
    private func loadForecastData(suffixURL: SuffixURL, with location: CLLocation) {

        APIs.checkForAPIKey()
        guard let url = prepareURL(suffixURL: suffixURL, with: location) else {return }
       
       loginFetcher.fetchForecastWeather(fromURL: url, httpBody: nil, httpMethod: .get).receive(on: DispatchQueue.main)
                   .sink { [weak self] value in
                       
                       switch value {
                       case .failure(let error):
                           self?.stateForecastWeather = .failed
                           self?.error = error.localizedDescription
                           self?.isLoading = false
                           self?.updateStateView()
                       case .finished:
                           self?.isLoading = false
                       }
                   } receiveValue: { [weak self] forecastWeatherResponse in
                       guard let ws = self else { return }
                       if let forecastWeatherResponse = forecastWeatherResponse {
                           ws.hourlyWeathers = forecastWeatherResponse.list
                           ws.dailyWeathers = forecastWeatherResponse.dailyList
                           ws.stateForecastWeather = .success
                       } else {
                           ws.stateForecastWeather = .failed
                       }
                       ws.updateStateView()
                   }
                   .store(in: &disposables)
    }
}


// MARK: - CLLocationManagerDelegate
extension CurrentCityViewModel {
    func location() {
        switch locationDataManager.locationManager.authorizationStatus {
          case .authorizedWhenInUse:  // Location services are available.
              // Insert code here of what should happen when Location services are authorized
            getData()
          case .restricted, .denied:  // Location services currently unavailable.
              // Insert code here of what should happen when Location services are NOT authorized
                isLoading = false
          case .notDetermined:        // Authorization not determined yet.
              break
          default:
                isLoading = false
        }
    }
}
