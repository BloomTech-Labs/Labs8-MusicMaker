//
//  LevelAndInstrumentViewDelegate.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation

protocol LevelAndInstrumentViewControllerDelegate: class {
    func signUpButtonTapped(with level: String, instrument: String)
}
