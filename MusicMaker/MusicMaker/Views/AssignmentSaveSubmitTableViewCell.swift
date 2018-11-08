//
//  AssignmentSubmitTableViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/8/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AssignmentSaveSubmitTableViewCell: UITableViewCell {
    
    // MARK: - Outlets/Actions
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // save locally
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        // post to firebase
        // get notification if submitting is successful
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
