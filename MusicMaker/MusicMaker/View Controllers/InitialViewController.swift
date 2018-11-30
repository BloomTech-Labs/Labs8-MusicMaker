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
            loginButton.layer.cornerRadius = loginButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.layer.cornerRadius = signupButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var googleSigninButton: UIButton! {
        didSet {
            googleSigninButton.layer.cornerRadius = 5.0
            googleSigninButton.layer.borderColor = UIColor.white.cgColor
            googleSigninButton.layer.borderWidth = 1.0
         }
    }
    
    // MARK: - IBActions
    @IBAction func signInWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance()?.signIn()
    }
    @IBAction func login(_ sender: Any) {
        overlayBlurredBackgroundView()
    }
    
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        overlayBlurredBackgroundView()
    }
    
    
    // MARK: - Private Methods
    private func overlayBlurredBackgroundView() {
        
        blurredBackgroundView.frame = view.frame

        UIView.animate(withDuration: 0.5, animations: {
            self.view.addSubview(self.blurredBackgroundView)
            self.blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        })
    }
    
    private func removeBlurredBackgroundView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blurredBackgroundView.effect = nil
        }) { (_) in
            self.blurredBackgroundView.removeFromSuperview()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "SignUpWithGoogle":
            if let signupVc = segue.destination as? SignUpViewController {
                signupVc.isSigningUpWithGoogleAuth = true
            }
        case "ShowLoginOptions":
            if let loginOptionsVc = segue.destination as? LoginOptionsViewController {
                loginOptionsVc.delegate = self
                loginOptionsVc.modalPresentationStyle = .overFullScreen
            }
        case "ShowSignupOption":
            if let signupOptionsVc = segue.destination as? SignupOptionsViewController {
                signupOptionsVc.delegate = self
                signupOptionsVc.modalPresentationStyle = .overFullScreen
            }
        default:
            break
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

// MARK: - LoginOptionsViewControllerDelegate
extension InitialViewController: LoginOptionsViewControllerDelegate {
    func dismissLoginOptions() {
        removeBlurredBackgroundView()
    }
    
    func goToLoginScreen() {
        removeBlurredBackgroundView()
        self.performSegue(withIdentifier: "ShowLoginScreen", sender: nil)
    }
    
}

// MARK: - SignupOptionsViewControllerDelegate
extension InitialViewController: SignupOptionsViewControllerDelegate {
    func dismissSignupOptions() {
        removeBlurredBackgroundView()
    }
}
