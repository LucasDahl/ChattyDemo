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
        
        // Check if the user a logged in or not
        if Auth.auth().currentUser?.uid == nil {
            
            // User is not logged in and present the controller after a slight delay
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        }
        
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

