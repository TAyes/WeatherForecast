//
//  ForecastWeatherMainValue.swift
//  Weather
//
//  Created by Irfan Rafii Musyafa on 04/04/20.
//  Copyright © 2020 Irmusyafa. All rights reserved.
//

import Foundation

struct ForecastWeatherMainValue: Codable {
    var temp, feelsLike: Double?
    var tempMin, tempMax: Double?
    var pressure, seaLevel, grndLevel, humidity: Int?
    var tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    static func emptyInit() -> ForecastWeatherMainValue {
        return ForecastWeatherMainValue(
            temp: 0.0,
            feelsLike: 0.0,
            tempMin: 0.0,
            tempMax: 0.9,
            pressure: 0,
            seaLevel: 0,
            grndLevel: 0,
            humidity: 0,
            tempKf: 0
        )
    }
}
