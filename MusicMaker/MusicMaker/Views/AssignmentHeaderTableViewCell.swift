//
//  AssignmentHeaderTableViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/7/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AssignmentHeaderTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var assignmentTitle: String? {
        didSet {
            assignmentTitleLabel.text = assignmentTitle
        }
    }
    
    var dueDate: Date? {
        didSet {
            guard let dueDate = dueDate else {
                dueDateLabel.text = "Not"
                dueTimeLabel.text = "Due"
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            dueDateLabel.text = dateFormatter.string(from: dueDate)
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            dueTimeLabel.text = timeFormatter.string(from: dueDate)
        }
    }
    
    var instrument: String? {
        didSet {
            instrumentLabel.text = instrument
        }
    }
    
    var level: String? { // maybe as an enum?
        didSet {
            // pick image based on level
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var assignmentTitleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueTimeLabel: UILabel!
    @IBOutlet weak var instrumentLabel: UILabel!
    // replace star labels with an image view to indicate the level

    
}
