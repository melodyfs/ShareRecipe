//
//  GlobalRecipe.swift
//  Grocery
//
//  Created by Melody on 12/12/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

struct GlobalRecipe: Codable {
    
    var recipeName: String?
    var options: [Options?]
    
}

struct Options: Codable {
    
    var email: String?
    var ingredientOptions: String?
    var note: String?
    
}
