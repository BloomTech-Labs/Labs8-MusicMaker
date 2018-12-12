//
//  SignUpNavigationController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/10/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class SignUpNavigationController: UINavigationController {
    
    //Only gets called on iPhones
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}
