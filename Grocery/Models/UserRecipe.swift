//
//  UserRecipe.swift
//  Grocery
//
//  Created by Melody on 12/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

struct UserRecipe: Codable {
//    var  _id: String?
    var email: String?
    var recipes: [Recipes]

}

struct Recipes: Codable {
    var imageURL: String?
    var url : String?
    var recipeName: String?
    var ingredientLines = [String?]()
    var notes = [Notes?]()
}

struct Notes: Codable {
    var ingredientOptions: String?
    var note: String?
}

