//
//  FirstAndLastNameViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Lottie


class FirstAndLastNameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Delegate
    weak var delegate: FirstAndLastNameViewControllerDelegate?

    
    // MARK: - IBOutlets
    @IBOutlet weak var firstNameTextField: HoshiTextField! {
        didSet {
            firstNameTextField.delegate = self
        }
    }
    @IBOutlet weak var lastNameTextField: HoshiTextField! {
        didSet {
            lastNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var firstNameCheckmarkAnimation: LOTAnimationView! {
        didSet {
            firstNameCheckmarkAnimation.animation = "checkmark"
            firstNameCheckmarkAnimation.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var lastNameCheckmarkAnimation: LOTAnimationView! {
        didSet {
            lastNameCheckmarkAnimation.animation = "checkmark"
            lastNameCheckmarkAnimation.contentMode = .scaleAspectFit
        }
    }
   
    // MARK: - IBActions
    
    @IBAction func goToNextStep(_ sender: Any) {
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text {
            delegate?.nextButtonTapped(firstName: firstName, lastName: lastName)
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension FirstAndLastNameViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            if textField.text?.count ?? 0 > 0 {
                firstNameCheckmarkAnimation.play()
            }
        case 1:
            if textField.text?.count ?? 0 > 0 {
                lastNameCheckmarkAnimation.play()
            }
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            lastNameTextField.becomeFirstResponder()
        case 1:
            lastNameTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
