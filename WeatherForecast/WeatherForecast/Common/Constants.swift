//
//  Constants.swift
//  Ecommerce
//
//  Created by fahad on 18/12/2022.
//

import Foundation

class APIs {
    
    static let key = "6b0f9abfd032ccca32d2eba6fab78445"
    
    static func checkForAPIKey() {
        precondition(APIs.key != "YourAPIKey", "Condition: \nEither your APIKey is invalid or you haven't filled it yet. \nPlease Fill Your APIKey")
    }
    
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    static var searchCityData: String {
        return baseUrl + "onecall"
    }
    
}
