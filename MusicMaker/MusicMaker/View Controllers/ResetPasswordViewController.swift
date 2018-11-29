//
//  ResetPasswordViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/28/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    //currentUser?.providerData[0].providerID returns google.com for google auth or password for email/password auth
    
    // MARK: - IBOutlets
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    // MARK: - Properties
    var student: Student?
    let currentUser = Auth.auth().currentUser
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - IBActions
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func changePassword(_ sender: Any) {
        if currentUser?.providerData[0].providerID == "password" {
            if let student = student {
                let credential: AuthCredential = EmailAuthProvider.credential(withEmail: student.email, password: oldPassword.text ?? "")
                currentUser?.reauthenticateAndRetrieveData(with: credential, completion: { (authResult, error) in
                    if let error = error {
                        self.title = "Error"
                        NSLog(error.localizedDescription)
                    } else {
                        self.currentUser?.updatePassword(to: self.newPassword.text ?? "", completion: { (error) in
                            if let error = error {
                                self.title = "Error"
                                NSLog(error.localizedDescription)
                            } else {
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
}
