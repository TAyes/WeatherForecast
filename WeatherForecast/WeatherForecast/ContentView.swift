//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Syed Syeda on 16/03/2023.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
        VStack {
            
            Image("weather")
            
            Button(action: {
                coordinator.push(.multipleCities)
            }, label: {
                
                Text("Multiple City").font(.subheadline).bold().padding(.vertical, 10)
                
            }).padding(.horizontal, 50).background(.black).clipShape(Capsule()).foregroundColor(.white)
            
            Button(action: {
                coordinator.push(.currentCities)
            }, label: {
                
                Text("Current City").font(.subheadline).bold().padding(.vertical, 10)
                
            }).padding(.horizontal, 50).background(.black).clipShape(Capsule()).foregroundColor(.white)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("BottomBG"))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
