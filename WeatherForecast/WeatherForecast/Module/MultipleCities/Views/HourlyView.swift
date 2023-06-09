//
//  HourlyView.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 05/06/21.
//

import SwiftUI

struct HourlyView<T : WeatherViewModelType> : View {
    @StateObject var weatherVM: T
    
    var body: some View {
       let hourly = weatherVM.hourly
            Divider()
            VStack(alignment: .leading) {
                Text("Hourly Forecast").bold()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(hourly, id: \.dt) { hour in
                            ZStack {
                                VStack {
                                    Text(hour.dt?.hourMinuteAmPm(weatherVM.timeZoneOffset) ?? "").font(.title)
                                    HStack {
                                        Text("\(hour.temp?.roundedString(to: 0) ?? "")°")
                                        Divider()
                                        Divider()
                                        Image(systemName: hour.weather?.first?.iconImage ?? "").renderingMode(.original)
                                    }
                                    .font(.system(size: 24))
                                    .padding()
                                    HStack {
                                        Text("Rain: \(((hour.pop ?? 0) * 100).roundedString(to: 0))%")
                                        Divider()
                                        Divider()
                                        Text("Cloud: \(hour.clouds ?? 0)%")
                                    }
                                }.padding()
                            }
                            .background(Color(.systemPink).opacity(0.25))
                            .cornerRadius(12)
                        }
                    }
                }
            }.padding(.horizontal, 8)
        
    }
}
