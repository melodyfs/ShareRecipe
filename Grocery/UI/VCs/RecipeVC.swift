//
//  RecipeVC.swift
//  Grocery
//
//  Created by Melody on 11/21/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout


class RecipeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var availableView: UIView!
    @IBOutlet var emptyView: UIView!
    
    @IBOutlet weak var searchField: UITextField!
    var recipes = [Recipe]()

    @IBAction func searchPressed(_ sender: Any) {
        
        let input = searchField.text
        let ingredientTableVC = IngredientTableVC()
        
        GetRecipe.shared.fetch(queryParam: input!) { data in
            let recipeList = try? JSONDecoder().decode(RecipeList.self, from: data)
            guard let recipe = recipeList?.hits else { return }
            self.recipes = recipe
//            print(self.recipes)

            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.emptyView.removeFromSuperview()
                self.view.addSubview(self.availableView)
                self.availableView.anchorToSuperview()
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(emptyView)
        emptyView.anchorToSuperview()
        
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 40)
        
        searchField.backgroundColor = UIColor(red:0.49, green:0.76, blue:0.05, alpha:0.2)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
}

extension RecipeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
    
        cell.recipeNameLabel.text = recipe.label
        cell.recipeNameLabel.layer.cornerRadius = 5
        cell.recipeNameLabel.layer.masksToBounds = true
       
        DispatchQueue.main.async {
            cell.recipeImageView?.getImageFromURL(url: recipe.image!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let recipeDetailVC = storyboard?.instantiateViewController(withIdentifier: "recipeDetailVC") as! RecipeDetailVC
        
        recipeDetailVC.recipeName = recipe.label!
        recipeDetailVC.imageURL = recipe.image
        recipeDetailVC.ingredients = recipe.ingredientLines as! [String]
        recipeDetailVC.recipeURL = recipe.url
        
        self.navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
    
    
}





