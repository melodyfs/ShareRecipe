//
//  OptionsVC.swift
//  Grocery
//
//  Created by Melody on 12/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class OptionsVC: UIViewController {

    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBAction func ingredientsPressed(_ sender: Any) {
        showCollectionView()
    }
    
    @IBAction func stepsPressed(_ sender: Any) {
    }
    
    @IBAction func notesPressed(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCollectionView()
        showIngredientTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension OptionsVC {
    
    func showCollectionView() {
        let collectionVC = storyboard?.instantiateViewController(withIdentifier: "collectionVC")
        addChildViewController(collectionVC!)
        scrollView.addSubview((collectionVC?.view)!)
    
    }
    
    func showIngredientTableView() {
        let ingredientTableVC = storyboard?.instantiateViewController(withIdentifier: "ingredientTableVC")
        addChildViewController(ingredientTableVC!)
        tableView.addSubview((ingredientTableVC?.view)!)
        
        
    }
    
}
