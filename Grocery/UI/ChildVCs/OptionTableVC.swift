//
//  OptionTableVC.swift
//  Grocery
//
//  Created by Melody on 12/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class OptionTableVC: UIViewController {
    
//    func passData(data: String) {
//        ingredientOptions = data
//    }
    

    @IBOutlet weak var tableView: UITableView!
    
    var ingredients = [String]()
    var recipes = [Recipes]()
    var ingredientOptions: String!
    var notes: String!
    
//    var delegate 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    

}

extension OptionTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionTableCell", for: indexPath) as! OptionTableCell
        let ingredient = ingredients[indexPath.row]
        
        cell.textLabel?.text = ingredient
        
        if ingredientOptions != nil && notes != nil {
            cell.textLabel?.text = ingredientOptions
            cell.detailTextLabel?.text = notes
        }
        
        return cell
    }
    
}
