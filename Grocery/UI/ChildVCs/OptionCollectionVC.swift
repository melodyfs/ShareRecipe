//
//  ScrollCollectionVC.swift
//  Grocery
//
//  Created by Melody on 12/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
//import InfiniteCollectionView

//protocol OptionCollectionDelegate {
//    func passData(data: String)
//}

class OptionCollectionVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var recipes = [Recipes]()
    
//    var delegate: OptionCollectionDelegate?
    
//    let optionCollection = OptionCollectionVC()
//    let optionTable = OptionTableVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
//        optionCollection.delegate = optionTable
    }
    
   
    
}

extension OptionCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as! OptionCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        
//        optionCollection.delegate?.passData(data: (recipe.notes[indexPath.row]?.ingredientOptions)!)
//        optionCollection.delegate?.passData(data: (recipe.notes[indexPath.row]?.note)!)
        
//        let optionTable = storyboard?.instantiateViewController(withIdentifier: "optionTableVC") as! OptionTableVC
//
//        optionTable.ingredientOptions = recipe.notes[indexPath.row]?.ingredientOptions
//        optionTable.notes = recipe.notes[indexPath.row]?.note
//
//        self.present(optionTable, animated: false)
    }
    
    
    
    
}
