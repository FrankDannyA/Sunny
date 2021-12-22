//
//  WeatherManager.swift
//  Sunny
//
//  Created by Даниил Франк on 22.12.2021.
//

import Foundation

struct CurrentWeatherManager {
    
    func fetchCurrentWeather(forCity city: String) {
        
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(api)"
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        guard let url = url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let dataString = String(data: data, encoding: .utf8)
            print(dataString!)
        }
        
        task.resume()

        
    }
}
