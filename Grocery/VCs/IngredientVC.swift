//
//  IngredientVC.swift
//  Grocery
//
//  Created by Melody on 11/21/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class IngredientVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func seeRecipeTapped(_ sender: Any) {
 
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destinationVC = segue.destination as? RecipeVC {
//           destinationVC.recipes = recipes
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension IngredientVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientCell
//        let collection = collections[indexPath.row]
//
//        cell.collectionNameLabel.text = collection.collection_name
//        cell.delegate = self
//        cell.configureCell(collection: collection)
//
        return cell
    }
    
}
