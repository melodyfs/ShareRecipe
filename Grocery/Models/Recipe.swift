//
//  Recipe.swift
//  Grocery
//
//  Created by Melody on 11/7/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
//import Gloss
//
//struct Recipe

struct Recipe: Decodable {

    var image: String?
    var url : String?
    var label: String?
    var ingredientLines = [String?]()

//    ingredientLines:[String]
//    var recipes = [Recipe]()


    init(image: String, url: String, label: String, ingredientLines: [String]) {
        self.image = image
        self.url = url
        self.label = label
//        self.recipes = recipes
        self.ingredientLines = ingredientLines
    }
}

//extension Recipe {
//
//    enum Hits: String, CodingKey {
//        case recipe
//
//        enum Recipe: String, CodingKey{
//            case label
//        }
//
//    }
//
//
//    init(from decoder: Decoder) throws {
//        var container = try decoder.container(keyedBy: Hits.self)
//        var recipeContainer = try container.nestedUnkeyedContainer(forKey: .recipe)
//        print(recipeContainer.count)
//
//        while !recipeContainer.isAtEnd {
//            let container = try recipeContainer.nestedContainer(keyedBy: Hits.Recipe.self)
//            let label = try container.decode(String.self, forKey: .label)
////            let destination = try container.decode(String.self, forKey: .destination)
////            let startDate = try container.decode(String.self, forKey: .start_date)
////            let endDate = try container.decode(String.self, forKey: .end_date)
//
//            // initialize a listing object
////            let trip = Trip(completion: completion, destination: destination, start_date: startDate, end_date: endDate)
//            let recipe = Recipe(label: label)
//            self.recipes.append(recipe)
//        }
//    }
//
//}

struct RecipeList: Decodable {
    let hits: [Recipe]
}

extension Recipe {
    enum HitsCodingKeys: String, CodingKey {
        case recipe

    }
    enum RecipeCodingKeys: String, CodingKey {
        case label
        case image
        case url
        case ingredientLines
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HitsCodingKeys.self)
        let recipeContainer = try container.nestedContainer(keyedBy: RecipeCodingKeys.self, forKey: .recipe)

        let image: String = try recipeContainer.decode(String.self, forKey: .image)
        let url: String = try recipeContainer.decode(String.self, forKey: .url)
        let label: String = try recipeContainer.decode(String.self, forKey: .label)
        let ingredientLines: [String] = try recipeContainer.decode([String].self, forKey: .ingredientLines)

        self.init(image: image, url: url, label: label, ingredientLines: ingredientLines)
    }


}
//
//
