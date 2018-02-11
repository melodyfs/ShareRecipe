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
        textLabel?.textColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha: 0.77)
    }
}
