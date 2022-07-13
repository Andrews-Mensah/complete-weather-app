//
//  ContentView.swift
//  Complete iOS weather app
//
//  Created by Andrews Mensah on 12/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var weatherManager = WeatherManager()
    
    @State var weather: ResponseBody?
    var body: some View {
        
        VStack{
            if let location = locationManager.location{
                
                if let weather = weather {
                    WeatherView(weather: weather)
                } else{
                    LoadingView()
                        .task {
                            do{
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                print("dfjghksbcjcsvcgsjfxgsvhxbs,shxjvgxhcsjvxhb",weather)
                            } catch{
                                print("bnnbchvjbhnjm", weather)
                                print("Error getting weather data: \(error)")
                            }
                        }
                }
            }
            
            else{
                if locationManager.isLoading{
                    ProgressView()
                } else{
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.609, saturation: 0.8, brightness: 0.539))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
