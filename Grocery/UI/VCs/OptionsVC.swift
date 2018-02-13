//
//  OptionsVC.swift
//  Grocery
//
//  Created by Melody on 12/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class OptionsVC: UIViewController {
   
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var recipes = [Recipes]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var recipeName: String!
    var imageURL: String!
    var ingredients = [String]()
    var ingredients2 = [String]()
    var recipeURL: String!
    
    var notes: String!
    var notesArr = [String]()
    var options = [Options]()
    var n = [Notes?]()
    var optionCount = 0
    
    @IBAction func addNotes(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Some Notes", message: "What other ingredient did you add?", preferredStyle: .alert)
       
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "Other ingredients"
        }
        
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "Add some notes"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
        }
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in

            let textField1 = alertController.textFields?.first?.text
            let textField2 = alertController.textFields?[1].text

            let newNote = Notes(ingredientOptions: textField1, note: textField2)
            let param = ["email": "\(keychain.get("email")!)", "recipeName": self.recipeName!]
            
            let sharingOption = Options(email:"\(keychain.get("email")!)", ingredientOptions: textField1!, note: textField2!)
            let sharingNote = GlobalRecipe(recipeName: self.recipeName!, options: [sharingOption])
            
            Networking.shared.fetch(route: .saveNote, data: newNote, params: param) { _ in}
            Networking.shared.fetch(route: .shareNote, data: sharingNote, params: [:]) {_ in}
            self.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func ingredientsPressed(_ sender: Any) {
        ingredients = ingredients2
        collectionStack.removeArrangedSubview(collectionView)
        self.tableView.reloadData()
    }
    
    @IBAction func stepsPressed(_ sender: Any) {
        
        let webVC = storyboard?.instantiateViewController(withIdentifier: "webViewVC") as! WebViewVC
        webVC.urlString = recipeURL
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func notesPressed(_ sender: Any) {
        let param = ["email": "\(keychain.get("email")!)", "recipeName": recipeName!]
        collectionStack.removeArrangedSubview(collectionView)
        
        ingredients = notesArr
        self.tableView.reloadData()
    }
    
    @IBAction func optionsPressed(_ sender: Any) {
        if optionCount == 0 {
            informNoMethod()
        } else {
            collectionStack.insertArrangedSubview(collectionView, at: 0)
        }
    }
    
    func informNoMethod() {
        let alertController = UIAlertController(title: "No other methods from other cooks yet", message: "Share yours and check back often! ", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true) { () in
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 50.0
        
        recipeNameLabel.text = recipeName
        collectionView.allowsMultipleSelection = false
        recipeImageView.getImageFromURL(url: self.imageURL)
        collectionStack.removeArrangedSubview(collectionView)
       
        Networking.shared.fetch(route: .getGlobalRecipe, data: nil, params: ["recipeName": recipeName]) { data in
            guard let notes = try? JSONDecoder().decode(GlobalRecipe.self, from: data) else {return}
            self.options = (notes.options) as! [Options]
            print(self.options)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.optionCount = notes.options.count
                self.collectionView.reloadData()
            }
            
        }
        
    }

}

extension OptionsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return optionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as! OptionCell
        
        cell.numberLabel.text = "Other Method" + String(indexPath.item + 1)
        roundedCell(cell: cell)
        
        return cell
    }
    
    func roundedCell(cell: OptionCell) {
        cell.layer.cornerRadius = cell.frame.size.width/2
        cell.layer.backgroundColor = UIColor(red:0.72, green:0.72, blue:0.72, alpha:1.0).cgColor
        cell.layer.masksToBounds = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        ingredients = [option.ingredientOptions!, option.note!]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor = UIColor(red:0.72, green:0.72, blue:0.72, alpha:0.5).cgColor

        tableView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor = UIColor(red:0.72, green:0.72, blue:0.72, alpha:1.0).cgColor
        
    }
}

extension OptionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        
        cell.textLabel?.text = ingredient
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 3
    
        return cell
    }
    
}
