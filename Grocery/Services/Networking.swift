//
//  Networking.swift
//  Grocery
//
//  Created by Melody on 11/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import KeychainSwift


let keychain = KeychainSwift()

enum Route {
    case createUser
    case getUser
    case saveRecipe
    case deleteRecipe
    case getRecipe(query: String)
    case analyzeImage
    case shareNote
    case retrieveRecipe // retrieve user's own notes
    case saveNote
    case getGlobalRecipe // get recipe variations
    //10.206.106.47
    //127.0.0.1
    func path() -> String {
        
        switch self {
        case .createUser, .getUser:
            return "https://sharecipe-app.herokuapp.com/users" // replace 127.0.0.1 with IP address
        case .saveRecipe, .deleteRecipe, .retrieveRecipe, .saveNote:
            return "https://sharecipe-app.herokuapp.com/recipes"
        case let .getRecipe(query):
            return "https://api.edamam.com/search?app_id=b50e6417&app_key=c845cafa9a669a2a5db0148d11af4e93&q=\(query)"
        case .shareNote, .getGlobalRecipe:
            return "https://sharecipe-app.herokuapp.com/global_recipes"
        case .analyzeImage:
            return "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify"
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .getUser, .retrieveRecipe, .saveNote:
            let headers = ["Content-Type": "application/json",
                           "Accept": "application/json",
                           "Authorization": String(describing: keychain.get("BasicAuth")!)]
            return headers
        case .getRecipe:
            let headers = [
                           "Content-Type": "application/json",
                           "Accept": "application/json"]
            return headers
        case .analyzeImage:
            return ["Content-Type": ""]
        default:
            let headers = ["Content-Type": "application/json",
                           "Accept": "application/json"]
            return headers
        }
        
    }
    
    func urlParams() -> [String: String] {
        
        switch self {
        case .createUser, .getGlobalRecipe:
            return [:]
        case .getUser, .retrieveRecipe, .saveNote:
            return  ["email": "\(keychain.get("email")!)"]
        case .getRecipe:
            return ["q": "vallina"]
        case .analyzeImage:
            let urlParams = ["api_key": "a33be142c28212ecf61c5fd19f05a76a08e845d7",
                             "version": "2016-05-20",
                             "image_files": ".jpg",
                             "Accept-Language": "en",
                             //TODO: pass in dynamic ImageURL
                             "url": "https://www.edamam.com/web-img/58a/58a93a8d0c48110ac1c59e3b6e82a9ef.jpg"]
            
            return urlParams
        default:
            let urlParams = ["email": String(describing: keychain.get("email")!)]
            return urlParams
        }
    }
    
    func body(data: Encodable?) -> Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .createUser:
            guard let model = data as? User else {return nil}
            let result = try? encoder.encode(model)
            return result
        case .saveRecipe:
            guard let model = data as? UserRecipe else {return nil}
            let result = try? encoder.encode(model)
            return result
        case .saveNote:
            guard let model = data as? Notes else {return nil}
            let result = try? encoder.encode(model)
            return result
        case .shareNote:
            guard let model = data as? GlobalRecipe else {return nil}
            let result = try? encoder.encode(model)
            return result
        default:
            return nil
        }
    }
    
    func method() -> String {
        switch self {
        case .createUser, .analyzeImage, .shareNote, .saveRecipe, .saveNote:
            return "POST"
        case .deleteRecipe:
            return "DELETE"
        default:
            return "GET"
        }
    }
}

var status = 0

class Networking {
    
    static var shared = Networking()
    
    let session = URLSession.shared
    var statusCode = 0
    
    func fetch(route: Route, data: Encodable?, params: [String:String]?, completion: @escaping (Data) -> Void) {
        let base = route.path()
        var url = URL(string: base)!
//        var q = params?.values
        
        if (params?.isEmpty)! {
            url = url.appendingQueryParameters(route.urlParams())
        }
        url = url.appendingQueryParameters(params!)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = route.headers()
        request.httpBody = route.body(data: data)
        request.httpMethod = route.method()
        
        session.dataTask(with: request) { (data, res, err) in
            let httpResponse = res as? HTTPURLResponse
            if let data = data {
                self.statusCode = (httpResponse?.statusCode)!
                print(self.statusCode)
                completion(data)
                print("Networking succeeded")
            }
            else {
                print(err?.localizedDescription ?? "Error")
            }
            
            }.resume()
        
    }
    
}


