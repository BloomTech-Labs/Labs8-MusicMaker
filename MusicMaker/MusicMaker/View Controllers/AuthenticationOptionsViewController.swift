//
//  AuthenticationOptionsViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/29/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AuthenticationOptionsViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if newUser {
            emailButton.setTitle("SIGN UP WITH EMAIL", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Overrides
    override func viewDidLayoutSubviews() {
        self.view.backgroundColor = UIColor.clear
    }
    
    
    // MARK: - Delegate
    weak var delegate: AuthenticationOptionsViewControllerDelegate?
    
    // MARK: - Properties
    var newUser = true

    // MARK: - IBOutlets
    @IBOutlet weak var emailButton: UIButton! {
        didSet {
            emailButton.layer.cornerRadius = emailButton.frame.height / 2
        }
    }
    @IBOutlet weak var googleButton: UIButton! {
        didSet {
            googleButton.layer.cornerRadius = googleButton.frame.height / 2
        }
    }
    
    
    
    // MARK: - IBActions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.dismissOptions()
    }
    
    @IBAction func googleButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.authenticateWithGoogle()
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        let isNewUser = emailButton.titleLabel?.text == "LOG IN WITH EMAIL" ? false : true
        delegate?.authenticateWithEmail(for: isNewUser)
    }
}
