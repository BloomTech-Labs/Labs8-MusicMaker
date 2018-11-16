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
    var sideMenuViewController: SideMenuViewController!

    
    // MARK: - IBOutlets
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var teachersView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuViewController = self.children[0] as? SideMenuViewController
        teachersViewController =  self.children[1].children[0] as? TeachersViewController
        teachersViewController.delegate = self
        sideMenuViewController.delegate = self
        
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(hideSideMenu))
        teachersView.addGestureRecognizer(touchGesture)
    }
    
    @objc private func hideSideMenu() {
        UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: {
            self.sideMenu.alpha = 0
        })
        sideMenuViewController.animateHidingOfMenu()
        self.sideMenu.layer.shadowOpacity = 0
    }
    

}

// MARK: - TeachersViewControllerDelegate
extension ContainerViewController: TeachersViewControllerDelegate {
    func showSideMenu() {
        self.view.bringSubviewToFront(sideMenu)
        UIView.animate(withDuration: 0.4) {
            self.sideMenu.alpha = 1
        }
        sideMenuViewController.animateShowingOfMenu()
        self.sideMenu.layer.shadowOpacity = 0.8
    }
}

extension ContainerViewController: SideMenuDelegate {
    func userProfileClicked() {
        let storyboard = UIStoryboard(name: "Teachers", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserProfile")
        self.presentDetail(viewController)
    }
}


