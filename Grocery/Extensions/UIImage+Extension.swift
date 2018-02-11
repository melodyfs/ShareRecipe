//
//  UIImageExtension.swift
//  DocManagement
//
//  Created by Melody on 11/2/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func getImageFromURL(url: String) {
        let url = URL(string: url)!
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let data = data {
                
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data:data) {
                        imageCache.setObject(downloadedImage, forKey: url as AnyObject)
                        self.image = downloadedImage
                    }
                    
                }
            }
            else {
                print(err?.localizedDescription ?? "Error")
            }
            
            }.resume()
    }
    
    func roundCornersForAspectFit(radius: CGFloat)
    {
        if let image = self.image {
            
            //calculate drawingRect
            let boundsScale = self.bounds.size.width / self.bounds.size.height
            let imageScale = image.size.width / image.size.height
            
            var drawingRect: CGRect = self.bounds
            
            if boundsScale > imageScale {
                drawingRect.size.width =  drawingRect.size.height * imageScale
                drawingRect.origin.x = (self.bounds.size.width - drawingRect.size.width) / 2
            } else {
                drawingRect.size.height = drawingRect.size.width / imageScale
                drawingRect.origin.y = (self.bounds.size.height - drawingRect.size.height) / 2
            }
            let path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
}



extension UIView {
    func anchorToSuperview() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
    }
}


