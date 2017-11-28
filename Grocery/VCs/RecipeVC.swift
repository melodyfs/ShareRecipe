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
    
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //TODO: Pass ingredient to params
        
        Networking.shared.fetch(route: .getRecipe, data: nil, params: [:]) { data in
            let recipeList = try? JSONDecoder().decode(RecipeList.self, from: data)
            guard let recipe = recipeList?.hits else { return }
            self.recipes = recipe
            print(self.recipes)
        
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
        
        DispatchQueue.main.async {
            cell.recipeImageView?.getImageFromURL(url: recipe.image!)
        }
        
        return cell
    }
    
}
