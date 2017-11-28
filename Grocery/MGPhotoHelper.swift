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
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { [unowned self] action in
                self.presentImagePickerController(with: .camera, from: viewController)
            })
            
            // 4
            alertController.addAction(capturePhotoAction)
        }
        
        // 5
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let uploadAction = UIAlertAction(title: "Upload from Library", style: .default, handler: { [unowned self] action in
                self.presentImagePickerController(with: .photoLibrary, from: viewController)
            })
            
            alertController.addAction(uploadAction)
        }
        
        // 6
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // 7
        viewController.present(alertController, animated: true)
    }
    
    func presentImagePickerController(with sourceType: UIImagePickerControllerSourceType, from viewController: UIViewController) {
    //  Creates instance of UIImagePickerController
    //  UIImagePickerController has a component that will allow users to take or upload an image
        let imagePickerController = UIImagePickerController()
        
    //  Sets the source type to determine whether to display the user's library or camera.
    //  Set by the arguments that are given.
        imagePickerController.sourceType = sourceType
        
        viewController.present(imagePickerController, animated: true)
    }
    
}
