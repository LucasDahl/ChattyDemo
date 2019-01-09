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
        
        // Allow for the button to be translated into auto-layout
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Round the corners
        view.layer.cornerRadius = 5
        // This is needed or the corners won't be rounded.
        view.layer.masksToBounds = true
        
        // Return the view
        return view
        
    }()
    
    // Login and Register button
    let loginRegisterButton: UIButton = {
        
        // Make the button
        let button = UIButton(type: .system)
        
        // Set the button color
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        
        // Allows for the button to be translated into auto-layout
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the title color to white
        button.setTitleColor(UIColor.white, for: .normal)
        
        // Set the title font
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Round the buttons
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        // Set the normal state of the button and title
        button.setTitle("Register", for: .normal)
        
        // Return the button
        return button
        
    }()
    
    // Name text field
    let nameTextField: UITextField = {
        
        // Make the textfield
        let tf = UITextField()
        
        // Make the place holder text.
        tf.placeholder = "Name"
        
        // Allows for the button to be translated into auto-layout
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        // Return the nameField
        return tf
        
    }()
    
    // Name separator
    let nameSeparatorView: UIView = {
       
        // Create the view
        let view = UIView()
        
        // Set the color
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
        // Allows for the button to be translated into auto-layout
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Return the view
        return view
        
    }()
    
    // Name text field
    let emailTextField: UITextField = {
        
        // Make the textfield
        let tf = UITextField()
        
        // Make the place holder text.
        tf.placeholder = "Email"
        
        // Allows for the button to be translated into auto-layout
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        // Return the nameField
        return tf
        
    }()
    
    // Name separator
    let emailSeparatorView: UIView = {
        
        // Create the view
        let view = UIView()
        
        // Set the color
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
        // Allows for the button to be translated into auto-layout
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Return the view
        return view
        
    }()
    
    // Name text field
    let passwordTextField: UITextField = {
        
        // Make the textfield
        let tf = UITextField()
        
        // Make the place holder text.
        tf.placeholder = "Password"
        
        // Allows for the button to be translated into auto-layout
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        // Make the typed characters hidden
        tf.isSecureTextEntry = true
        
        // Return the nameField
        return tf
        
    }()
    
    // Setup the imageView
    let profileImageView: UIImageView = {
       
        // Make the imageView
        let imageView = UIImageView()
        
        // Set the image
        imageView.image = UIImage(named: "gameofthrones_splash")
        
        // Allows for the button to be translated into auto-layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the contentMode of the imageView
        imageView.contentMode = .scaleAspectFill
        
        // Return the imageView
        return imageView
        
    }()
    
    // ====== End UI properties

    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the background color
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        // Add UI elements to the subView
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        
        // Call the UI setup functions
        setupInputsContainerView()
        setupLoginRegisterButton()
        
        // Call the profileImageView setup functions
        setupProfileImageView()
        
    }
    
    //=========================
    //MARK: - UI Elements setup
    //=========================
    
    func setupProfileImageView() {
        
        // x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    func setupInputsContainerView() {
        
        // Add the constraints for the container
        // x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        // Add the elements to the subview and set the constraints
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        // x, y, width, height constraints - these are set using the inputsContainerView, as it will go inside it
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        // Add the nameSeparatorView constraints - set constraints based of the inputContainerView
        // x, y, width, height constraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // x, y, width, height constraints - these are set using the inputsContainerView, as it will go inside it
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        // Add the nemailSeparatorView constraints - set constraints based of the inputContainerView
        // x, y, width, height constraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // x, y, width, height constraints - these are set using the inputsContainerView, as it will go inside it
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
    }
    
    func setupLoginRegisterButton() {
    
        // Add the loginRegisterButton constraints
        // x, y, width, height constraints
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    // Set the bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // Returns a light colored status bar
        return .lightContent
    }
    
    // ====== End UI setup


}// End class

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    
        // Set all colors to be out of 255.
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    
    }
    
}
