//
//  RecordButtonTableViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/8/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class RecordButtonTableViewCell: UITableViewCell {
    
    // MARK: - Outlets/Actions
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        // present the recording screen
    }
    
    override func awakeFromNib() {  // This will never be called if the cell is created in code.
        super.awakeFromNib()
        
        recordButton.layer.cornerRadius = 5
        recordButton.clipsToBounds = true
//        recordButton.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
