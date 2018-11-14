//
//  TeachersViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/13/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class TeachersViewController: UIViewController {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var blurredView: UIView!
    var addedMenuAsSubview = false
    // MARK: - IBActions
    
    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        showMenu()
    }
    
    
    private func showMenu() {
        if !addedMenuAsSubview {
            UIApplication.shared.keyWindow?.addSubview(self.menuView)
            UIApplication.shared.keyWindow?.addSubview(self.blurredView)
            addedMenuAsSubview = true
        }
        UIView.animate(withDuration: 0.4) {
            self.menuView.alpha = 1
            self.blurredView.alpha = 1
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissMenuView(gesture:)))
        blurredView.addGestureRecognizer(tapGesture)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(dismissMenuView(gesture:)))
        swipeLeft.direction = .left
        menuView.addGestureRecognizer(swipeLeft)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @objc func dismissMenuView(gesture: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.4) {
            self.menuView.alpha = 0
            self.blurredView.alpha = 0
            print("hi")
        }
    }
    
    
}
