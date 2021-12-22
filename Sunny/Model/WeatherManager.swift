//
//  WeatherManager.swift
//  Sunny
//
//  Created by Даниил Франк on 22.12.2021.
//

import Foundation

class CurrentWeatherManager {
    
    var completionHandler: ((CurrentWeather) -> Void )?
    
    func fetchCurrentWeather(forCity city: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(api)&units=metric"
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        guard let url = url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let data = data{
                //let dataString = String(data: data, encoding: .utf8)
                if let currentWeather = self.parseJSON(fromData: data){
                    self.completionHandler?(currentWeather)
                }
            }
        }
        task.resume()
        }
    
    func parseJSON (fromData data: Data) -> CurrentWeather?{
        let decoder = JSONDecoder()
        
        do{
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(weatherData: weatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
        
}
