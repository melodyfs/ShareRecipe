//
//  RecipeNetworking.swift
//  Grocery
//
//  Created by Melody on 11/7/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

class RecipeNetworking {
    var session = URLSession.shared
    let baseURL = "https://developer.edamam.com/edamam-docs-recipe-api"
   
    func getRecipe(url:URL, completion: @escaping (Data) -> Void) {
        var url = URL(string: baseURL )!
        var request = URLRequest(url:url)
        var headers = ["app_id": "b50e6417", "app_key":"c845cafa9a669a2a5db0148d11af4e93"]
        var urlParams = ["q": "Vanilla"]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        url = url.appendingQueryParameters(urlParams)
        
        session.dataTask(with: request) {(data, response,error) in
            if let data = data {
                completion(data)
            }
            else{
                print("Error")
            }
            
        }

        
    }
}

