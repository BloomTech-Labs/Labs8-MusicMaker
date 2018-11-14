//
//  SignUpViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/7/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissKeyboardGestureRecognizer()
    
    }
    
    //Adds an observer to listen for the keyboardWillShowNotification & keyboardWillHideNotifcation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    
    //Removes the observer for the keyboardWillShowNotification & keyboardWillHideNotifcation
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    
    
    
    // MARK: - Private
    
    //Used to move the views frame up when the keyboard is about to be shown so the textfields can be seen
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height - 10)
            }
        }
    }
    
    //Used to move the views frame back to the normal position when the keyboard goes away
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += (keyboardSize.height - 10)
            }
        }
    }
    
    //Adds a gesture recognizer that calls dismissKeyboard(_:)
    private func addDismissKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //Resigns the first responder for the textField when clicking away from the keyboard
    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.delegate = self
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            lastNameTextField.delegate = self
        }
    }
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
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet {
            confirmPasswordTextField.delegate = self
        }
    }
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var instrumentButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func selectLevel(_ sender: UIButton) {
        
        let beginnerAction = UIAlertAction(title: "Beginner", style: .default) { (action) in
            sender.setTitle("Beginner", for: .normal)
        }
        
        let intermediateAction = UIAlertAction(title: "Intermediate", style: .default) { (action) in
            sender.setTitle("Intermediate", for: .normal)
        }
        
        let expertAction = UIAlertAction(title: "Expert", style: .default) { (action) in
            sender.setTitle("Expert", for: .normal)
        }
        
        let alert = UIAlertController(title: "Select your level of experience", message: "", preferredStyle: .actionSheet)
        alert.addAction(beginnerAction)
        alert.addAction(intermediateAction)
        alert.addAction(expertAction)
        
        //Used if its an ipad to present as a popover
        let popover = alert.popoverPresentationController
        popover?.permittedArrowDirections = .down
        popover?.sourceView = sender
        popover?.sourceRect = sender.bounds
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectInstrument(_ sender: UIButton) {
        let trumpetAction = UIAlertAction(title: "Trumpet", style: .default) { (action) in
            sender.setTitle("Trumpet", for: .normal)
        }
        
        let fluteAction = UIAlertAction(title: "Flute", style: .default) { (action) in
            sender.setTitle("Flute", for: .normal)
        }
        
        let violinAction = UIAlertAction(title: "Violin", style: .default) { (action) in
            sender.setTitle("Violin", for: .normal)
        }
        
        let alert = UIAlertController(title: "Select Your Instrument", message: "", preferredStyle: .actionSheet)
        alert.addAction(trumpetAction)
        alert.addAction(fluteAction)
        alert.addAction(violinAction)
        
        //Used if its an ipad to present as a popover
        let popover = alert.popoverPresentationController
        popover?.permittedArrowDirections = .down
        popover?.sourceView = sender
        popover?.sourceRect = sender.bounds
        
        present(alert, animated: true, completion: nil)
    }
    
    // Used to toggle the password textfields to show or hide entry
    @IBAction func toggleSecureEntryOnPasswordTextFields(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if passwordTextField.isSecureTextEntry == false {
                passwordTextField.isSecureTextEntry = true
            } else {
                passwordTextField.isSecureTextEntry = false
            }
        case 1:
            if confirmPasswordTextField.isSecureTextEntry == false {
                confirmPasswordTextField.isSecureTextEntry = true
            } else {
                confirmPasswordTextField.isSecureTextEntry = false
            }
        default:
            break
        }
    }
    
    
    @IBAction func createAccount(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let confirmedPassword = confirmPasswordTextField.text,
            let instrument = instrumentButton.titleLabel?.text,
            let level = levelButton.titleLabel?.text
        else {return}
        
        guard password == confirmedPassword else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            //Error creating user checks different errors and updates UI to let user know why there was an error
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case .weakPassword:
                        print("weakPassword")
                    case .accountExistsWithDifferentCredential:
                        print("Account already exisits")
                    case .emailAlreadyInUse:
                        print("email in use")
                    case .invalidEmail:
                        print("invalid email")
                    case .missingEmail:
                        print("missing email")
                    default:
                        print("error")
                    }
                }
            }
            
            let database = Firestore.firestore()
            
            let userDocumentInformation = ["email" : email, "firstName": firstName, "lastName" : lastName, "instrument": instrument, "level": level]
            
            if let user = user {
                let usersUniqueIdentifier = user.user.uid
                database.collection("students").document(usersUniqueIdentifier).collection("settings").addDocument(data: userDocumentInformation)
            }
        }
    }
}


// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            lastNameTextField.becomeFirstResponder()
        case 1:
            emailTextField.becomeFirstResponder()
        case 2:
            passwordTextField.becomeFirstResponder()
        case 3:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
