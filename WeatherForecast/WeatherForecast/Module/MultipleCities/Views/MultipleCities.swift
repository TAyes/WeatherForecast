//
//  MultipleCities.swift
//  WeatherForecast
//
//  Created by Syed Syeda on 16/03/2023.
//

import SwiftUI

struct MultipleCities<T : WeatherViewModelType> : View {
    // MARK: - Property
    @StateObject var weatherVM: T//2
    
    // MARK: - Body
    var body: some View {
        if weatherVM.isLoading {
            ProgressView("Loading").font(.largeTitle)
        } else {
            ScrollView(showsIndicators: false) {
                VStack {
                    SearchView(weatherVM: weatherVM)
                    if weatherVM.daily.count > 0 {
                        CurrentView(weatherVM: weatherVM)
                        DailyView(weatherVM: weatherVM)
                        HourlyView(weatherVM: weatherVM)
                        DetailView(weatherVM: weatherVM)
                    }
                }.animation(.easeInOut(duration: 1))
            }
        }
    }
}

struct MultipleCities_Previews: PreviewProvider {
    static var previews: some View {
        MultipleCities(weatherVM: WeatherViewModel(loginFetcher: RequestAPI()))
    }
}
