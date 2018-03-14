//
//  UIViewController+Loading.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 11/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoadingView() {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.startAnimating()
        let barButtonItem = UIBarButtonItem(customView: activityIndicatorView)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    func hideLoadingView() {
        navigationItem.rightBarButtonItem = nil
    }
}
