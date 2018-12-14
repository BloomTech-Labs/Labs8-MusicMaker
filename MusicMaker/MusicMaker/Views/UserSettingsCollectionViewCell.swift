//
//  UserSettingsCollectionViewCell.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 12/13/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class UserSettingsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellContentView: UIView! {
        didSet {
            cellContentView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    
}
