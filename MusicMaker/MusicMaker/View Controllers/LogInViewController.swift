//
//  LogInViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/7/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {


    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissKeyboardGestureRecognizer()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func showOrHidePasswordEntry(_ sender: Any) {
         passwordTextField.isSecureTextEntry = passwordTextField.isSecureTextEntry ? false : true
    }
    
    @IBAction func login(_ sender: Any) {
        
        guard let email = emailTextField.text, email != "",
            let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "ShowStudentHome", sender: nil)
            }
            
            if error != nil {
                NSLog("Error signing in")
            }
        }
    }
    @IBAction func forgotPassword(_ sender: Any) {
        presentForgotPasswordAlert()
    }
    
    // MARK: - Private
    
    //Adds a gesture recognizer that calls dismissKeyboard(_:)
    private func addDismissKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //Resigns the first responder for the textField when clicking away from the keyboard
    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    //Presents an alert controller when the user clicks forgot password which sends a password reset option to their email address
    private func presentForgotPasswordAlert() {
        let alert = UIAlertController(title: "Reset Password", message: "Enter your email address to reset your password", preferredStyle: .alert)
        var resetPasswordWithEmailTextField: UITextField?
        alert.addTextField { (textField) in
            textField.borderStyle = UITextField.BorderStyle.none
            textField.backgroundColor = UIColor.clear
            textField.attributedPlaceholder = NSAttributedString(string: "Enter your email address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            resetPasswordWithEmailTextField = textField
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            Auth.auth().sendPasswordReset(withEmail: resetPasswordWithEmailTextField?.text ?? "", completion: { (error) in
            })
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITextFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
