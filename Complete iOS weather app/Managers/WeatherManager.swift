//
//  WeatherManager.swift
//  Complete iOS weather app
//
//  Created by Andrews Mensah on 12/07/2022.
//

import Foundation
import CoreLocation

class WeatherManager{
    func getCurrentWeather (latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody{
        
        guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("0e016d156498818a44e09acf8d2b2f71")&units=metric")  else {fatalError("Weather URL is missing")}
        
        let urlRequest = URLRequest(url: weatherURL)
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as?HTTPURLResponse)?.statusCode == 200 else{
            fatalError("Error fetching your location's weather data data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
        
        
    }
    
}

struct ResponseBody: Decodable {
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
}

struct CoordinateResponse: Decodable{
    var lon: Double
    var lat: Double
}

struct WeatherResponse: Decodable{
    var id: Double
    var main: String
    var description: String
    var icon: String
}

struct MainResponse: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
}

struct WindResponse: Decodable{
    var speed: Double
    var deg: Double
}



//extension ResponseBody.MainResponse{
//    var feelsLike: Double {return feels_like}
//    var tempMin: Double {return temp_min}
//    var tempMax: Double {return temp_max}
//}
