//
//  AssignmentsTableViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 12/5/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AssignmentsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var assignments: [Assignment] = []
    var teacher: Teacher?

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let teacher = teacher {
            self.assignments = teacher.sortedAssignments
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath) as! AssignmentTableViewCell

        cell.assignment = assignments[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assignment = assignments[indexPath.row]
        
        switch assignment.status {
        case .unsubmitted(isLate: _, isInProgress: _):
            performSegue(withIdentifier: "ShowUnsubmittedAssignment", sender: self)
        case .submitted(grade: _):
            performSegue(withIdentifier: "ShowSubmittedAssignment", sender: self)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let assignment = assignments[indexPath.row]
        
        if let destinationVC = segue.destination as? UnsubmittedAssignmentViewController {
            destinationVC.assignment = assignment
        } else if let destinationVC = segue.destination as? SubmittedAssignmentViewController {
            destinationVC.assignment = assignment
        }
    }
}
