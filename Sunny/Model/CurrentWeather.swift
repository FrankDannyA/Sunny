//
//  CurrentWeather.swift
//  Sunny
//
//  Created by Даниил Франк on 22.12.2021.
//

import Foundation

struct CurrentWeather{
    
    let name: String
    
    let temp: Double
    var tempString: String {
        return "\(temp.rounded())"
    }
    
    let feelsTemp: Double
    var feelsTempString: String {
        return "\(feelsTemp.rounded())"
    }
    
    let imageCode: Int
    
    init?(weatherData: WeatherData) {
        name = weatherData.name
        temp = weatherData.main.temp
        feelsTemp = weatherData.main.feelsLike
        imageCode = weatherData.weather.first!.id
    }
}
