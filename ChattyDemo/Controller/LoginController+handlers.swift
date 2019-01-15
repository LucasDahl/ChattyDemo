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
        
        // try and create the user
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            // There was an error creating the user
            if error != nil {
                print(error!)
                return
            }
            
            // Create the user ID from firebase
            guard let uid = user?.user.uid else { return }
            
            // Successfully authenticated user
            let imageName = UUID().uuidString
            
            // Get a ref to the storage
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            // Set the profileImag, register it, and compress it
            if let profileImage = self.profileImageView.image, let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    storageRef.downloadURL(completion: { (url, err) in
                        if let err = err {
                            print(err)
                            return
                        }
                        
                        guard let url = url else { return }
                        let values = ["name": name, "email": email, "profileImageUrl": url.absoluteString]
                        
                        // Set the values for the user to be registered
                        self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                        
                    })
                    
                })
            }
        })
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        
        // Get a ref to the firebase
        let ref = Database.database().reference(fromURL: "https://chattydemo-9e0ce.firebaseio.com/")

        // Get a ref to the users
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
            // Get teh users name to set the title
            let user = User(dictionary: values)
            self.messagesController?.setupNavBarWithUser(user)
            
            // Dimiss the viewController
            self.dismiss(animated: true, completion: nil)
            
        })
    }
    
    @objc func handleSelectProfileImageView() {
        
        // Setup the image picker
        let picker = UIImagePickerController()
        
        // Set teh delegate
        picker.delegate = self
        
        // Allow for editing of the images
        picker.allowsEditing = true
        
        // Present the picker
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        // Set a var for the selected image
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
            
        }
        
        if let selectedImage = selectedImageFromPicker {
            
            // Set the profile image to the selected image
            profileImageView.image = selectedImage
            
        }
        
        // Dismiss the viewController
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dimiss the viewController
        dismiss(animated: true, completion: nil)
        
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
