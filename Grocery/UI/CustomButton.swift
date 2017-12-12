//
//  CustomButton.swift
//  Grocery
//
//  Created by Melody on 12/12/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import UIKit

class GreenButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.cornerRadius = 15
//        layer.cornerRadius = 5.0
        layer.borderColor = UIColor(red:0.31, green:0.00, blue:0.48, alpha: 0.0).cgColor
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setBackgroundColor(color: UIColor(red:0.49, green:0.76, blue:0.05, alpha:1.0), forState: .normal)
        setBackgroundColor(color: UIColor.white, forState: .selected)
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor.black, for: .selected)
        
        
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}
