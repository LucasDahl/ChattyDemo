//
//  LoginController.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/8/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //================================
    //MARK: Properties for UI elements
    //================================
    
    
    // Input container
    var inputsContainerView: UIView = {
        
        // Setup the UI elements
        let view = UIView()
        
        // Set the background color
        view.backgroundColor = UIColor.white
        
        // Allow
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Round the corners
        view.layer.cornerRadius = 5
        // This is needed or the corners won't be rounded.
        view.layer.masksToBounds = true
        
        // Return the view
        return view
        
    }()
    
    // button
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the background color
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        // Add the container to the subView
        view.addSubview(inputsContainerView)
        
        // Call the container setup function
        setupInputContainerView()
        
    }
    
    
    func setupInputContainerView() {
        
        // Add the constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    // Set the bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // Returns a light colored status bar
        return .lightContent
    }


}// End class

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    
        // Set all colors to be out of 255.
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    
    }
    
}
