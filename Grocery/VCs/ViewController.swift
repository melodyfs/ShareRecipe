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
    let baseURL = "https://api.edamam.com/search"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WatsonNetworking.shared.analyzeImage(imageURL: "https://www.edamam.com/web-img/58a/58a93a8d0c48110ac1c59e3b6e82a9ef.jpg") { data in
            print(data)
            let imageClasses = try? JSONDecoder().decode(List.self, from: data)
            guard let recipe = imageClasses?.list else {return}
            print(recipe)
//            let classifiers = imageClasses?.classifier
//            let classes = classifiers.classe
                //            self.imageClass = imageClasses
//            print(imageClasses)
//            guard let imageClasses = [imageClasses].from(data: data) else {return}
//            print(imageClasses)

        }
        
//        RecipeNetworking.sharedInstance.getRecipe() { (data) in
//            print(data)
//            let recipe = try? JSONDecoder().decode(RecipeList.self, from: data)
//            guard let recipeList = recipe?.hits else {return}
//            self.recipes = recipeList
//            print(self.recipes)
//        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

