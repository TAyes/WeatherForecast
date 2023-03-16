//
//  MainMultipleCitiesView.swift
//  WeatherForecast
//
//  Created by Syed Syeda on 16/03/2023.
//

import SwiftUI

struct MainMultipleCitiesView<T : WeatherViewModelType> : View  {
    
    @ObservedObject var weatherVM: T//2
    
    // Alert Meaasage related to location Authorization status denied.
    private let message = NSLocalizedString("Go to Setting >> Privacy >> Location Services >> ForecastApp >> Ask Next Time", comment: "Location services are denied")
    private let settingsButtonTitle = NSLocalizedString("GO TO SETTINGS", comment: "Settings alert button")
    
    var body: some View {
        ZStack {
            // Bottom Most layer bacground color gradient.
            LinearGradient(gradient: Gradient(colors: [Color("BottomBG"), Color("TopBG")]), startPoint: .topLeading, endPoint: .bottomLeading).ignoresSafeArea()
            if weatherVM.isLoading {
                // Loading indicator when app launches..
                ProgressView("Loading").font(.largeTitle)
            } else {
                if weatherVM.showAlert {
                    MultipleCities(weatherVM: weatherVM)
                        // Alert on location denied.
                        .alert(isPresented: $weatherVM.showAlert) {
                            Alert(title: Text(NSLocalizedString("LOCATION SERVICES DENIED LAST TIME", comment: "Location services alert title")),
                                  message: Text(message),
                                  primaryButton: .default(Text(settingsButtonTitle)) {
                                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                        // Take the user to the Settings app to change permissions.
                                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                                    }
                                  },secondaryButton: .cancel()
                            )
                        }
                } else {
                    MultipleCities(weatherVM: weatherVM)
                        // Alert when Network Error, Connection Error or API Key error etc.
                        .alert(item: $weatherVM.errorStatus) { (appAlert) in
                            Alert(title: Text("Error"), message: Text(
                                    """
                            \(appAlert.errorString)
                            Please try again later.
                            """)
                            )
                        }
                }
            }
        }
    }
}

struct MainMultipleCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMultipleCitiesView(weatherVM: WeatherViewModel(loginFetcher: RequestAPI()))
    }
}
