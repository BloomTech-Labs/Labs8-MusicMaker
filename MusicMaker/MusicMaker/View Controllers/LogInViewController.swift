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


    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - IBActions
    
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
}
