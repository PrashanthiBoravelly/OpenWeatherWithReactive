//
//  CustomError.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 10/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import Foundation

enum CustomError: Error, CustomDebugStringConvertible {
    case encoding(error: Error)
    case offline
    case system(error: Error)
    case decoding(data: Data, error: Error)
    case invalidUrl(urlString: String)
    case invalidStatusCode(code: Int, data: Data?)
    case unknown
    
    var debugDescription: String {
        switch self {
        case .offline:
            return "offline error"
        case .system(error: let error):
            return String(describing: error)
        case .decoding(data: let data, error: let error):
            return ["decoding error", String(describing: error), String(data: data, encoding: .utf8)].flatMap { $0 }.joined(separator: " ")
        case .invalidUrl(urlString: let urlString):
            return "invalid url \(urlString)"
        case .encoding(error: let error):
            return "encoding error" + String(describing: error)
        case .invalidStatusCode(code: let statusCode, data: let data):
            return ["invalidstatuscode",  String(statusCode), data.flatMap { String(data: $0, encoding: .utf8) }].flatMap { $0 }.joined(separator: " ")
        case .unknown:
            return "unknown error"
        }
        
    }
    
    var userDescription: String {
        switch self {
        case .offline:
            return "your network connection appears to be offline."
        default:
            return "There are system issues. Please try after some time."
        }
    }
}
