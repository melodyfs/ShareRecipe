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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension IngredientTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientTableCell", for: indexPath) as! IngredientTableCell
        
        cell.textLabel?.text = "Egg"
        
        return cell
    }
    
    
    
}
