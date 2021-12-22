//
//  ViewController.swift
//  Sunny
//
//  Created by Даниил Франк on 21.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let weatherManager = CurrentWeatherManager()

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentAlertController(title: "Enter city name", message: nil, style: .alert){ city in
            self.weatherManager.fetchCurrentWeather(forCity: city)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.fetchCurrentWeather(forCity: "London")
        
    }
}

