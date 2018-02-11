//
//  AppDelegate.swift
//  Grocery
//
//  Created by Melody on 10/31/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        

        let initialViewController: UIViewController
        let launchedBefore = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if launchedBefore {
            initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
//            self.present(showResult, animated: true)
        } else {
            initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! UIViewController
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
//            self.present(showResult, animated: true)
        }
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.16, blue:0.18, alpha:1.0)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.77), NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 20)!]
        
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(red:0.16, green:0.16, blue:0.18, alpha:1.0)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 20)!], for: .normal)
        UITabBar.appearance().tintColor = UIColor.white
        UITextField.appearance().backgroundColor = UIColor.white
        
        UITableViewCell.appearance().textLabel?.textColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.77)

        
        return true
    }


}

