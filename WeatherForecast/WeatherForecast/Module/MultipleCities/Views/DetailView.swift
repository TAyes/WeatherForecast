//
//  DetailView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 05/06/21.
//

import SwiftUI

struct DetailView<T : WeatherViewModelType> : View {
    @StateObject var weatherVM: T
    
    var body: some View {
       let current = weatherVM.current
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        DetailCell(title: "Sunrise", detail: "\(current.sunrise?.hourMinuteAmPm(weatherVM.timeZoneOffset) ?? "")")
                        DetailCell(title: "Pressure", detail: "\(current.pressure ?? 0) hPa")
                        DetailCell(title: "Visibility", detail: "\((current.visibility ?? 0)/1000) Km")
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        DetailCell(title: "Sunset", detail: "\(current.sunset?.hourMinuteAmPm(weatherVM.timeZoneOffset) ?? "")")
                        DetailCell(title: "Wind", detail: "\(current.windSpeedWithDirection )")
                        DetailCell(title: "UV Index", detail: current.uvi?.roundedString(to: 0) ?? "")
                    }
                }
                DetailCell(title: "Description", detail: current.weather?.first?.description ?? "")
            }.padding(.horizontal)
        
    }
}
