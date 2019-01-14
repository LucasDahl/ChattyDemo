//
//  ViewController.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/8/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the leftBarButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        // Set the image
        let image = UIImage(named: "new_message_icon")
        
        // Setup the RightBarButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
        
    }
    
    //================
    // MARK: - Actions
    //================
    
    @objc func handleLogout() {
        
        do {
            
            // Signout the user
            try Auth.auth().signOut()
            
        } catch let logoutError {
            
            // Print the error
            print(logoutError)
            
        }
        
        let loginController = LoginController()
        
        // Present the vc
        present(loginController, animated: true, completion: nil)
        
    }

    
    @objc func handleNewMessage() {
        
        // Set the newMessage controller
        let newMessageController = NewMessageController()
        
        // Make the navController
        let navController = UINavigationController(rootViewController: newMessageController)
        
        // Present teh navController
        present(navController, animated: true, completion: nil)
        
    }
    
    //==================
    // MARK: User status
    //==================
    
    func checkIfUserIsLoggedIn() {
        
        // Check if the uid is nil
        if Auth.auth().currentUser?.uid == nil {
            
            // Perform the action to logout
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        } else {
            
            // USer is not logged in
            
            // Create the user ID
            let uid = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    // Set the title of navigation item
                    self.navigationItem.title = dictionary["name"] as? String
                    
                }
                
            }, withCancel: nil)
        }
    }
}// End class

