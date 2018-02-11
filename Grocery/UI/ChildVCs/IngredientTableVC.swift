//
//  IngredientTableVC.swift
//  Grocery
//
//  Created by Melody on 12/9/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class IngredientTableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    var ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension IngredientTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientTableCell", for: indexPath) as! IngredientTableCell
        let ingredient = ingredients[indexPath.row]
        
        cell.textLabel?.text = ingredient
        cell.textLabel?.font = UIFont(name:"Avenir", size: 18)
        cell.textLabel?.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.77)
        
        return cell
    }
    
}



