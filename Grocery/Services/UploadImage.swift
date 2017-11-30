//
//  UploadImage.swift
//  Grocery
//
//  Created by Melody on 11/29/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import Alamofire

class UploadImage {
    
    static func upload(file: URL, completion: @escaping (Data) -> Void ) {
        let session = URLSession.shared
        
        var url = URL(string: "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify")!
        let params = ["api_key": "a33be142c28212ecf61c5fd19f05a76a08e845d7",
                                  "version": "2016-05-20",
                                  "Accept-Language": "en"]
        let fileURL = file.lastPathComponent
        
        let urlParam = ["images_file": fileURL]
        url = url.appendingQueryParameters(params)
        url = url.appendingQueryParameters(urlParam)
       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField:  "Content-Type")
        
        session.uploadTask(with: request, fromFile: file) { (data, res, err) in
        
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
}
