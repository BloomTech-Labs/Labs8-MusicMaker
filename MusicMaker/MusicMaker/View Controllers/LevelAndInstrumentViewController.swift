//
//  LevelAndInstrumentViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Lottie


class LevelAndInstrumentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Delegate
    weak var delegate: LevelAndInstrumentViewDelegate?
    
   // MARK: - IBOutlets
    @IBOutlet weak var starRating: StarRating!
    
    @IBOutlet weak var instrumentAnimation: LOTAnimationView! {
        didSet {
            instrumentAnimation.animation = "checked_done_"
            instrumentAnimation.contentMode = .scaleAspectFit
            instrumentAnimation.isHidden = true
        }
    }
    @IBOutlet weak var instrumentTextField: HoshiTextField! {
        didSet {
            instrumentTextField.delegate = self
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func signUp(_ sender: Any) {
        switch starRating.value {
        case 0:
            delegate?.signUpButtonTapped(with: "Beginner", instrument: instrumentTextField.text!)
        case 1:
            delegate?.signUpButtonTapped(with: "Intermediate", instrument: instrumentTextField.text!)
        case 2:
            delegate?.signUpButtonTapped(with: "Expert", instrument: instrumentTextField.text!)
        default:
            break
        }
    }
}

// MARK: - UITextFieldDelegate
extension LevelAndInstrumentViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        instrumentAnimation.play()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        instrumentTextField.resignFirstResponder()
        return true
    }
}
