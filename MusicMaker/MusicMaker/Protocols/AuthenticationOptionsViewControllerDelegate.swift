//
//  AuthenticationOptionsViewControllerDelegate.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/29/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation

//Conforming types must be able to handle what to do when each authentication option is selected
protocol AuthenticationOptionsViewControllerDelegate: class {
    func dismissOptions()
    func authenticateWithEmail(for newUser: Bool)
    func authenticateWithGoogle()
}
