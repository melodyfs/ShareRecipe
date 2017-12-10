//
//  RecipeDetailVC.swift
//  Grocery
//
//  Created by Melody on 12/9/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class RecipeDetailVC: UIViewController {

   
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBAction func stepsPressed(_ sender: Any) {
    }
    
    @IBAction func likePressed(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let ingredientTableVC = storyboard?.instantiateViewController(withIdentifier: "ingredientTableVC")
//        tableView?.delegate = ingredientTableVC
//        tableView?.dataSource = ingredientTableVC
        addChildViewController(ingredientTableVC!)
        detailView.addSubview((ingredientTableVC?.view)!)
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
