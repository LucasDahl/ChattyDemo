//
//  LoginController+handlers.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/12/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //==============
    //MARK:- Actions
    //==============
    
    @objc func handSelectedProfileImageView() {
        
        // Create a reference to image picker
        let picker = UIImagePickerController()
        
        // Set the delegate
        picker.delegate = self
        
        // Allow the selected image to be editing
        picker.allowsEditing = true
        
        // Present the image picker
        present(picker, animated: true, completion: nil)
        
    }
    
    // User picked an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Convert the info dictionary to be used later
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        // Store the selected image
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            
            // Assign the image property
            selectedImageFromPicker = editedImage
            
        } else if let orginalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            // Assign the image property
            selectedImageFromPicker = orginalImage

        }
        
        // Assign either the selected image or the editied image to the imageView
        if let selectedImage = selectedImageFromPicker {
            
            // Set the imageView with the image
            profileImageView.image = selectedImage
            
        }
        
        // Dimisiss the controller after and image is selected
        dismiss(animated: true, completion: nil)
        
    }
    
    // User cancelled the image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
        
    }
    
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
