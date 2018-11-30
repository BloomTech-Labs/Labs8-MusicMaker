//
//  AssignmentsViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/28/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AssignmentsViewController: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var assignments = [Assignment]()
    var teacher: Teacher?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let teacher = teacher {
            MusicMakerModelController.shared.fetchAssigments(for: teacher) { (assignments, error) in
                if let assignments = assignments {
                    self.assignments = assignments
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let assignment = assignments[indexPath.row]
        
        if let destinationVC = segue.destination as? UnsubmittedAssignmentViewController {
            destinationVC.assignment = assignment
        } else if let destinationVC = segue.destination as? SubmittedAssignmentViewController {
            destinationVC.assignment = assignment
        }
    }
}

// MARK: - UITableViewDataSource
extension AssignmentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath)
        let assignment = assignments[indexPath.row]
        cell.textLabel?.text = assignment.title
        return cell
    }
}

extension AssignmentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assignment = assignments[indexPath.row]
        
        switch assignment.status {
        case .unsubmitted(isLate: _, isInProgress: _):
            performSegue(withIdentifier: "ShowUnsubmittedAssignment", sender: self)
        case .submitted(grade: _):
            performSegue(withIdentifier: "ShowSubmittedAssignment", sender: self)
        }
    }
}