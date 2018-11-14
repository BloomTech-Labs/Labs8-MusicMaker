//
//  DELETE.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/13/18.
//  Copyright © 2018 Vuk. All rights reserved.
//


import UIKit

class asdf: UIViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.centerVertically()
        }
    }
    
    @IBOutlet weak var supportButton: UIButton! {
        didSet {
            supportButton.centerVertically()
        }
    }
    
    
    
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.centerVertically()
        }
    }
    
    @IBOutlet weak var homeButton: UIButton! {
        didSet {
            homeButton.centerVertically()
        }
    }
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var blurredView: UIView!
    var addedMenuAsSubview = false
    // MARK: - IBActions
    
    
    @IBAction func menuTapped(_ sender: UIButton) {
        showMenu()
    }
    
    
    private func showMenu() {
        //        menuView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.3, height: UIApplication.shared.keyWindow!.frame.height)
        //        blurredView.frame = CGRect(x: menuView.frame.width, y: 0, width: self.view.frame.width * 0.7, height: UIApplication.shared.keyWindow!.frame.height)
        UIView.animate(withDuration: 0.4) {
            self.menuView.alpha = 1
            self.blurredView.alpha = 1
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissMenuView(gesture:)))
        blurredView.addGestureRecognizer(tapGesture)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(dismissMenuView(gesture:)))
        swipeLeft.direction = .left
        menuView.addGestureRecognizer(swipeLeft)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        UIApplication.shared.keyWindow?.addSubview(menuView)
        //        UIApplication.shared.keyWindow?.addSubview(blurredView)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        menuView.removeFromSuperview()
        //        blurredView.removeFromSuperview()
    }
    
    @objc func dismissMenuView(gesture: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.4) {
            self.menuView.alpha = 0
            self.blurredView.alpha = 0
            //            print("hi")
        }
    }
    
    
}
