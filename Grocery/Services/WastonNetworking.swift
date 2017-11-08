//
//  WastonNetworking.swift
//  Grocery
//
//  Created by Melody on 11/6/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

class WatsonNetworking {
    
    static var shared = WatsonNetworking()
    
    let session = URLSession.shared
    let baseURL = "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify"
    
    func analyzeImage(imageURL: String, completion: @escaping (Data) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "Accept": "application/json"]
        let urlParams = ["api_key": "a33be142c28212ecf61c5fd19f05a76a08e845d7",
                         "version": "2016-05-20",
                         "image_files": ".jpg",
                         "Accept-Language": "en",
                         "url": "\(String(describing: imageURL))"]
        
        var url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        url = url.appendingQueryParameters(urlParams)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"

        
        session.dataTask(with: request) { (data, res, err) in
             let httpResponse = res as? HTTPURLResponse
            if let data = data {
                completion(data)
                let statusCode = httpResponse?.statusCode
                print(statusCode)
            } else {
                print(err?.localizedDescription ?? "Error")
            }
            
        }.resume()
        
    }
    
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


