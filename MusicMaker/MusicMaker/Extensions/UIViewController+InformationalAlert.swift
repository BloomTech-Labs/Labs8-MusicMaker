//
//  UIViewController+InformationalAlert.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/2/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
    
    func presentInformationalAlertController(title: String?, message: String?, dismissActionCompletion: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: dismissActionCompletion)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true, completion: completion)
    }
}
