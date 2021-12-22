//
//  WeatherManager.swift
//  Sunny
//
//  Created by Даниил Франк on 22.12.2021.
//

import Foundation
import CoreLocation

class CurrentWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longetude: CLLocationDegrees)
    }
    
    var completionHandler: ((CurrentWeather) -> Void )?
    
    
    func fetchCurrentWeather( forRequestType requestType: RequestType) {
        var urlString = ""
        
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(api)&units=metric"
        case .coordinate(let latitude, let longetude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longetude)&apikey=\(api)&units=metric"
        }
        
        createReqeust(withURLString: urlString)
    }
    
    fileprivate func createReqeust(withURLString urlString: String){
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
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
    
    fileprivate func parseJSON (fromData data: Data) -> CurrentWeather?{
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
