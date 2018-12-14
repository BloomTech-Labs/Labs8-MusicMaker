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
import GoogleSignIn

class UserProfileViewController: UIViewController {
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        if let student = student {
            profileImage.createInitialsImage(for: "\(student.firstName) \(student.lastName)", backgroundColor: UIColor.blue3)
            studentNameLabel.text = "\(student.firstName) \(student.lastName)"
            studentEmailLabel.text = student.email
        }
    }
    
    
    // MARK: - Properties
    let database = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    var student: Student?
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var studentEmailLabel: UILabel!
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func logStudentOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance().signOut()
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let initialVC = storyboard.instantiateViewController(withIdentifier: "FirstNavController")
            self.present(initialVC, animated: true, completion: nil)
        } catch {
            presentInformationalAlertController(title: "Error Logging Out", message: "Please try again")
        }
    }

    
    private func presentUpdateEmailAlert() {
        let alert = UIAlertController(title: "Update Email", message: "Enter your new email address", preferredStyle: .alert)
        var newEmail: UITextField?
        alert.addTextField { (textField) in
            textField.borderStyle = UITextField.BorderStyle.none
            textField.backgroundColor = UIColor.clear
            textField.attributedPlaceholder = NSAttributedString(string: "Enter your email address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            newEmail = textField
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            if let newEmail = newEmail?.text {
                self.updateEmail(to: newEmail)
            }
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    private func presentUpdatePasswordAlert() {
        let alert = UIAlertController(title: "Change Password", message: "Confirm your old password", preferredStyle: .alert)
        var oldPassword: UITextField?
        var newPassword: UITextField?
        
        alert.addTextField { (textField) in
            textField.borderStyle = UITextField.BorderStyle.none
            textField.backgroundColor = UIColor.clear
            textField.attributedPlaceholder = NSAttributedString(string: "Old Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            oldPassword = textField
        }
        alert.addTextField { (textField) in
            textField.borderStyle = UITextField.BorderStyle.none
            textField.backgroundColor = UIColor.clear
            textField.attributedPlaceholder = NSAttributedString(string: "New Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            newPassword = textField
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            self.updatePassword(oldPassword: oldPassword?.text ?? "", newPassword: newPassword?.text ?? "")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updatePassword(oldPassword: String, newPassword: String) {
        if currentUser?.providerData[0].providerID == "password" {
            if let student = student {
                let credential: AuthCredential = EmailAuthProvider.credential(withEmail: student.email, password: oldPassword)
                currentUser?.reauthenticateAndRetrieveData(with: credential, completion: { (authResult, error) in
                    if let error = error {
                        self.title = "Error"
                        NSLog(error.localizedDescription)
                    } else {
                        self.currentUser?.updatePassword(to: newPassword, completion: { (error) in
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
    
    private func updateEmail(to newEmail: String) {
        guard let userUniqueIdentifier = currentUser?.uid else {return}
        currentUser?.updateEmail(to: newEmail, completion: { (error) in
            if error == nil {
                self.database.collection("students").document(userUniqueIdentifier).setData(["email" : newEmail], merge: true)
            } else {
                //THERES AN ERROR UPDATE UI
            }
        })
    }
    
    
    // MARK: - IBActions
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension UserProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserSettings", for: indexPath) as! UserSettingsCollectionViewCell
        switch indexPath.item {
        case 0:
            cell.settingsIcon.image = UIImage(named: "message")
            cell.settingsLabel.text = "Update Email"
        case 1:
            cell.settingsIcon.image = UIImage(named: "password")
            cell.settingsLabel.text = "Change Password"
        case 2:
            cell.settingsIcon.image = UIImage(named: "shutdown")
            cell.settingsLabel.text = "Log Out"
        default:
            break
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension UserProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            presentUpdateEmailAlert()
        case 1:
            presentUpdatePasswordAlert()
        case 2:
            logStudentOut()
        default:
            break
        }
    }
}
