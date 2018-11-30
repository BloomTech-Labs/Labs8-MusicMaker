//
//  LoginOptionsViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/29/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class LoginOptionsViewController: UIViewController {

    
    
    
    
    // MARK: - Delegates
    weak var delegate: LoginOptionsViewControllerDelegate?

    
    // MARK: - IBOutlets
    @IBOutlet weak var googleSignInButton: UIButton! {
        didSet {
            googleSignInButton.layer.cornerRadius = googleSignInButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = loginButton.frame.height / 2
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
        delegate?.dismissLoginOptions()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        dismiss(animated: true)
        delegate?.goToLoginScreen()
    }
    
    // MARK: - Overrides
    override func viewDidLayoutSubviews() {
        self.view.backgroundColor = UIColor.clear
    }
    
    
}
