//
//  WeatherIconManager.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 12/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import Foundation

class WeatherIconManager: NetworkManager {
    
    override class var host: String {
        return "openweathermap.org"
    }
    
    class func fetchWeatherIcon(imageUrlString: String,
                                success: @escaping (Data?) -> Void,
                                failure: @escaping (CustomError) -> Void) {
        responseData(method: .get,
                     pathArray: ["img/w/", imageUrlString + ".png"])
            .startWithResult { result in
                switch result {
                case .success(let data):
                    success(data)
                case .failure(let error):
                    failure(error)
                }
        }
    }
}
