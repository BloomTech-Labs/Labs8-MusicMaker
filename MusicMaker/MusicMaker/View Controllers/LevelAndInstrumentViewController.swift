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
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var starRating: StarRating!
    @IBOutlet weak var levelLabel: UILabel!


    
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


