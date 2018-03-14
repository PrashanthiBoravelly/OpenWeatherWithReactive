//
//  UIImageView+imageURL.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 11/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func setImage(with urlString: String,
                  completion: @escaping () -> Void) {
        WeatherIconManager.fetchWeatherIcon(imageUrlString: urlString, success: { data in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                data.map { strongSelf.image = UIImage(data: $0) }
                completion()
            }

        }, failure: { customError in
            DispatchQueue.main.async { [weak self] in
                print(customError.debugDescription)
                guard let _ = self else { return }
                completion()
            }
        })
    }
    
}
