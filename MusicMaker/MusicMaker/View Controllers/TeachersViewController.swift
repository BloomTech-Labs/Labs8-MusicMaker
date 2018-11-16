//
//  TeachersViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class TeachersViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Properties
    weak var delegate: TeachersViewControllerDelegate?
    
    // MARK: - IBActions
    //Posts a notification to let other views know to show the side menu
    @IBAction func showSideMenu(_ sender: Any) {
        delegate?.showSideMenu()
//        NotificationCenter.default.post(name: .shouldShowSideMenu, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserProfile" {
            print(1)
        }
    }
    
    
}




