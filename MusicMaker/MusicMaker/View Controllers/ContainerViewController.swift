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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        teachersView.addGestureRecognizer(touchGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name("test"), object: nil)
    }
    
    @objc func hideMenu() {
        UIView.animate(withDuration: 0.4) {
            self.sideMenu.alpha = 0
            self.teachersView.backgroundColor = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        }
    }
    
    @objc func test() {
        self.view.bringSubviewToFront(sideMenu)
        UIView.animate(withDuration: 0.4) {
            self.sideMenu.alpha = 1
        }
    }

}


