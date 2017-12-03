//
//  CameraVC.swift
//  Grocery
//
//  Created by Melody on 11/28/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
import Photos

class AnalyzePhotoVC: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var classValues = [String]()
    var imageUrl = URL(string: "")
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
    }
    
    @IBAction func openLibraryTapped(_ sender: Any) {
//        let photoHelper = PhotoHelper()
//        photoHelper.presentActionSheet(from: self)
        openPhotoLibrary()
    }
    
    @IBAction func openCameraTapped(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func analyzeTapped(_ sender: Any) {
        uploadPhoto()
        
        DispatchQueue.main.async {
            let v = self.classValues.joined(separator: ", ")
            self.ingredientLabel.text = v
        }
       
    }
}

extension AnalyzePhotoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageURL = info[UIImagePickerControllerReferenceURL] as? URL
        let imageName = imageURL?.lastPathComponent
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let path = cacheDir.appendingPathComponent(imageName!)
        
        if !FileManager.default.fileExists(atPath: path.path) {
            do {
                try UIImageJPEGRepresentation(image!, 0.3)?.write(to: path)
                print("file saved")
            }catch {
                print("error saving file")
            }
        }
        else {
            print("file already exists")
        }
        
       
        picker.dismiss(animated: true)
        
        imageView.image = image
        imageUrl = path
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
        
        print("did cancel")
    }
}


