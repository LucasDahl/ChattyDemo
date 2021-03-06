//
//  User.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/11/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit

class User: NSObject {
    
    // Properties
    var id: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    
    
    init(dictionary: [String: AnyObject]) {
        
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
        
    }
}
