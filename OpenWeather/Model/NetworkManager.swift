//
//  NetworkManager.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 12/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import Foundation
import ReactiveSwift

enum HttpMethod: String {
    case get
    case post
    
    var description: String {
        return rawValue.uppercased()
    }
    
}

class NetworkManager {
    
    class var host: String {
        return "api.openweathermap.org"
    }
    
    class var scheme: String {
        return "https"
    }
    
    class func responseData(parameters: [String: Any]? = nil,
                            method: HttpMethod,
                            pathArray: [String]) -> SignalProducer<Data, CustomError> {
        
        return SignalProducer<Data, CustomError> { (observer, lifetime) in
            var urlComponents = URLComponents()
            var requestBody: Data?
            urlComponents.scheme = scheme
            urlComponents.host = host
            
            if let parameters = parameters {
                switch method {
                case .get:
                    let queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing:$0.value)) }
                    urlComponents.queryItems = queryItems
                case .post:
                    do {
                        let data = try JSONEncoder().encode(parameters)
                        requestBody = data
                    } catch let error as EncodingError {
                        observer.send(error: .encoding(error: error))
                    } catch {
                        observer.send(error: .system(error: error))
                    }
                }
            }
            if let baseUrl = urlComponents.url {
                let url = pathArray.reduce(baseUrl) {  $0.appendingPathComponent($1) }
                var request = URLRequest(url: url)
                request.httpMethod = method.description
                request.httpBody = requestBody
                let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                    if let error = error {
                        if (error as NSError).domain == NSURLErrorDomain,
                            (error as NSError).code == NSURLErrorNotConnectedToInternet
                        {
                            observer.send(error: .offline)
                        } else {
                            observer.send(error: .system(error: error))
                        }
                    } else if (response as? HTTPURLResponse)?.statusCode != 200 {
                        observer.send(error: .invalidStatusCode(code: (response as! HTTPURLResponse).statusCode, data: data))
                    } else if let data = data {
                        observer.send(value: data)
                        observer.sendCompleted()
                    } else {
                        observer.sendCompleted()
                    }
                }
                lifetime.observeEnded(task.cancel)
                task.resume()
            } else {
                observer.send(error: .invalidUrl(urlString: host))
            }
        }
        
    }
    
    class func responseObject<T: Decodable>(parameters: [String: Any]? = nil,
                                            method: HttpMethod,
                                            pathArray: [String],
                                            type: T.Type) -> SignalProducer<T, CustomError> {
        return responseData(parameters:parameters,
                            method: method,
                            pathArray: pathArray)
            .attemptMap { data in
                let jsonDecoder = JSONDecoder()
                do {
                    let response = try jsonDecoder.decode(T.self, from: data)
                    return .success(response)
                } catch let error as DecodingError {
                    return .failure(.decoding(data: data, error: error))
                } catch {
                    return .failure(.system(error: error))
                }
        }
    }
    
}




