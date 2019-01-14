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
    let cellId = "cellId"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the leftBarButtonITem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        // Register the cell
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
        
    }
    
    func fetchUser() {
        
        // Get the location where the user is stored
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            // Check for the user
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                // Make the user
                let user = User(dictionary: dictionary)
                
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary keys
                self.users.append(user)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the total number of users
        return users.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Make the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        // Get the user
        let user = users[indexPath.row]
        
        // Set the users name
        cell.textLabel?.text = user.name
        
        // Set the users email to the dertail label
        cell.detailTextLabel?.text = user.email
        
        return cell
        
    }
    
}

// Create a custom cell
class UserCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


