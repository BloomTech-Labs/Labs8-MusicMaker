//
//  TeachersViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class TeachersViewController: UIViewController {


    
    
    // MARK: - IBActions
    @IBAction func showSideMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("test"), object: nil)
    }
    
    
    
}
