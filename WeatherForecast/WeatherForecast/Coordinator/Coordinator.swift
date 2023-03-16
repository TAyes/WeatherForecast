//
//  Coordinator.swift
//  WeatherForecast
//
//  Created by Syed Syeda on 16/03/2023.
//

import SwiftUI

enum Page: String, Identifiable {
    case rootView, multipleCities, currentCities
    
    var id: String {
        self.rawValue
    }
}


class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ page: Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .rootView:
            ContentView()
        case .multipleCities:
            MainMultipleCitiesView(weatherVM: WeatherViewModel(loginFetcher: RequestAPI()))
        case .currentCities:
            CurrentCity(weatherViewModel: CurrentCityViewModel(loginFetcher: RequestAPI()))
        }
    }

}
