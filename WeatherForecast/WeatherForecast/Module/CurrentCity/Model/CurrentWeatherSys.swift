//
//  CurrentWeatherSys.swift
//  Weather
//
//  Created by Irfan Rafii Musyafa on 05/04/20.
//  Copyright © 2020 Irmusyafa. All rights reserved.
//

import Foundation

struct CurrentWeatherSys: Codable {
    var type, id: Int?
    var country: String?
    var sunrise, sunset: Int?
    
    static func emptyInit() -> CurrentWeatherSys {
        return CurrentWeatherSys(
            type: 0,
            id: 0,
            country: "",
            sunrise: 0,
            sunset: 0
        )
    }
}
