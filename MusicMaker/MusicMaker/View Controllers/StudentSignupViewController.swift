//
//  StudentSignupViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Lottie

class StudentSignupViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameCheckmark.animation = "checked_done_"
        firstNameCheckmark.contentMode = .scaleAspectFit
        lastNameCheckmark.animation = "checked_done_"
        lastNameCheckmark.contentMode = .scaleAspectFit
        addDismissKeyboardGestureRecognizer()
        emailAndPasswordViewController = self.children[0] as? EmailAndPasswordViewController
        emailAndPasswordViewController?.delegate = self
        emailAndPasswordView.isUserInteractionEnabled = true
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var firstNameCheckmark: LOTAnimationView!
    @IBOutlet weak var lastNameCheckmark: LOTAnimationView!
    @IBOutlet weak var emailAndPasswordView: UIView!
    @IBOutlet weak var firstAndLastNameView: UIView!
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
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    var isSigningUpWithGoogle = false
    var teacherUniqueId: String?
    var emailAndPasswordViewController: EmailAndPasswordViewController?

    
    // MARK: - Private Methods
    //Adds a gesture recognizer that calls dismissKeyboard(_:)
    private func addDismissKeyboardGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //Resigns the first responder for the textField when clicking away from the keyboard
    @objc private func dismissKeyboard() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
    }
    
    // MARK: - IBActions
    
    @IBAction func showEmailAndPasswordTextFields(_ sender: Any) {
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.firstAndLastNameView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            self.emailAndPasswordView.transform = CGAffineTransform(translationX: -self.view.frame.width + 51, y: 0)
        })
        pageControl.currentPage = 1
    }
}

// MARK: - UITextFieldDelegate
extension StudentSignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            lastNameTextField.becomeFirstResponder()
        case 1:
            lastNameTextField.resignFirstResponder()
        default:
            ()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            if firstNameTextField.text?.count ?? 0 > 0 {
                firstNameCheckmark.isHidden = false
                firstNameCheckmark.play()
            }
        case 1:
            if lastNameTextField.text?.count ?? 0 > 0 {
                lastNameCheckmark.isHidden = false
                lastNameCheckmark.play()
            }
        default:
            ()
        }
    }
}

extension StudentSignupViewController: EmailAndPasswordViewControllerDelegate {
    func nextButtonTapped() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.emailAndPasswordView.transform = CGAffineTransform(translationX: (-2 * self.view.frame.width), y: 0)
            
        })
        pageControl.currentPage = 2
    }
}
