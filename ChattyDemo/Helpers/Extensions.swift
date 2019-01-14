//
//  Extensions.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/14/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import Foundation
import UIKit

// Image cache property
let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        // Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            
            self.image = cachedImage
            
            return
            
        }
        
        // Otherwise fire off a new download
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            // Download hit an error
            if let error = error {
                
                print("Error getting profile Image \(error)")
                
                return
                
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    // Set the image to the downloaded image for the user profile image
                    self.image = downloadedImage
                    
                }
            })
            
        }).resume()
    }
    
}
