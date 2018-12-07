//
//  AssignmentTableViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 12/5/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d 'at' h:mma"
        return dateFormatter
    }()
    
    var assignment: Assignment? {
        didSet {
            guard let assignment = assignment else { return }
            
            assignmentNameLabel.text = assignment.title
            musicPieceLabel.text = assignment.piece
            
            if let dueDate = assignment.dueDate {
                dueDateLabel.text = "Due on " + AssignmentTableViewCell.dateFormatter.string(from: dueDate)
            } else {
                dueDateLabel.text = ""
            }
            
            newAssignmentImage.alpha = 0 // make it transparent
            
            switch assignment.status {
            case .unsubmitted(isLate: false, isInProgress: false):
                newAssignmentImage.alpha = 1
            case .unsubmitted(isLate: true, isInProgress: false):
                assignmentStatusImage.image = UIImage(named: "StatusLate")
            case .unsubmitted(isLate: false, isInProgress: true):
                assignmentStatusImage.image = UIImage(named: "StatusInProgress")
            case .unsubmitted(isLate: true, isInProgress: true):
                assignmentStatusImage.image = UIImage(named: "StatusInProgressLate")
            case .submitted(grade: "Passed"):
                assignmentStatusImage.image = UIImage(named: "StatusPass")
            case .submitted(grade: "Failed"):
                assignmentStatusImage.image = UIImage(named: "StatusFail")
            case .submitted(grade: nil):
                assignmentStatusImage.image = UIImage(named: "StatusPending")
            case .submitted(let grade):
                assignmentStatusImage.image = nil
                NSLog("Unknown grade: \(grade!)")
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet var assignmentNameLabel: UILabel!
    @IBOutlet var musicPieceLabel: UILabel!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var newAssignmentImage: UIImageView!
    @IBOutlet var assignmentStatusImage: UIImageView!
    
}
