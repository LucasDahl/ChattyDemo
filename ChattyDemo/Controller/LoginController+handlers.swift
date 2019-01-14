//
//  LoginController+handlers.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/12/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleRegister() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            
            print("Form is not valid")
            
            return
            
        }
        
        // Create a user
        Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
            
            if let error = error {
                
                print(error)
                
                return
                
            }
            
            guard let uid = res?.user.uid else {
                return
            }
            
            //successfully authenticated user
            
            // Makes a new image string
            let imageName = NSUUID().uuidString
            
            // Get a ref to save the image in the storage
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
            
            // Check if the data is nil
            if let uploadData = self.profileImageView.image!.pngData() {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
                    
                    if let error = error {
                        
                        // Print the error
                        print(error)
                        
                        return
                        
                    }
                    
                    storageRef.downloadURL(completion: { (url, err) in
                        if let err = err {
                            
                            // Print the error
                            print(err)
                            
                            return
                            
                        }
                        
                        // Check if the URL is nl
                        guard let url = url else { return }
                        
                        // Set the values to be used
                        let values = ["name": name, "email": email, "profileImageUrl": url.absoluteString]
                        
                        // Register the user based on the data given
                        self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                        
                    })
                    
                })
            }
        })
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        
        // Get a ref to the Database
        let ref = Database.database().reference(fromURL: "https://chattydemo-9e0ce.firebaseio.com/")
        
        // Get a ref to the users ref
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                
                // Print the error
                print(err)
                
                return
                
            }
            
            // Call the messagecontroller method of setting th titlebar
            self.messagesController?.fetchUserAndSetupNavBarTitle()
            
            // Dismiss the viewController
            self.dismiss(animated: true, completion: nil)
            
        })
    }
    
    @objc func handleSelectProfileImageView() {
        
        // Setup the image picker
        let picker = UIImagePickerController()
        
        // Set the delegate
        picker.delegate = self
        
        // Allow editing on the images
        picker.allowsEditing = true
        
        // Present the image picker
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        // This vsr will be reassigned when the user selcts an image
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            
            // USe the edited image
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            // Use the selected image
            selectedImageFromPicker = originalImage
            
        }
        
        if let selectedImage = selectedImageFromPicker {
            
            // Set the profile image
            profileImageView.image = selectedImage
            
        }
        
        // Dismiss the viewController
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the viewController
        dismiss(animated: true, completion: nil)
        
    }
    
}

//================
// MARK: - Helpers
//================

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
