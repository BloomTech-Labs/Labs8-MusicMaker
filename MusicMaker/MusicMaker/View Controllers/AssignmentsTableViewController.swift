//
//  AssignmentsTableViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 12/5/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import CoreData

class AssignmentsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    
    var teacher: Teacher? {
        didSet {
            title = teacher?.name
            fetchedResultsController = createFetchedResultsController()
            tableView?.reloadData()
        }
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<Assignment> = createFetchedResultsController()
    
    func createFetchedResultsController() -> NSFetchedResultsController<Assignment> {
        let fetchRequest: NSFetchRequest<Assignment> = Assignment.fetchRequest()
        
        if let teacher = teacher {
            fetchRequest.predicate = NSPredicate(format: "teacher == %@", teacher)
        }
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "submissionStatus", ascending: false),
                                        NSSortDescriptor(key: "dueDate", ascending: true),
                                        NSSortDescriptor(key: "title", ascending: true)]
        
        let moc = CoreDataStack.shared.mainContext
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: "submissionStatus",
                                             cacheName: nil)
        // Set this VC as frc's delegate
        frc.delegate = self
        
        try! frc.performFetch()
        
        return frc
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        // NSFetchedResultsChangeType has four types: insert, delete, move, update
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else { return }
//            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            tableView.deleteRows(at: [oldIndexPath], with: .middle)
            tableView.insertRows(at: [newIndexPath], with: .middle)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath) as! AssignmentTableViewCell

        cell.assignment = fetchedResultsController.object(at: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assignment = fetchedResultsController.object(at: indexPath)
        
        switch assignment.status {
        case .unsubmitted(isLate: _, isInProgress: _):
            performSegue(withIdentifier: "ShowUnsubmittedAssignment", sender: self)
        case .submitted(grade: _):
            performSegue(withIdentifier: "ShowSubmittedAssignment", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultsController.sections?[section].name
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let assignment = fetchedResultsController.object(at: indexPath)
        
        if let destinationVC = segue.destination as? UnsubmittedAssignmentViewController {
            destinationVC.assignment = assignment
        } else if let destinationVC = segue.destination as? SubmittedAssignmentViewController {
            destinationVC.assignment = assignment
        }
    }
}
