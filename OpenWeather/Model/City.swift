//
//  City.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 10/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import Foundation

struct CityList: Codable {
    
    let cities: [City]
    
    enum CodingKeys: String, CodingKey {
        case cities = "list"
    }
}


struct City: Codable {
    struct Main: Codable {
        let temp: Double
        let pressure: Double
        let humidity: Int
        let temp_min: Double
        let temp_max: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let weatherDescription: String
        let icon: String
        
        enum CodingKeys: CodingKey, String {
            case id
            case main
            case weatherDescription = "description"
            case icon
        }
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Double
    }
    
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}
