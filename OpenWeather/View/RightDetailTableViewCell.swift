//
//  RightDetailTableViewCell.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 11/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import UIKit

@IBDesignable class RightDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var textLabel_: UILabel?
    @IBOutlet weak var detailTextLabel_: UILabel?
    
    override var textLabel: UILabel? {
       return textLabel_
    }
    
    override var detailTextLabel: UILabel? {
        return detailTextLabel_
    }
    
    
}
