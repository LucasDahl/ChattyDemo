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
        
        // Get th loginController
        let loginController = LoginController()
        
        // Set the loginController to the messageController
        loginController.messagesController = self
        
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
            
          fetchUserAndSetupNavBarTitle()
            
        }
    }
    
    func fetchUserAndSetupNavBarTitle() {
        
        // Create the user ID
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
               
                // Set the title of navigation item
                let user = User(dictionary: dictionary)
                self.setupNavBarWithUser(user)
                
            }
            
        }, withCancel: nil)
        
    }
    
    func setupNavBarWithUser(_ user: User) {
        
        // Setup the title view
        let titleView = UIView()
        
        // Setup the frame
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        // Setup the containerView
        let containerView = UIView()
        
        // Allows access to use auto-layout constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the contrianer to the subview
        titleView.addSubview(containerView)
        
        // Get and set the profile image
        let profileImageView = UIImageView()
        
        // Allows access to use auto-layout constraints
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the aspect ratio
        profileImageView.contentMode = .scaleAspectFill
        
        // Add a croner radius
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        
        // Makesure it's not nil
        if let profileImageUrl = user.profileImageUrl {
            
            // Set the image
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
            
        }
        
        // Add the image to the subview
        titleView.addSubview(profileImageView)
        
        // Set the constraints
        // x, y, width, height anchors
        profileImageView.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
       // Setup the name label
        let nameLabel = UILabel()
        
        // Add the nameLabel
        containerView.addSubview(nameLabel)
        
         // Set the name label
        nameLabel.text = user.name
        
         // Allows access to use auto-layout constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //need x,y,width,height anchors
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        // Set the title of the navBar
        self.navigationItem.titleView = titleView
        
    }
    
}// End class

