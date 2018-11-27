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
    
    @objc private func hideMenuFromUserTap() {
        if sideMenuIsShowing {
            showSideMenu(self)
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var menuButton: MenuButton!
    
    // MARK: - Properties
    weak var delegate: TeachersViewControllerDelegate?
    var sideMenuIsShowing = false
    // MARK: - IBActions
    //Posts a notification to let other views know to show the side menu
    @IBAction func showSideMenu(_ sender: Any) {
        delegate?.showSideMenu()
        if !sideMenuIsShowing {
            menuButton.animateToX()
            sideMenuIsShowing = true
        } else {
            menuButton.animateToMenu()
            sideMenuIsShowing = false
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserProfile" {
            print(1)
        }
    }
    
    
}
