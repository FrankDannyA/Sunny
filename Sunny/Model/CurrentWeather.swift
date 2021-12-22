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
        return String(format: "%.0f", temp)
    }
    
    let feelsTemp: Double
    var feelsTempString: String {
        return String(format: "%.0f", feelsTemp)
    }
    
    let imageCode: Int
    var imageSystemName: String {
        switch imageCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default:
            return "nosing"
        }
        
    }
    
    init?(weatherData: WeatherData) {
        name = weatherData.name
        temp = weatherData.main.temp
        feelsTemp = weatherData.main.feelsLike
        imageCode = weatherData.weather.first!.id
    }
}
