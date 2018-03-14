//
//  NavigationController.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 11/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    func createEmptyBackBarButtonItem() {
        topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
   
    override func show(_ vc: UIViewController, sender: Any?) {
        createEmptyBackBarButtonItem()
        super.show(vc, sender: sender)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
