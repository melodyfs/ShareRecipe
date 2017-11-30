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
        openPhotoLibrary()
    }
    
    @IBAction func openCameraTapped(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func analyzeTapped(_ sender: Any) {
        
        UploadImage.upload(file: imageUrl!) { data in
            let image = try? JSONDecoder().decode(ImageClass.self, from: data)

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
            
            self.classValues += [value0, value1, value2, value3, value4, value5, value6]
            
        }
        
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


