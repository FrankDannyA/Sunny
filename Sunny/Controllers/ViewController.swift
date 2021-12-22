//
//  ViewController.swift
//  Sunny
//
//  Created by Даниил Франк on 21.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var weatherManager = CurrentWeatherManager()

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentAlertController(title: "Enter city name", message: nil, style: .alert){ [unowned self] city in
            self.weatherManager.fetchCurrentWeather(forCity: city)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.completionHandler = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updatingInteface(currentWeather)
            }
        
        weatherManager.fetchCurrentWeather(forCity: "London")
        }
    
    func updatingInteface(_ currentWeather: CurrentWeather){
        DispatchQueue.main.async {
            self.cityLabel.text = currentWeather.name
            self.temperatureLabel.text = currentWeather.tempString
            self.feelsLikeTemperatureLabel.text = currentWeather.feelsTempString
            self.weatherIconImageView.image = UIImage(systemName: currentWeather.imageSystemName)
        }
    }
}

