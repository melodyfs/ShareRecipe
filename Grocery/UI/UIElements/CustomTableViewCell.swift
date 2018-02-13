//
//  CustomTableViewCell.swift
//  Grocery
//
//  Created by Melody on 2/11/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit

class FaintWhiteColor: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textLabel?.font = UIFont(name:"Avenir", size: 18)
        textLabel?.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        
    }
}
