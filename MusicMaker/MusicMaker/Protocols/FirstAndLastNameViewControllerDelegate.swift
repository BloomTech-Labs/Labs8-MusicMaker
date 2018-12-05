//
//  FirstAndLastNameViewControllerDelegate.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/4/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation

protocol FirstAndLastNameViewControllerDelegate: class {
    func nextButtonTapped(firstName: String, lastName: String)
}
