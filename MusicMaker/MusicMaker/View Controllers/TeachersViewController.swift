//
//  TeachersViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/13/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit




class TeachersViewController: UIViewController {
    
    var delegate: TeacherViewControllerDelegate?


    @IBAction func menuTapped(_ sender: Any) {
        delegate?.toggleLeftPanel()
        NotificationCenter.default.post(name: NSNotification.Name("test"), object: nil)
    }
    
    
    
}
