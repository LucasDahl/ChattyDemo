//
//  NewMessageController.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/11/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    // Properties
    let cellId = "CellId"
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make a cancel button for the tabbar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        // Register the Usercell
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        // Fetch the users
        fetchUser()
        
    }
    
    
    //================
    // MARK: - Actions
    //================
    
    @objc func handleCancel() {
        
        // Dismiss the newMessageViewController
        dismiss(animated: true, completion: nil)
        
    }

    //=================================
    // MARK: - TableView methods
    //=================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the total number of users from the array
        return users.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
       
        // Get a reference to the user
        let user = users[indexPath.row]
        
        // Set the text of the cell to the users name
        cell.textLabel?.text = user.name
        
        // Seth the user email
        cell.detailTextLabel?.text = user.email
        
        // Return the cell
        return cell
        
    }
    
    //================
    // MARK: - Methods
    //================
    
    func fetchUser() {
        
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            print("user")
            print(snapshot) // Prints all the user
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                // Create the user
                let user = User(dictionary: dictionary)
                
                // set the values for the user will crash if the values are not exactly the same as in Firebase
                //user.setValuesForKeys(dictionary)
                
                //Set the values another way, a slightly safer way
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String

                
                // Append the the user to the users array
                self.users.append(user)
                
                // Reload the data for the tableview
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }
            
        }, withCancel: nil)
        
    }
    
    
    
} // End class

//====================
// MARK: - Custom cell
//====================

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

