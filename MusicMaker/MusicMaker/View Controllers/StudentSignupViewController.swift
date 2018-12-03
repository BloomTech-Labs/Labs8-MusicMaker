//
//  StudentSignupViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Lottie
import FirebaseAuth
import FirebaseFirestore

class StudentSignupViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDismissKeyboardGestureRecognizer()
        setupContainerViews()
        
    }
    
    
    
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var levelAndInstrumentView: UIView!
    @IBOutlet weak var emailAndPasswordView: UIView!
    @IBOutlet weak var firstAndLastNameView: UIView!
   
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    var isSigningUpWithGoogle = false
    var teacherUniqueId: String?
    var emailAndPasswordViewController: EmailAndPasswordViewController?
    var levelAndInstrumentViewController: LevelAndInstrumentViewController?
    var firstAndLastNameViewController: FirstAndLastNameViewController?
    var email: String?
    var password: String?
    
    // MARK: - Private Methods
    private func setupContainerViews() {
        emailAndPasswordView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
        levelAndInstrumentView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)

        emailAndPasswordViewController = self.children[1] as? EmailAndPasswordViewController
        emailAndPasswordViewController?.delegate = self
        levelAndInstrumentViewController = self.children[0] as? LevelAndInstrumentViewController
        levelAndInstrumentViewController?.delegate = self
        firstAndLastNameViewController = self.children[2] as? FirstAndLastNameViewController
        firstAndLastNameViewController?.delegate = self
        emailAndPasswordView.isUserInteractionEnabled = true
    }
    
    
    //Adds a gesture recognizer that calls dismissKeyboard(_:)
    private func addDismissKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //Resigns the first responder for the textField when clicking away from the keyboard
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func showEmailAndPasswordTextFields(_ sender: Any) {
        
        pageControl.currentPage = 1
    }
}


// MARK: - EmailAndPasswordViewControllerDelegate
extension StudentSignupViewController: EmailAndPasswordViewControllerDelegate {
    
    
    func nextButtonTapped(with email: String, password: String) {
        self.email = email
        self.password = password
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.emailAndPasswordView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            self.levelAndInstrumentView.transform = .identity
            
        })
        pageControl.currentPage = 3
    }
    
}

// MARK: - LevelAndInstrumentViewControllerDelegate
extension StudentSignupViewController: LevelAndInstrumentViewControllerDelegate {
    func signUpButtonTapped(with rating: String, instrument: String) {
//        guard let email = email, let password = password, let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let teacherUniqueId = teacherUniqueId else {return}
//
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//
//
//            //Error creating user checks different errors and updates UI to let user know why there was an error
//            if error != nil {
//                if let errorCode = AuthErrorCode(rawValue: error!._code) {
//                    switch errorCode {
//                    case .weakPassword:
//                        print("weakPassword")
//                    case .accountExistsWithDifferentCredential:
//                        print("Account already exisits")
//                    case .emailAlreadyInUse:
//                        print("Email already in use")
//                    case .invalidEmail:
//                        print("Invalid email")
//                    case .missingEmail:
//                        print("Missing email")
//                    default:
//                        print("error")
//                    }
//                }
//            }
//
//            let database = Firestore.firestore()
//
//            let userDocumentInformation = ["email" : email, "firstName": firstName, "lastName" : lastName, "instrument": instrument, "level": rating]
//
//
//            if let user = user {
//                let usersUniqueIdentifier = user.user.uid
//
//                database.collection("students").document(usersUniqueIdentifier).setData(userDocumentInformation)
//                database.collection("students").document(usersUniqueIdentifier).collection("teachers").document(teacherUniqueId).setData(["test": "test"])
//
//                //DELETE TEST TEST ABOVE ^^^^
//                self.performSegue(withIdentifier: "ShowStudentHome", sender: nil)
//            }
//        }
    }
}

// MARK: - FirstAndLastNameViewControllerDelegate
extension StudentSignupViewController: FirstAndLastNameViewControllerDelegate {
    func nextButtonTapped() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.firstAndLastNameView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            self.emailAndPasswordView.transform = .identity
        })
    }
}
