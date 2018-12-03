//
//  EmailAndPasswordViewControllerDelegate.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation

protocol EmailAndPasswordViewControllerDelegate: class {
    func nextButtonTapped(with email: String, password: String)
}
