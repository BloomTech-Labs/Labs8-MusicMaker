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
    
    var level: Assignment.Level? {
        didSet {
            guard let levelImageName = level?.rawValue else { return }
            levelImageView.image = UIImage(named: "Level\(levelImageName)")
        }
    }
    
    var grade: String? {
        didSet {
            guard let grade = grade else {
                gradeImageView?.image = nil
                return
            }
            switch grade {
            case "Passed":
                gradeImageView?.image = UIImage(named: "PassStamp")
            case "Failed":
                gradeImageView?.image = UIImage(named: "FailStamp")
            default:
                gradeImageView?.image = nil
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var assignmentTitleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueTimeLabel: UILabel!
    @IBOutlet weak var instrumentLabel: UILabel!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var gradeImageView: UIImageView?
}
