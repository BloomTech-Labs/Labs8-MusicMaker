//
//  FirstAndLastNameViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

protocol FirstAndLastNameViewControllerDelegate: class {
    func nextButtonTapped()
}

class FirstAndLastNameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Delegate
    weak var delegate: FirstAndLastNameViewControllerDelegate?

    
    // MARK: - IBOutlets

    // MARK: - IBActions
    
    
}
