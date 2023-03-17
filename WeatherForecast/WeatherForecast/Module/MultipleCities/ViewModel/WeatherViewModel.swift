//
//  WeatherViewModel.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import SwiftUI
import CoreLocation
import Combine


// MARK: - protocol
protocol WeatherViewModelType: ViewModelType {
    
    var searchedCityName: String { get set }
    var currentCityName: String { get set }
    var timeZoneOffset: Int { get set }
    var showAlert: Bool { get set }
    var current: WeatherDataModel.Current { get set }
    var daily: [WeatherDataModel.Daily] { get set }
    var hourly: [WeatherDataModel.Hourly] { get set }
    var errorStatus: AppError? {get set}
    func getWeather()
    func fetchWeatherByCityName()
}

class WeatherViewModel: WeatherViewModelType {

    // MARK: - Properties
    @Published var showAlert = false
    @Published var isLoading = true
    
    @Published var error: String = ""
    @Published var errorStatus: AppError? = nil
    
    @Published var searchedCityName = ""
    @Published var currentCityName = ""
    @Published var timeZoneOffset = 0
    
    @Published var current: WeatherDataModel.Current = WeatherDataModel.Current()
    @Published var daily: [WeatherDataModel.Daily] = []
    @Published var hourly: [WeatherDataModel.Hourly] = []

    private let locationManager = CLLocationManager()
    private var disposables = Set<AnyCancellable>()
    var loginFetcher: APISRequestFetchable
    
    private var locationDataManager: LocationDataManager
    
    // MARK: - Initialization
    init(loginFetcher: APISRequestFetchable, locationDataManager: LocationDataManager = LocationDataManager()) {
        self.loginFetcher = loginFetcher
        self.locationDataManager = locationDataManager
        location()
    }
    
    // MARK: - Class Methods
    func getWeather() {
        if let location = locationDataManager.locationManager.location {
            loadData(with: location)
        } else {
            isLoading = false
        }
    }
    
    func fetchWeatherByCityName() {
        if searchedCityName != "" {
            CLGeocoder().geocodeAddressString(searchedCityName) { (placemarks, error) in
                if let location = placemarks?.first?.location {
                    self.loadData(with: location)
                }
            }
        }
    }
    
    func getCityName(of location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                self.currentCityName = "\(placemark.locality ?? "") \(placemark.country ?? "")"
            }
        }
    }
}
// MARK: - ApiCall
extension WeatherViewModel {
    private func loadData(with location: CLLocation) {
        APIs.checkForAPIKey()
        let coordinate = location.coordinate
       guard var urlComps = URLComponents(string: APIs.searchCityData) else {return}
        
            urlComps.queryItems = [URLQueryItem(name: "lat", value: "\(coordinate.latitude)"), URLQueryItem(name: "lon", value: "\(coordinate.longitude)"),
                                   URLQueryItem(name: "exclude", value: "minutely,alerts"),
                                   URLQueryItem(name: "appid", value: APIs.key),
                                   URLQueryItem(name: "units", value: "metric")]
        
        guard let url = urlComps.url else {return}
        self.isLoading = true
       
       loginFetcher.fetchSearchResult(fromURL: url).receive(on: DispatchQueue.main)
                   .sink { [weak self] value in
                       
                       switch value {
                       case .failure(let error):
                           self?.errorStatus = AppError(errorString: error.localizedDescription)
                           self?.error = error.localizedDescription
                           self?.isLoading = false
                       case .finished:
                           self?.isLoading = false
                       }
                   } receiveValue: { [weak self] result in
                       self?.timeZoneOffset = result.timezone_offset ?? 0
                       self?.current = result.current ?? WeatherDataModel.Current()
                       self?.daily = result.daily ?? []
                       self?.hourly = result.hourly ?? []
                       self?.getCityName(of: location)
                       self?.isLoading = false
                       self?.searchedCityName = ""
                   }
                   .store(in: &disposables)
    }
}


// MARK: - CLLocationManagerDelegate
extension WeatherViewModel {
    func location() {
        switch locationDataManager.locationManager.authorizationStatus {
          case .authorizedWhenInUse:  // Location services are available.
              // Insert code here of what should happen when Location services are authorized
            getWeather()
          case .restricted, .denied:  // Location services currently unavailable.
              // Insert code here of what should happen when Location services are NOT authorized
                self.isLoading = false
          case .notDetermined:        // Authorization not determined yet.
            isLoading = false
              break
          default:
                isLoading = false
        }
    }
}
