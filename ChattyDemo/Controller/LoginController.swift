//
//  LoginController.swift
//  ChattyDemo
//
//  Created by Lucas Dahl on 1/8/19.
//  Copyright © 2019 Lucas Dahl. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    //==================
    // MARK: - Properties
    //===================
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    //======================
    // MARK: - UI properties
    //======================
    
    let inputsContainerView: UIView = {
        
        // Setup the view
        let view = UIView()
        
        // Setup the view volor
        view.backgroundColor = UIColor.white
        
        // this is needed to allow auto-layout
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the corner radius
        view.layer.cornerRadius = 5
        
        // Mask the view to bounds
        view.layer.masksToBounds = true
        
        return view
        
    }()
    
    lazy var loginRegisterButton: UIButton = {
        
        // Create the button
        let button = UIButton(type: .system)
        
        // Set the button colors
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        
        // Set teh title of the button
        button.setTitle("Register", for: UIControl.State())
        
        // this is needed to allow auto-layout
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the title color
        button.setTitleColor(UIColor.white, for: UIControl.State())
        
        // Set the font for the button
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Add the target
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        return button
        
    }()
    
    let nameTextField: UITextField = {
        
        // Setup the tefield
        let tf = UITextField()
        
        // Set the place holder text
        tf.placeholder = "Name"
        
        // this is needed to allow auto-layout
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
        
    }()
    
    let nameSeparatorView: UIView = {
        
        // Setup the view
        let view = UIView()
        
        // Set the color of the view
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
        // this is needed to allow auto-layout
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    let emailTextField: UITextField = {
        
        // Setup the textfield
        let tf = UITextField()
        
        // Set the default text
        tf.placeholder = "Email"
        
        // this is needed to allow auto-layout
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
        
    }()
    
    let emailSeparatorView: UIView = {
        
        // Setup the view
        let view = UIView()
        
        // Set the view color
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
        // this is needed to allow auto-layout
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    let passwordTextField: UITextField = {
        
        // Setup the textfield
        let tf = UITextField()
        
        // Set the place holder text
        tf.placeholder = "Password"
        
        // this is needed to allow auto-layout
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        // Hides the typed text
        tf.isSecureTextEntry = true
        
        return tf
        
    }()
    
    lazy var profileImageView: UIImageView = {
        
        // Setup the image
        let imageView = UIImageView()
        
        // Set the default image
        imageView.image = UIImage(named: "gameofthrones_splash")
        
        // this is needed to allow auto-layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the aspect
        imageView.contentMode = .scaleAspectFill
        
        // Add the gestures
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        
        // Allow the user to interacte with the image
        imageView.isUserInteractionEnabled = true
        
        return imageView
        
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        
        // Set up the segmented control
        let sc = UISegmentedControl(items: ["Login", "Register"])
        
        // this is needed to allow auto-layout
        sc.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the color of the sc
        sc.tintColor = UIColor.white
        
        // Set its index
        sc.selectedSegmentIndex = 1
        
        // Action
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        
        return sc
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        // Add the subviews
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        // Call the setup functions
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
        
    }
    
    
    
    //================
    // MARK: - Actions
    //================
    
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            //successfully logged in our user
            self.dismiss(animated: true, completion: nil)
            
        })
        
    }
    
    @objc func handleLoginRegisterChange() {
        
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControl.State())
        
        // change height of inputContainerView, but how???
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        nameTextField.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    //=================
    // MARK: - UI setup
    //=================
    
    func setupLoginRegisterSegmentedControl() {
        
        //need x, y, width, height constraints
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
    func setupProfileImageView() {
        
        //need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    
    func setupInputsContainerView() {
        
        //need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        //need x, y, width, height constraints
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        
        emailTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    func setupLoginRegisterButton() {
        
        //need x, y, width, height constraints
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
    // Set the color of the status bar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

// Override to make life easier
extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}

