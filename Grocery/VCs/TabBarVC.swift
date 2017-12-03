//
//  MainTabBarController.swift
//  Grocery
//
//  Created by Mac on 11/20/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
import Foundation

class TabBarVC: UITabBarController {
    
    //  Creates instance of MGPhotoHelper
    let photoHelper = PhotoHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //  Runs function after recieving image
        photoHelper.completionHandler = { image in
            print("handle image")
        }
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }
}

extension TabBarVC: UITabBarControllerDelegate {

}
