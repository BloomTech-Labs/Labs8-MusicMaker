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
    
    //currentUser?.providerData[0].providerID returns google.com for google auth or password for email/password auth

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
    
    
    // MARK: - IBActions
//    @IBAction func updateEmail(_ sender: Any) {
//        if updateEmailButton.titleLabel?.text == "Update Email" {
//            updatedEmailTextField.isHidden = false
//            updateEmailButton.setTitle("Update", for: .normal)
//        } else if updateEmailButton.titleLabel?.text == "Update" {
//            guard let newEmail = updatedEmailTextField.text,
//                let usersUniqueIdentifier = currentUser?.uid else {return}
//            currentUser?.updateEmail(to: newEmail, completion: { (error) in
//                if error != nil {
//                    self.updateEmailButton.setTitle("Error Updating Email", for: .normal)
//                } else {
//                    self.database.collection("students").document(usersUniqueIdentifier).setData(["email" : newEmail], merge: true)
//                    self.updatedEmailTextField.isHidden = true
//                    self.updateEmailButton.setTitle("Update Email", for: .normal)
//                    self.emailLabel.text = newEmail
//                    self.student?.email = newEmail
//                }
//            })
//        }
//    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ResetPassword":
            if let resetPasswordVC = segue.destination as? ResetPasswordViewController {
                resetPasswordVC.student = student
            }
        default:
            break
        }
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

extension UserProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 2:
            logStudentOut()
        default:
            break
        }
    }
}
