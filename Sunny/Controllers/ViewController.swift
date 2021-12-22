//
//  ViewController.swift
//  Sunny
//
//  Created by Даниил Франк on 21.12.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weatherManager = CurrentWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()

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
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
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

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longetude = location.coordinate.longitude
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        print(error?.localizedDescription)
    }
}


