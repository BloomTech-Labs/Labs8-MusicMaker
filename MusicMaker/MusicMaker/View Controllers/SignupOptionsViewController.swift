//
//  SignupOptionsViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/29/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class SignupOptionsViewController: UIViewController {

    
    // MARK: - Delegate
    weak var delegate: SignupOptionsViewControllerDelegate?
    
    @IBOutlet weak var googleSignupButton: UIButton! {
        didSet {
            googleSignupButton.layer.cornerRadius = googleSignupButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var signupWithEmailButton: UIButton! {
        didSet {
            signupWithEmailButton.layer.cornerRadius = signupWithEmailButton.frame.height / 2
        }
    }
    
    // MARK: - IBActions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
        delegate?.dismissSignupOptions()
    }
    
    // MARK: - Overrides
    override func viewDidLayoutSubviews() {
        self.view.backgroundColor = UIColor.clear
    }

}
