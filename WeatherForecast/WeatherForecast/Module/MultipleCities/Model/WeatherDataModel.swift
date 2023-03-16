//
//  WeatherDataModel.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 31/05/21.
//

import Foundation

struct WeatherDataModel: Codable {
    var timezone_offset: Int?
    var current: Current?
    var daily: [Daily]?
    var hourly: [Hourly]?
    
    // MARK: - Current Weather Model
    struct Current: Codable {
        var dt: Int?
        var sunrise: Int?
        var sunset: Int?
        var temp: Double?
        var feels_like: Double?
        var pressure: Int?
        var humidity: Int?
        var uvi: Double?
        var clouds: Int?
        var visibility: Int?
        var wind_speed: Double?
        var wind_deg: Int?
        var weather: [Weather]?
    }
    
    // MARK: - Hourly Weather Model
    struct Hourly: Codable {
        var dt: Int?
        var temp: Double?
        var humidity: Int?
        var clouds: Int?
        var pop: Double?
        var weather: [Weather]?
    }
    
    // MARK: - Current Weather Model
    struct Daily: Codable {
        var dt: Int?
        var temp: Temp?
        var clouds: Int?
        var humidity: Int?
        var pop: Double?
        var weather: [Weather]?
        
        struct Temp: Codable {
            var min: Double?
            var max: Double?
        }
    }
    
    // MARK: - Sub Detail Model
    struct Weather: Codable {
        var description: String?
        var icon: String?
    }
}
