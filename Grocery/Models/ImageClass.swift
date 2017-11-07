//
//  ImageClass.swift
//  Grocery
//
//  Created by Melody on 11/6/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

struct ImageClass: Codable {
//    var class_ : String
    var class_: String
//
    struct Class: Codable {
        var class_: String

        enum CodingKeys: String, CodingKey {
            case class_ = "class"
        }
    }
//    init(class_: String) {
//        self.class_ = class_
//    }
}



struct ImageClassService: Codable {
    var images: [Classifiers]
    
    struct Classifiers: Codable {
        var classifiers: [Classes]

    struct Classes: Codable {
        var class_: String
        
        enum CodingKeys: String, CodingKey {
            case class_ = "class"
        }
    }
}

}
//
//struct List: Codable {
//    let list: [ImageClass]
//}
//
//
//extension ImageClass {
//    init(from service: ImageClassService) {
//        class_ = []
//
//        for classifier in service.images {
//            for clas in classifier.classifiers{
//                class_ = clas.class_
//            }
//        }
        
//    }
//    self.init(class_: class_)
//}


//struct Classifier: Codable {
//    let classifier: [ImageClass]
//}
//
//struct Classes: Codable {
//    let classe: [Classifier]
//}

extension ImageClass {

    enum ClassifierKeys: String, CodingKey {
        case classes
    }

    enum ClassKeys: String, CodingKey {
        case class_ = "class"
    }

     init(from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: ClassifierKeys.self)
        let classContainer = try container.nestedContainer(keyedBy: ClassKeys.self, forKey: .classes)

        let class_: String = try classContainer.decode(String.self, forKey: .class_)

        self.init(class_: class_)

    }


}


