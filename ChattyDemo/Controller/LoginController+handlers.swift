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

extension LoginController {
    
    //==============
    //MARK:- Actions
    //==============
    
    @objc func handSelectedProfileImageView() {
        
        // Create a reference to image picker
        let picker = UIImagePickerController()
        
        // Present the image picker
        present(picker, animated: true, completion: nil)
        
    }
    
    
    
}
