//
//  ViewController.swift
//  Grocery
//
//  Created by Melody on 10/31/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
import Gloss


class ViewController: UIViewController {
    
    var recipes = [Recipe]()
//    var imageClass = [ImageClass]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Networking.shared.fetch(route: .analyzeImage, data: nil) { image in
//            let imageClasses = try? JSONDecoder().decode(ImageClass.self, from: image)
//            print(imageClasses)
//
//        }
        
        Networking.shared.fetch(route: .getRecipe, data: nil) { data in
             let recipe = try? JSONDecoder().decode(RecipeList.self, from: data)
            print(recipe)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



