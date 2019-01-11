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
        
        
        // Make the left bar button item(Logout)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        // Create the image for the new message
        let image = UIImage(named: "new_message_icon")
        
        // Create the right bar button item(new message)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        // Check for user being logged in
        checkIfUserIsLoggedIn()
        
    }

    // Check if the user is logged in
    func checkIfUserIsLoggedIn() {
        
        // Check if the user a logged in or not
        if Auth.auth().currentUser?.uid == nil {
            
            // User is not logged in and present the controller after a slight delay
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        } else {
            
            // Get the UID
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                //print(snapshot) // printe user email and name
                
                // Get data out of the snapshot dictionary
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    // Get the users name to display on the navigation bar
                    self.navigationItem.title = dictionary["name"] as? String
                    
                }
                
                
                
            }, withCancel: nil) // Use this method if you are having issues with the complier
            
        }

    }
    
    //================
    // MARK: - Actions
    //================
    
    @objc func handleNewMessage() {
        
        // Make a property for the newMessageController
        let newMessageController = NewMessageController()
        
         // Make a property for the navigationController
        let navController = UINavigationController(rootViewController: newMessageController)
        
        // Present the newMessageController which is a navigationController
        present(navController, animated: true, completion: nil)
        
    }

    // Logout function
    @objc func handleLogout() {
        
        // Signout the user when they logout.
        do {
            
            try Auth.auth().signOut()
            
        } catch {
            
            // Error logging out
            print("Error logging out")
            
        }
        
        
        // Create the LoginViewController
        let loginController = LoginController()
        
        // Present the login viewController
        present(loginController, animated: true, completion: nil)
        
    }
    
}

