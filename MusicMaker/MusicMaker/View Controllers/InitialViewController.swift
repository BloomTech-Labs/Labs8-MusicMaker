//
//  InitialViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/27/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore

class InitialViewController: UIViewController, GIDSignInUIDelegate {
    
    // MARK: - Properties
    let database = Firestore.firestore()
    let blurredBackgroundView = UIVisualEffectView()
    var isSigningUpWithGoogle = false
  
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Used for the blurred view
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
        }
    }
    
    
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
        }
    }
    
    // MARK: - Overrides
    override func viewDidLayoutSubviews() {
        signupButton.layer.cornerRadius = signupButton.frame.height / 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        blurredBackgroundView.frame = view.frame
    }

    
    // MARK: - IBActions
    @IBAction func showLoginOptions(_ sender: Any) {
        animateAdditionOfABlurredBackground()
    }
    @IBAction func showSignupOptions(_ sender: Any) {
        
        animateAdditionOfABlurredBackground()
    }
    
    
    
    
    // MARK: - Private Methods
    private func animateAdditionOfABlurredBackground() {
        
        blurredBackgroundView.frame = view.frame
        self.view.addSubview(self.blurredBackgroundView)
        UIView.animate(withDuration: 0.5, animations: {
            self.blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        })
    }
    
    private func animateRemovalOfBlurredBackground(with duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.blurredBackgroundView.effect = nil
        }) { (_) in
            self.blurredBackgroundView.removeFromSuperview()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        
        case "ShowLoginOptions":
            if let authenticationOptionsVC = segue.destination as? AuthenticationOptionsViewController {
                authenticationOptionsVC.delegate = self
                authenticationOptionsVC.modalPresentationStyle = .overFullScreen
                authenticationOptionsVC.newUser = false
            }
        case "ShowSignupOptions":
            if let authenticationOptionsVC = segue.destination as? AuthenticationOptionsViewController {
                authenticationOptionsVC.delegate = self
                authenticationOptionsVC.modalPresentationStyle = .overFullScreen
                authenticationOptionsVC.newUser = true
            }
        case "ShowSignupScreen":
            if let destinationVC = segue.destination as? AddTeacherOptionsViewController {
                destinationVC.isSigningUpWithGoogle = isSigningUpWithGoogle
            }
        default:
            ()
        }
    }
    
    
}

// MARK: - GIDSignInDelegat
extension InitialViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            NSLog("Error signing in with google : \(error)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            let currentUser = Auth.auth().currentUser
            let currentUserReference = self.database.collection("students").document(currentUser?.uid ?? "")
            currentUserReference.getDocument(completion: { (document, error) in
                if let document = document, document.exists {
                    self.performSegue(withIdentifier: "ShowTeachers", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "SignUpWithGoogle", sender: nil)
                }
            })
        }
    }
    
  
}

// MARK: - AuthenticationOptionsViewControllerDelegate
extension InitialViewController: AuthenticationOptionsViewControllerDelegate {
    
    func authenticateWithEmail(for newUser: Bool) {
        animateRemovalOfBlurredBackground(with: 0.3)
        isSigningUpWithGoogle = newUser
        self.performSegue(withIdentifier: newUser ? "ShowSignupScreen" : "ShowLoginScreen", sender: nil)
    }
    
    
    
    func dismissOptions() {
        animateRemovalOfBlurredBackground(with: 0.5)
    }
    
    func authenticateWithGoogle() {
        animateRemovalOfBlurredBackground(with: 0.3)
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
}
