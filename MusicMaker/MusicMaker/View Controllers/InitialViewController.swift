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
    
    
    let database = Firestore.firestore()
    
  
    

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 5.0
            loginButton.layer.borderColor = UIColor.white.cgColor
            loginButton.layer.borderWidth = 1.0
//            loginButton.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.layer.cornerRadius = 5.0
            signupButton.layer.borderColor = UIColor.white.cgColor
            signupButton.layer.borderWidth = 1.0
//            signupButton.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet weak var googleSigninButton: UIButton! {
        didSet {
            googleSigninButton.layer.cornerRadius = 5.0
            googleSigninButton.layer.borderColor = UIColor.white.cgColor
            googleSigninButton.layer.borderWidth = 1.0
//            signInWithGoogle.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    // MARK: - IBActions
    @IBAction func signInWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance()?.signIn()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUpWithGoogle" {
            let signupVC = segue.destination as? SignUpViewController
            signupVC?.isSigningUpWithGoogleAuth = true
        }
    }
    
}
