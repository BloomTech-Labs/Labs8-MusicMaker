//
//  AssignmentInstructionsTableViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/8/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AssignmentInstructionsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var instructions: String? {
        didSet {
            guard let instructions = instructions else {
                bodyTextLabel.text = "There are no instructions!"
                return
            }
            
            bodyTextLabel.text = instructions
        }
    }
    
    var feedback: String? {
        didSet {
            guard let feedback = feedback else {
                bodyTextLabel.text = "There are no feedbacks!"
                return
            }
            
            bodyTextLabel.text = feedback
        }
    }
    
    var teacher: String? {
        didSet {
            guard let teacher = teacher else {
                teacherLabel.text = "--"
                return
            }
            teacherLabel.text = "- \(teacher)"
        }
    }
    
    // MARK: - Outlets

    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    
}
