//
//  NewMessageController.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/11/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit

class NewMessageController: UITableViewController {
    
    // Properties
    let cellId = "CellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make a cancel button for the tabbar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
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
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a cell (will update later on
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
       
        // Set teh text of the cell
        cell.textLabel?.text = "Hi"
        
        // Return the cell
        return cell
        
    }
    
    //================
    // MARK: - Methods
    //================
    
    func fetchUser() {
        
        
        
    }
    
}
