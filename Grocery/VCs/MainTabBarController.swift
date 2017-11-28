//
//  MainTabBarController.swift
//  Grocery
//
//  Created by Mac on 11/20/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
import Foundation

class MainTabBarController: UITabBarController {
    
    //  Creates instance of MGPhotoHelper
    let photoHelper = MGPhotoHelper()
    
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

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
        // Presents action sheet from "self" which is MainTabBarController
            photoHelper.presentActionSheet(from: self)
            return false
            
        } else {
            return true
        }
    }


   
}
