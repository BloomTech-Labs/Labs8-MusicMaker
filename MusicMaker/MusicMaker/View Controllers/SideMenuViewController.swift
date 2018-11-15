//
//  SideMenuViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseAuth

class SideMenuViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var profileButton: UIButton! {
        didSet {
            profileButton.centerVertically()
        }
    }
    @IBOutlet weak var assignmentsButton: UIButton! {
        didSet {
            assignmentsButton.centerVertically()
        }
    }
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.centerVertically()

        }
    }
    @IBOutlet weak var resetPasswordButton: UIButton! {
        didSet {
            resetPasswordButton.centerVertically()
            resetPasswordButton.titleLabel?.textAlignment = .center
        }
    }
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.centerVertically()
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func logoutUser(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let initialVC = storyboard.instantiateViewController(withIdentifier: "FirstNavController")
            self.present(initialVC, animated: true, completion: nil)
        } catch {
            //Update UI to let them know it couldn't sign them out
            print(error)
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        setupSideMenuToBeOffScreen()
    }
    
    // MARK: - Private Methods
    //Moves the buttoms off screen so when the menu shows for the first time it can animate it onto the screen
    private func setupSideMenuToBeOffScreen() {
        self.profileButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        self.assignmentsButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        self.settingsButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        self.resetPasswordButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        self.logoutButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
    }
    
    
    func animateHidingOfMenu() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.profileButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
           
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseIn, .allowUserInteraction], animations: {
           self.assignmentsButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        })
        
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseIn, animations: {
            self.settingsButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseIn, animations: {
            self.resetPasswordButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.4, options: .curveEaseIn, animations: {
            self.logoutButton.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        })
    }
    
    func animateShowingOfMenu() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.profileButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.assignmentsButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.settingsButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.3, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.resetPasswordButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.4, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.logoutButton.transform = .identity
        })
    }
}
