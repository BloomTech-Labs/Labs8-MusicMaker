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

 
    // MARK: - Properties
    private let allInstrument = ["Guitar", "Piano", "Drums", "Saxophone", "Trumpet", "Violin"]
    private var studentsInstrument: String?
    
    // MARK: - Delegate
    weak var delegate: LevelAndInstrumentViewControllerDelegate?
    
   // MARK: - IBOutlets
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var beginnerStar: UIButton!
    @IBOutlet weak var intermediateStar: UIButton!
    @IBOutlet weak var expertStar: UIButton!

    
    
    @IBOutlet var instrumentButtons: [UIButton]!
    
    
    // MARK: - IBActions
    @IBAction func levelChanged(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            intermediateStar.titleLabel?.textColor = UIColor.blue4
            expertStar.titleLabel?.textColor = UIColor.blue4
            levelLabel.text = "Beginner"
        case 1:
            intermediateStar.setTitleColor(UIColor.blue2, for: .normal)
            expertStar.titleLabel?.textColor = UIColor.blue4
            levelLabel.text = "Intermediate"
        case 2:
            intermediateStar.titleLabel?.textColor = UIColor.blue2
            expertStar.setTitleColor(UIColor.blue2, for: .normal)
            levelLabel.text = "Expert"
        default:
            break
        }
    }
    
    @IBAction func instrumentSelected(_ sender: UIButton) {
        for instrument in instrumentButtons {
            if instrument.tag == sender.tag {
                instrument.backgroundColor = UIColor.lightGray
            } else {
                instrument.backgroundColor = UIColor.clear
            }
        }
        studentsInstrument = allInstrument[sender.tag]
        signupButton.alpha = 1
        signupButton.isEnabled = true
    }
    
    @IBAction func signUp(_ sender: Any) {
        if let instrument = studentsInstrument {
            delegate?.signUpButtonTapped(with: levelLabel.text!, instrument: instrument)
        } else {
            presentInformationalAlertController(title: "No instrument is selected", message: "Please select an instrument to complete sign up")
        }
    }
}


