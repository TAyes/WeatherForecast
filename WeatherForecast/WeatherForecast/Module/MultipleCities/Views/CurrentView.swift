//
//  CurrentView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 05/06/21.
//

import SwiftUI

struct CurrentView<T : WeatherViewModelType> : View {
    
    @StateObject var weatherVM: T
    
    var body: some View {
       let current = weatherVM.current
        VStack(spacing: 2) {
            Text(weatherVM.currentCityName)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            HStack {
                Text(current.weather?.first?.description?.capitalized ?? "")
                Divider()
                Divider()
                Text("Feels Like: \(current.feels_like?.roundedString(to: 0) ?? "")°")
            }.fixedSize()
            HStack {
                Text("\(current.temp?.roundedString(to: 0) ?? "")°")
                Divider()
                Divider()
                Image(systemName: current.weather?.first?.iconImage ?? "").renderingMode(.original)
            }.fixedSize().font(.system(size: 75)).padding()
            HStack {
                Text("Cloud: \((current.clouds ?? 0))%")
                Divider()
                Text("Humidity: \(current.humidity ?? 0)%")
            }.fixedSize()
        }
    }
}
