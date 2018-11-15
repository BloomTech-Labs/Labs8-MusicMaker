//
//  ContainerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    
    // MARK: - Properties
    var teachersViewController: TeachersViewController!
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var teachersView: UIView!
    var sideMenuViewController: SideMenuViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuViewController = self.children[0] as? SideMenuViewController
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(hideSideMenu))
        teachersView.addGestureRecognizer(touchGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(showSideMenu), name: .shouldShowSideMenu, object: nil)
    }
    
    @objc private func hideSideMenu() {
        UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: {
            self.sideMenu.alpha = 0
        })
        sideMenuViewController.animateHidingOfMenu()
    }
    
    @objc private func showSideMenu() {
        self.view.bringSubviewToFront(sideMenu)
        UIView.animate(withDuration: 0.4) {
            self.sideMenu.alpha = 1
        }
        sideMenuViewController.animateShowingOfMenu()
    }

}


