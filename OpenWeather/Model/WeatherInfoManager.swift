//
//  WeatherInfoManager.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 12/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import Foundation
import ReactiveSwift

class WeatherInfoManager: NetworkManager {
    
    class func fetchWeatherInfo(success: @escaping (CityList) -> Void,
                                failure: @escaping (CustomError) -> Void) {
        let parameters = ["id": ["4163971", "2147714", "2174003"].joined(separator: ","),
                          "units": "metric",
                          "appid": "ef22c88e60dd9a2ca1f649477c54896a"]
        responseObject(parameters: parameters,
                method: .get,
                pathArray: ["data/2.5", "group"],
                type: CityList.self)
            .observe(on: UIScheduler())
            .startWithResult { result in
                switch result {
                case .success(let cityList):
                    success(cityList)
                case .failure(let error):
                    failure(error)
                }
        }
    }
}
