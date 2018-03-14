//
//  DetailViewController.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 11/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var airLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()
        if let city = city {
            title = city.name
            temperatureLabel.text = String(city.main.temp) + "°C"
            descriptionLabel.text = city.weather.first?.weatherDescription
            imageView.setImage(with: city.weather.first?.icon ?? "", completion: {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            })
            minTemperatureLabel.text = "Min Temp: " + String(city.main.temp_min) + "°C"
            maxTemperatureLabel.text = "Max Temp: " + String(city.main.temp_max) + "°C"
            airLabel.text = "air: " + String(city.wind.speed) + "m/s"
            humidityLabel.text = "humidity: " + String(city.main.humidity) + "%"
        }
    }

}
