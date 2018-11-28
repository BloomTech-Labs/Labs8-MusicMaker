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
        //Sample for querying firestore for student information
        guard let currentUsersUniqueID = Auth.auth().currentUser?.uid else {return}
        let studentsCollectionReference = database.collection("students").document(currentUsersUniqueID)
        studentsCollectionReference.getDocument { (document, error) in
            if let document = document {
                if let dataDescription = document.data() {
                    guard let firstName = dataDescription["firstName"] as? String,
                        let lastName = dataDescription["lastName"] as? String else {return}
                    print(firstName)
                    self.profileImage.createInitialsImage(for: "\(firstName) \(lastName)", backgroundColor: .lightGray)
                    self.title = "\(firstName) \(lastName)"
                    self.emailLabel.text = dataDescription["email"] as? String
                }
            } else {
                print("Document does not exist in cache")
            }
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
                    self.updateEmailButton.setTitle("Error Updating Email", for: .normal)
                } else {
                    self.database.collection("students").document(usersUniqueIdentifier).setData(["email" : newEmail], merge: true)
                    self.updatedEmailTextField.isHidden = true
                    self.updateEmailButton.setTitle("Update Email", for: .normal)
                    self.emailLabel.text = newEmail
                }
            })
        }
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
   

}
