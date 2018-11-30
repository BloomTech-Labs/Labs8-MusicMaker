//
//  AssignmentSubmitTableViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/8/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

protocol AssignmentSubmitTableViewCellDelegate: class {
    func submitButtonWasPressed(for cell: AssignmentSaveSubmitTableViewCell)
}

class AssignmentSaveSubmitTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: AssignmentSubmitTableViewCellDelegate?
    
    // MARK: - Outlets/Actions
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        delegate?.submitButtonWasPressed(for: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        submitButton.layer.cornerRadius = 5
        submitButton.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
