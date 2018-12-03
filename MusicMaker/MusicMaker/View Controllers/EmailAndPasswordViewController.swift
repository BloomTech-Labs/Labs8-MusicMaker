//
//  EmailAndPasswordViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Lottie

class EmailAndPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationViews()
        setupGestureRecognizers()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Delegate
    weak var delegate: EmailAndPasswordViewControllerDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: HoshiTextField!
    
    @IBOutlet weak var passwordTextField: HoshiTextField!
    
    @IBOutlet weak var confirmPasswordTextField: HoshiTextField!
    
    @IBOutlet weak var emailCheckmark: LOTAnimationView!
    @IBOutlet weak var confirmPasswordAnimation: LOTAnimationView!
    @IBOutlet weak var passwordAnimation: LOTAnimationView!
    // MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        delegate?.nextButtonTapped()
    }
    // MARK: - Private Methods
    private func setupAnimationViews() {
        emailCheckmark.animation = "checked_done_"
        confirmPasswordAnimation.animation = "eye01"
        passwordAnimation.animation = "eye01"
        
        emailCheckmark.contentMode = .scaleAspectFit
        confirmPasswordAnimation.contentMode = .scaleAspectFit
        passwordAnimation.contentMode = .scaleAspectFit
        
        emailCheckmark.isHidden = true
        
    }
    
    private func setupGestureRecognizers() {
        let passwordTapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePassword))
        passwordAnimation.addGestureRecognizer(passwordTapGesture)
        
        
        let confirmPasswordTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleConfirmPassword))
        confirmPasswordAnimation.addGestureRecognizer(confirmPasswordTapGesture)
        
        
    }
    
    @objc private func togglePassword() {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            passwordAnimation.play(fromProgress: 0.5, toProgress: 1)
        } else {
            passwordTextField.isSecureTextEntry = true
            passwordAnimation.play(fromProgress: 0, toProgress: 0.5)
        }
    }
    
    @objc private func toggleConfirmPassword() {
        
    }
}
