//
//  ImageClass.swift
//  Grocery
//
//  Created by Melody on 11/6/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

struct ImageClass: Codable {
    let images: [Images]
    
    struct Images: Codable {
        let classifiers: [Classifiers]
    
        struct Classifiers: Codable {
            let classes: [Classes]
        
            struct Classes: Codable {
                var score: Float
                var classValue: String?
                
                private enum CodingKeys: String, CodingKey {
                    case classValue = "class"
                    case score
                }
            }
        }
    }
}
