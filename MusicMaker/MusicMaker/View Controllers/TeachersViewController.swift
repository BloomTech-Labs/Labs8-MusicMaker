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
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenuFromUserTap))
        self.view.addGestureRecognizer(touchGesture)
    }
    
    // MARK: - Properties
    var sideMenuIsShowing = false
    weak var delegate: TeachersViewControllerDelegate?
    var student: Student?
    
    // MARK: - Private Methods
    @objc private func hideMenuFromUserTap() {
        if sideMenuIsShowing {
            showSideMenu(self)
        }
    }
    

    // MARK: - IBActions
    @IBAction func showSideMenu(_ sender: Any) {
        delegate?.menuButtonTapped()
        sideMenuIsShowing = sideMenuIsShowing ? false : true
    }
}
