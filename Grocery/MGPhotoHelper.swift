//
//  MGPhotoHelper.swift
//  Grocery
//
//  Created by Mac on 11/27/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class MGPhotoHelper: NSObject {
    
    // MARK: - Properties
    
//    Runs after user selects image
    var completionHandler: ((UIImage) -> Void)?
    
    // MARK: - Helper Methods
    
    // Displays popover to upload an image or take one
    func presentActionSheet(from viewController: UIViewController) {
        // 1 Initilize a new UIAlertController, as an action sheet
        
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .actionSheet)
        
        // 2
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // 3
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { action in
                // do nothing yet...
            })
            
            // 4
            alertController.addAction(capturePhotoAction)
        }
        
        // 5
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let uploadAction = UIAlertAction(title: "Upload from Library", style: .default, handler: { action in
                // do nothing yet...
            })
            
            alertController.addAction(uploadAction)
        }
        
        // 6
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // 7
        viewController.present(alertController, animated: true)
    }
}
