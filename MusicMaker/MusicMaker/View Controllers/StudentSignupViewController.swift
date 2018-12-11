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
        setupNavigationBar()
    }
        
    
    override func viewDidLayoutSubviews() {
        setupContainerViews()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var levelAndInstrumentView: UIView!
    @IBOutlet weak var emailAndPasswordView: UIView!
    @IBOutlet weak var firstAndLastNameView: UIView!
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = isSigningUpWithGoogle ? 2 : 3
        }
    }
    
    // MARK: - Properties
    var isSigningUpWithGoogle = false

    var teacherUniqueId: String?
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    

    // MARK: - Private Methods
    private func setupContainerViews() {
        emailAndPasswordView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
        levelAndInstrumentView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
    }
    
    private func writeStudentToFirestore(userId: String, level: String, instrument: String) {
        guard let email = email, let firstName = firstName, let lastName = lastName, let teacherUniqueId = teacherUniqueId else {return}
        
        let database = Firestore.firestore()
        let userDocumentInformation = ["email" : email, "firstName": firstName, "lastName" : lastName, "instrument": instrument, "level": level]
        database.collection("students").document(userId).setData(userDocumentInformation)
        database.collection("students").document(userId).collection("teachers").document(teacherUniqueId).setData(["exisits": true])
        database.collection("teachers").document(teacherUniqueId).collection("students").document(userId).setData(userDocumentInformation)
        
        self.performSegue(withIdentifier: "ShowStudentHome", sender: nil)
        
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
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "InstrumentAndLevel":
            if let destinationVC = segue.destination as? LevelAndInstrumentViewController {
                destinationVC.delegate = self
            }
        case "ShowEmailAndPassword":
            if let destinationVC = segue.destination as? EmailAndPasswordViewController {
                destinationVC.delegate = self
            }
        case "FirstAndLastName":
            if let destinationVC = segue.destination as? FirstAndLastNameViewController {
                destinationVC.delegate = self
            }
        default:
            break
        }
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
        pageControl.currentPage += 1
    }
    
    
    
    
}




// MARK: - LevelAndInstrumentViewControllerDelegate
extension StudentSignupViewController: LevelAndInstrumentViewControllerDelegate {
    func signUpButtonTapped(with level: String, instrument: String) {
        
        if isSigningUpWithGoogle {
            if let userId = Auth.auth().currentUser?.uid {
                self.writeStudentToFirestore(userId: userId, level: level, instrument: instrument)
            }
        } else {
            guard let email = email, let password = password else {return}
            
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
                            print("Email already in use")
                        case .invalidEmail:
                            print("Invalid email")
                        case .missingEmail:
                            print("Missing email")
                        default:
                            print("error")
                        }
                    }
                }
                if let user = user {
                    self.writeStudentToFirestore(userId: user.user.uid, level: level, instrument: instrument)
                }
            }
        }
    }
}

// MARK: - FirstAndLastNameViewControllerDelegate
extension StudentSignupViewController: FirstAndLastNameViewControllerDelegate {
    func nextButtonTapped(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        
        isSigningUpWithGoogle ? UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.firstAndLastNameView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            self.levelAndInstrumentView.transform = .identity
        }) : UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.firstAndLastNameView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            self.emailAndPasswordView.transform = .identity
        })
        pageControl.currentPage += 1
    }
}
