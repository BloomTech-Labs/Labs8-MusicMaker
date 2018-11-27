//
//  InitialViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/27/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import GoogleSignIn

class InitialViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
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
    
    @IBOutlet weak var signInWithGoogle: UIButton! {
        didSet {
            signInWithGoogle.layer.cornerRadius = 5.0
            signInWithGoogle.layer.borderColor = UIColor.white.cgColor
            signInWithGoogle.layer.borderWidth = 1.0
//            signInWithGoogle.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
}
