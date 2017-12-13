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
    
    var recipes = [Recipe]()
    
    var recipeName: String!
    var imageURL: String!
    var ingredients = [String]()
    var recipeURL: String!
    
    var subview: UIView!
    
    @IBAction func ingredientsPressed(_ sender: Any) {
        passDataToTableView()
        
    }
    @IBAction func stepsPressed(_ sender: Any) {
        let webVC = storyboard?.instantiateViewController(withIdentifier: "webViewVC") as! WebViewVC
        webVC.urlString = recipeURL
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func likePressed(_ sender: Any) {
        
        let param = ["email": "\(keychain.get("email")!)"]
        
        let recipe = Recipes(imageURL: imageURL!, url: recipeURL!, recipeName: recipeName!, ingredientLines: ingredients, notes: [])
        let likedRecipe = UserRecipe(email: "\(keychain.get("email")!)", recipes: [recipe])
       
        Networking.shared.fetch(route: .saveRecipe, data: likedRecipe, params: param) {_ in
            print("Favorated a recipe")
        }
        
        let alertController = UIAlertController(title: "Liked", message: "Recipe added to your collection!", preferredStyle: .alert)
    
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(ok)
        self.present(alertController, animated: true) { () in
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showIngredientTableView()
        
        recipeNameLabel.text = recipeName
        
        let webVC = storyboard?.instantiateViewController(withIdentifier: "webViewVC") as! WebViewVC
        webVC.urlString = recipeURL
       
        DispatchQueue.main.async {
            self.recipeImageView?.getImageFromURL(url: self.imageURL)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passDataToTableView()
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

}

extension RecipeDetailVC {
    
    func showIngredientTableView() {
        let ingredientTableVC = storyboard?.instantiateViewController(withIdentifier: "ingredientTableVC")
        addChildViewController(ingredientTableVC!)
        
        detailView.addSubview((ingredientTableVC?.view!)!)
        ingredientTableVC?.view.anchorToSuperview()
        detailView.autoresizesSubviews = true
        detailView.clipsToBounds = true

    }
    
    func showStepsWebView() {
        let webViewVC = storyboard?.instantiateViewController(withIdentifier: "webViewVC")
        addChildViewController(webViewVC!)
        detailView.addSubview((webViewVC?.view)!)
    }
    
    func passDataToTableView() {
        if let ingredientTableVC = self.childViewControllers.first as? IngredientTableVC {
            ingredientTableVC.ingredients = ingredients
        }
    }
    
    
}
