//
//  ContainerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    
    override func viewDidLoad() {
        teachersViewController = UIStoryboard.teachersViewController()
        teachersViewController.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name("test"), object: nil)
        
    
    }
    
    @objc func test() {
        self.menuView.isHidden = false
        self.view.bringSubviewToFront(menuView)
        UIView.animate(withDuration: 0.4) {
            self.menuView.alpha = 1
        }
    }

    
    var teachersViewController: TeachersViewController!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var teachersView: UIView!
}

extension ContainerViewController: TeacherViewControllerDelegate {
    
    func toggleLeftPanel() {
        self.menuView.isHidden = false
        self.view.bringSubviewToFront(menuView)
        UIView.animate(withDuration: 0.4) {
            self.menuView.alpha = 1
        }
    }
    
}

private extension UIStoryboard {
    
    static func teachersStoryboard() -> UIStoryboard { return UIStoryboard(name: "Teachers", bundle: Bundle.main) }
    
    
    static func menuViewController() -> MenuViewController {
        return teachersStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    }
    
    static func teachersViewController() -> TeachersViewController {
         return teachersStoryboard().instantiateViewController(withIdentifier: "TeachersViewController") as! TeachersViewController
    }
    
//    static func leftViewController() -> SidePanelViewController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "LeftViewController") as? SidePanelViewController
//    }
    

}
