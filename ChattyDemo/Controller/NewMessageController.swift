//
//  NewMessageController.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/11/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit

class NewMessageController: UITableViewController {

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

}
