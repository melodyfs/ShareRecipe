//
//  GetRecipe.swift
//  Grocery
//
//  Created by Melody on 1/16/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation

class GetRecipe {
    
    static var shared = GetRecipe()
    
    let session = URLSession.shared
    
    func fetch(queryParam: String, completion: @escaping (Data) -> Void) {
        let base = "https://api.edamam.com/search?app_id=b50e6417&app_key=c845cafa9a669a2a5db0148d11af4e93&q=\(queryParam)"
        let headers = ["Content-Type": "application/json",
                       "Accept": "application/json"]
        let url = URL(string: base)!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        session.dataTask(with: request) { (data, res, err) in
            let httpResponse = res as? HTTPURLResponse
            if let data = data {
                completion(data)
                print("Get recipe networking succeeded")
                let statusCode = httpResponse?.statusCode
                print(statusCode ?? "")
            }
            else {
                print(err?.localizedDescription ?? "Error")
            }
            
            }.resume()
        
    }
    
}
