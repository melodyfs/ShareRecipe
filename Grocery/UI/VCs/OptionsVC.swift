//
//  OptionsVC.swift
//  Grocery
//
//  Created by Melody on 12/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class OptionsVC: UIViewController {
   
//    @IBOutlet weak var scrollView: UIView!
//    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var recipes = [Recipes]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var recipeName: String!
    var imageURL: String!
    var ingredients = [String]()
    var recipeURL: String!
//    var userRecipes = [Recipes]()
    
    var notes: String!
    var notesArr = [String]()
    var options = [Options]()
    
//    func passData(data: String) {
//        print("got data")
//    }
    
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
            Networking.shared.fetch(route: .saveNote, data: newNote, params: param) { _ in}
            
        }
        
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func ingredientsPressed(_ sender: Any) {
        collectionStack.insertArrangedSubview(collectionView, at: 0)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        recipeNameLabel.text = recipeName
        
        DispatchQueue.main.async {
            self.recipeImageView.getImageFromURL(url: self.imageURL)
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
        
        Networking.shared.fetch(route: .getGlobalRecipe, data: nil, params: ["recipeName": "Cupcake"]) { data in
            let notes = try? JSONDecoder().decode(GlobalRecipe.self, from: data)
            self.options = (notes?.options)! as! [Options]
            print(self.options)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension OptionsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return notesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        ingredients = [option.ingredientOptions!, option.note!]
        tableView.reloadData()
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
    
        return cell
    }
    
}
