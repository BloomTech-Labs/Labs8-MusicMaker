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
    
    @IBOutlet weak var emailTextField: HoshiTextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    
    @IBOutlet weak var passwordTextField: HoshiTextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var confirmPasswordTextField: HoshiTextField! {
        didSet {
            confirmPasswordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var emailCheckmark: LOTAnimationView!
    @IBOutlet weak var confirmPasswordAnimation: LOTAnimationView!
    @IBOutlet weak var passwordAnimation: LOTAnimationView!
    // MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            delegate?.nextButtonTapped(with: email, password: password)
            //Tell user to enter an email or password
        }
    }
    // MARK: - Private Methods
    private func setupAnimationViews() {
        emailCheckmark.animation = "checkmark"
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
        if confirmPasswordTextField.isSecureTextEntry {
            confirmPasswordTextField.isSecureTextEntry = false
            confirmPasswordAnimation.play(fromProgress: 0.5, toProgress: 1)
        } else {
            confirmPasswordTextField.isSecureTextEntry = true
            confirmPasswordAnimation.play(fromProgress: 0, toProgress: 0.5)
        }
    }
}

// MARK: - UITextFieldDelegate
extension EmailAndPasswordViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            if textField.text?.count ?? 0 > 0 {
                emailCheckmark.isHidden = false
                emailCheckmark.play()
            }
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passwordTextField.becomeFirstResponder()
        case 1:
            confirmPasswordTextField.becomeFirstResponder()
        case 2:
            confirmPasswordTextField.resignFirstResponder()
            nextButtonTapped(textField)
        default:
            break
        }
        return true
    }
}
