//
//  ViewContoller + Alert.swift
//  Sunny
//
//  Created by Даниил Франк on 21.12.2021.
//

import UIKit

extension ViewController {
    
    func presentAlertController ( title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        alertController.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textfield = alertController.textFields?.first
            guard let cityName = textfield?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
                
                print("Serch weather in city: \(city)")
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
        alertController.addAction(search)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
