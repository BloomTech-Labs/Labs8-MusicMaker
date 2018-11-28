//
//  UserProfileViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/15/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class UserProfileViewController: UIViewController {
    
    //currentUser?.providerData[0].providerID returns google.com for google auth or password for email/password auth

    // MARK: - Properties
    let database = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    var student: Student?
    // MARK: - IBOutlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var updateEmailButton: UIButton!
    @IBOutlet weak var updatedEmailTextField: UITextField! {
        didSet {
            updatedEmailTextField.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let student = student {
            profileImage.createInitialsImage(for: "\(student.firstName) \(student.lastName)", backgroundColor: .lightGray)
            title = "\(student.firstName) \(student.lastName)"
            emailLabel.text = student.email
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func updateEmail(_ sender: Any) {
        if updateEmailButton.titleLabel?.text == "Update Email" {
            updatedEmailTextField.isHidden = false
            updateEmailButton.setTitle("Update", for: .normal)
        } else if updateEmailButton.titleLabel?.text == "Update" {
            guard let newEmail = updatedEmailTextField.text,
                let usersUniqueIdentifier = currentUser?.uid else {return}
            currentUser?.updateEmail(to: newEmail, completion: { (error) in
                if error != nil {
                    print(error)
                    self.updateEmailButton.setTitle("Error Updating Email", for: .normal)
                } else {
                    self.database.collection("students").document(usersUniqueIdentifier).setData(["email" : newEmail], merge: true)
                    self.updatedEmailTextField.isHidden = true
                    self.updateEmailButton.setTitle("Update Email", for: .normal)
                    self.emailLabel.text = newEmail
                    self.student?.email = newEmail
                }
            })
        }
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
   

}
