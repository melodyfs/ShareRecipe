//
//  Recipe.swift
//  Grocery
//
//  Created by Melody on 11/7/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation


struct Recipe: Decodable {

    var image: String?
    var url : String?
    var label: String?
    var ingredientLines = [String?]()


    init(image: String, url: String, label: String, ingredientLines: [String]) {
        self.image = image
        self.url = url
        self.label = label
        self.ingredientLines = ingredientLines
    }
}

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

