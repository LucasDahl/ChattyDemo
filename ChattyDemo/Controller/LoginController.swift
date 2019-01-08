//
//  LoginController.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/8/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the background color
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
    }
    
    // Set the bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // Returns a light colored status bar
        return .lightContent
    }


}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    
        // Set all colors to be out of 255.
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    
    }
    
}
