//
//  ViewController.swift
//  Grocery
//
//  Created by Melody on 10/31/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageClass = [ImageClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WatsonNetworking.shared.analyzeImage(imageURL: "https://www.edamam.com/web-img/58a/58a93a8d0c48110ac1c59e3b6e82a9ef.jpg") { data in
            let imageClasses = try? JSONDecoder().decode(ImageClass.self, from: data)
//            let classifiers = imageClasses?.classifier
//            let classes = classifiers.classe
                //            self.imageClass = imageClasses
            print(imageClasses)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

