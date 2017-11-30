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
    case getRecipe
    case analyzeImage
    
    func path() -> String {
        switch self {
        case .createUser, .getUser:
            return "http://127.0.0.1:5000/users"
        case .saveRecipe, .deleteRecipe:
            return "http://127.0.0.1:5000/recipes"
        case .getRecipe:
            return "https://api.edamam.com/search"
        case .analyzeImage:
            return "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify"
        }
    }
    
    func headers() -> [String: String] {
        switch self {
        case .createUser:
            return [:]
        case .getRecipe:
            let headers = ["app_id": "b50e6417",
                           "app_key":"c845cafa9a669a2a5db0148d11af4e93",
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
        case .createUser:
            return [:]
        case .getRecipe:
            return ["q": "vanilla"]
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
//        case .createUser:
//            guard let model = data as? User else {return nil}
//            let result = try? encoder.encode(model)
//            return result
        default:
//            let error = ["error": "incorrect method"]
//            let jsonErr = try? JSONSerialization.data(withJSONObject: error)
//            return jsonErr
            return nil
        }
    }
    
    func method() -> String {
        switch self {
        case .createUser, .saveRecipe, .analyzeImage:
            return "POST"
        case .deleteRecipe:
            return "DELETE"
        default:
            return "GET"
        }
    }
}



class Networking {
    
    static var shared = Networking()
    
    let session = URLSession.shared
    
    func fetch(route: Route, data: Encodable?, params: [String:String]?, completion: @escaping (Data) -> Void) {
        let base = route.path()
        var url = URL(string: base)!
        
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
                completion(data)
                print("Networking succeeded")
                let statusCode = httpResponse?.statusCode
                print(statusCode)
            }
            else {
                print(err?.localizedDescription ?? "Error")
            }
            
            }.resume()
        
    }
    
//    func uploadImage(route: Route, )
    
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    /**
     Creates a new URL by adding the given query parameters.
     @param parametersDictionary The query parameter dictionary to add.
     @return A new URL.
     */
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
