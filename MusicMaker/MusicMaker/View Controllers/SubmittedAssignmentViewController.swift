//
//  SubmittedAssignmentViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/28/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class SubmittedAssignmentViewController: UITableViewController {
    
    // This is our dummy assignment that is in core data
    var assignment: Assignment? = MusicMakerModelController.shared.teachers.first?.assignments?.anyObject() as? Assignment
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! AssignmentHeaderTableViewCell
            
            //            cell.assignmentTitleLabel.text = "this is a test assignment"
            //            cell.dueDateLabel.text = "DEC 9"
            //            cell.dueTimeLabel.text = "8:00 PM"
            //            cell.instrumentLabel.text = "🎻"
            
            cell.assignmentTitle = assignment?.title
            cell.dueDate = Date()   // sets date and time in custom cell
            cell.instrument = "🎻"
            cell.level = .intermediate
            //            Level(rawValue: assignment?.level)
            
            return cell
        default:
            fatalError("We forgot a case: \(indexPath.row)")
        }
    }
}
