//
//  Upload+CompareHelper.swift
//  Grocery
//
//  Created by Melody on 12/2/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import UIKit

extension AnalyzePhotoVC {
    
    func uploadPhoto() {
        
        UploadImage.upload(file: imageUrl!) { data in
            let image = try? JSONDecoder().decode(ImageClass.self, from: data)
            
            var allValues = [ImageClass]()
            guard let value0 = image?.images[0].classifiers[0].classes[0].classValue else {return}
            print(value0)
            guard let value1 = image?.images[0].classifiers[0].classes[1].classValue else {return}
            print(value1)
            guard let value2 = image?.images[0].classifiers[0].classes[2].classValue else {return}
            print(value2)
            guard let value3 = image?.images[0].classifiers[0].classes[3].classValue else {return}
            print(value3)
            guard let value4 = image?.images[0].classifiers[0].classes[4].classValue else {return}
            print(value4)
            guard let value5 = image?.images[0].classifiers[0].classes[5].classValue else {return}
            print(value5)
            guard let value6 = image?.images[0].classifiers[0].classes[6].classValue else {return}
            print(value6)
            
//            allValues += [value0, value1, value2, value3, value4, value5, value6]
//            allValues.sort { $0 < $1 }
//            self.classValues = allValues.endIndex
            
        }
    }
    
    
}

