//
//  CoordinatorView.swift
//  WeatherForecast
//
//  Created by Syed Syeda on 16/03/2023.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    var body: some View {
        NavigationStack(path: $coordinator.path){
            coordinator.build(page: .rootView).navigationDestination(for: Page.self) {
                page in
                coordinator.build(page: page)
            }
        }.environmentObject(coordinator)
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
    }
}
