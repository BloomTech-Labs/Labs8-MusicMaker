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

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
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
    
    @IBAction func createAccount(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text
        
        else {return}
        
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
            
            if let user = user {
                let usersUniqueIdentifier = user.user.uid
                print(usersUniqueIdentifier)
                database.collection("students").document(usersUniqueIdentifier).collection("settings").addDocument(data: ["email" : email])
            }
        }
    }
    
    
    
    
}
