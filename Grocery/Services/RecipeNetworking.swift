//
//  RecipeNetworking.swift
//  Grocery
//
//  Created by Melody on 11/7/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

class RecipeNetworking {
    static var sharedInstance = RecipeNetworking()
    var session = URLSession.shared
    let baseURL = "https://api.edamam.com/search"
   
    func getRecipe(completion: @escaping (Data) -> Void) {
        let urlParams = ["q": "vanilla"]
        let headers = ["app_id": "b50e6417",
                       "app_key":"c845cafa9a669a2a5db0148d11af4e93",
                       "Content-Type": "application/json",
                       "Accept": "application/json"]
        
        var url = URL(string: baseURL )!
        url = url.appendingQueryParameters(urlParams)
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
       
        
        session.dataTask(with: request) {(data, response,error) in
            
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                
                completion(data)
                let statusCode = httpResponse?.statusCode
                print(statusCode)
                print("Network succeed")
            } else {
                print(error?.localizedDescription ?? "Error")
            }
            
        }.resume()

        
    }
}

