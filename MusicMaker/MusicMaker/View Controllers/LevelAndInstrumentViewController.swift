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
    weak var delegate: LevelAndInstrumentViewControllerDelegate?
    
   // MARK: - IBOutlets
    @IBOutlet weak var starRating: StarRating!
    @IBOutlet weak var levelLabel: UILabel!
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
    
    @IBAction func starRatingChanged(_ sender: StarRating) {
        switch sender.value {
        case 1:
            levelLabel.text = "Beginner"
        case 2:
            levelLabel.text = "Intermediate"
        case 3:
            levelLabel.text = "Expert"
        default:
            break
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        if let instrument = instrumentTextField.text {
            delegate?.signUpButtonTapped(with: levelLabel.text!, instrument: instrument)
        }
    }
}

// MARK: - UITextFieldDelegate
extension LevelAndInstrumentViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if instrumentTextField.text?.count ?? 0 > 0 {
            instrumentAnimation.play()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        instrumentTextField.resignFirstResponder()
        return true
    }
}
