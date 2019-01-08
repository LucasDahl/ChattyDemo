//
//  ViewController.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/8/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the left bar button item(Logout)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
    }


    // Logout function
    @objc func handleLogout() {
        
        // Create the LoginViewController
        let loginController = LoginController()
        
        // Present the login viewController
        present(loginController, animated: true, completion: nil)
        
    }
    
}

