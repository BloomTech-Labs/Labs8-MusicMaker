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
        self.sideMenu.layer.shadowOpacity = 0.8
        sideMenuViewController = self.children[0] as? SideMenuViewController
        teachersViewController =  self.children[1].children[0] as? TeachersViewController
        teachersViewController.delegate = self
        sideMenuViewController.delegate = self
        
//        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenuFromUserTap))
//        teachersView.addGestureRecognizer(touchGesture)
    }
    
//    @objc private func hideMenuFromUserTap() {
//        showSideMenu()
//    }
//
    private func hideSideMenu() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.sideMenu.alpha = 0
        })
        sideMenuViewController.animateHidingOfMenu()
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: {
            self.teachersView.transform = .identity
        })
    }
    

}

// MARK: - TeachersViewControllerDelegate
extension ContainerViewController: TeachersViewControllerDelegate {
    func showSideMenu() {
        if !teachersViewController.sideMenuIsShowing {
            self.view.bringSubviewToFront(sideMenu)
            UIView.animate(withDuration: 0.4) {
                self.sideMenu.alpha = 1
            }
            sideMenuViewController.animateShowingOfMenu()
            UIView.animate(withDuration: 0.4) {
                self.teachersView.transform = CGAffineTransform(translationX: self.sideMenu.frame.width, y: 0)
            }
        } else {
            hideSideMenu()
        }
     
    }
}

// MARK: - SideMenuDelegate
extension ContainerViewController: SideMenuDelegate {
    func userProfileClicked() {
        self.performSegue(withIdentifier: "ShowUserProfile", sender: nil)
    }
    

}



