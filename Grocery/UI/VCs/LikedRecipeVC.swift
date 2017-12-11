//
//  LIkedRecipeVC.swift
//  Grocery
//
//  Created by Melody on 12/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class LikedRecipeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var likedRecipes = [UserRecipe]()
    var recipes = [Recipes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        fetchRecipes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecipes()
    }
   

}

extension LikedRecipeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likedRecipeCell", for: indexPath) as! LikedRecipeCell
        let recipe = recipes[indexPath.row]

        cell.recipeName.text = recipe.recipeName
        
        DispatchQueue.main.async {
//            cell.recipeImageView.getImageFromURL(url: recipe.image!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionsVC = storyboard?.instantiateViewController(withIdentifier: "optionsVC") as! OptionsVC
        let recipe = recipes[indexPath.row]
        
        optionsVC.recipeName = recipe.recipeName
        optionsVC.imageURL = recipe.image
        optionsVC.ingredients = recipe.ingredientLines as! [String]
        optionsVC.recipeURL = recipe.url
        optionsVC.recipes = recipes
        
        self.navigationController?.pushViewController(optionsVC, animated: true)
    }
}

extension LikedRecipeVC {
    
    func fetchRecipes() {
        let param = ["email": "\(keychain.get("email")!)"]
        Networking.shared.fetch(route: .retrieveRecipe , data: nil, params: param) { recipe in
            guard let likedRecipe = try? JSONDecoder().decode(UserRecipe.self, from: recipe) else {return}
            self.recipes = likedRecipe.recipes
            print(self.recipes)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
       
    }
    
}
