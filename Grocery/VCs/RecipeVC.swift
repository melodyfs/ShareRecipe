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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RecipeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCell
//        let image = images[indexPath.row]
        
//        cell.pictureImageView?.image = UIImage(contentsOfFile: image.absoluteURL.relativePath)
        
        return cell
    }
    
}
