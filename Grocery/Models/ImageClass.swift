//
//  ImageClass.swift
//  Grocery
//
//  Created by Melody on 11/6/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import Gloss

//struct Classes: Codable {
//    var classes:[JSON]
//
////    init(classValue: String) {
////        self.classValue = classValue
////    }
//}

struct Classes: Glossy, Codable {
    var classValue: String?
//    var imageClassValue: String?
    var score: Float?
//    var custom_classes: Int?

    init?(json: JSON) {
//        guard let classValue: String = "class" <~~ json else {
//            return nil
//        }
//        self.custom_classes = "custom_classes" <~~ json
        guard let classValue: String = "class" <~~ json else {return}
//            let classValue = [ClassValue].from(jsonArray: classes) {
//            self.classes = classValue
//        }

//        self.classValue = "class" <~~ json
//        self.score = "classes.score" <~~ json
        self.classValue = classValue
    }

    func toJSON() -> JSON? {
        return jsonify([
            "classes.class" ~~> self.classValue,
            "classes.score" ~~> self.score,
//            "custom_classes" ~~> self.custom_classes
            ])
    }

}

struct ImageClass: Codable {
    let classes: Classes
    
    init?(json: JSON) {
        guard let dataJSON = json["classes"] as? JSON, let classes: Classes = "class" <~~ dataJSON
            else {
                return nil
        }
        
        self.classes = classes
    }
}
//
//struct ImageClass: Codable {
//    var classValue: String?
//
//    init(classValue: String) {
//        self.classValue = classValue
//    }
//
//}


//struct ImageClass: Codable {
////    var class_ : String
//    var class_: String
////
//    struct Class: Codable {
//        var class_: String
//
//        enum CodingKeys: String, CodingKey {
//            case class_ = "class"
//        }
//    }
////    init(class_: String) {
////        self.class_ = class_
////    }
//}
//
//
//
//struct ImageClassService: Codable {
//    var images: [Classifiers]
//
//    struct Classifiers: Codable {
//        var classifiers: [Classes]
//
//    struct Classes: Codable {
//        var class_: String
//
//        enum CodingKeys: String, CodingKey {
//            case class_ = "class"
//        }
//    }
//}
//}


//
//struct List: Codable {
//    let list: [ImageClass]
//}
//
//
//extension ImageClass {
//    init(from service: ImageClassService) {
////        class_ = []
//
//        for classifier in service.images {
//            for clas in classifier.classifiers{
//                class_ = clas.class_
//            }
//        }
//         self.init(class_: class_)
//    }
//
//}


//struct Classifier: Codable {
//    let classifier: [ImageClass]
//}
//
//struct Classes: Codable {
//    let classe: [Classifier]
//}

//extension ImageClass {
//
//    enum ClassifierKeys: String, CodingKey {
//        case classes
//    }
//
//    enum ClassKeys: String, CodingKey {
//        case class_ = "class"
//    }
//
//     init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: ClassifierKeys.self)
//        let classContainer = try container.nestedContainer(keyedBy: ClassKeys.self, forKey: .classes)
//
//        let classValue: String = try classContainer.decode(String.self, forKey: .class_)
//
//        self.init(classValue: classValue)
//
//    }
//
//
//}


