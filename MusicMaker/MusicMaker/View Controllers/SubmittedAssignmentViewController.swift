//
//  SubmittedAssignmentViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/28/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import PDFKit
import AVFoundation

class SubmittedAssignmentViewController: UITableViewController, AssignmentMusicPieceTableViewCellDelegate {
    
    // This is our dummy assignment that is in core data
    var assignment: Assignment? {
        didSet {
            guard let assignment = assignment else { return }
            guard let pdfURL = assignment.localScoreDocumentURL else {
                MusicMakerModelController.shared.downloadScoreDocument(for: assignment) { (returnedAssignment, error) in
                    if let error = error {
                        // Add an alert here to tell the user
                        NSLog("Error loading PDF \(error)")
                        return
                    }
                    
                    // Make sure that the assignment did not change while it was beign loaded, and check to make sure the loaded assignment (assignment) is exactly the same as the one we had (self.assignment)
                    if self.assignment === assignment, let pdfURL = assignment.localScoreDocumentURL {
                        self.pdfDocument = PDFDocument(url: pdfURL)
                    }
                }
                return
            }
            
            pdfDocument = PDFDocument(url: pdfURL)
        }
    }
    
    var pdfDocument: PDFDocument? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! AssignmentHeaderTableViewCell
            
            if let assignment = assignment {
                cell.assignmentTitle = assignment.title
                cell.dueDate = assignment.dueDate
                cell.instrument = assignment.instrumentEmoji
                cell.level = assignment.level
                
                switch assignment.status {
                case .submitted(let grade):
                    cell.grade = grade
                default:
                    cell.grade = nil
                }
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicPieceCell", for: indexPath) as! AssignmentMusicPieceTableViewCell
            
            cell.musicPiece = assignment?.piece
            cell.pdfDocument = pdfDocument
            cell.delegate = self
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as! AssignmentInstructionsTableViewCell
            
            cell.instructions = assignment?.instructions
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaybackCell", for: indexPath) as! AssignmentPlaybackTableViewCell
            
            if let recordingURL = assignment?.recordingURL {
                cell.playerViewController?.player = AVPlayer(url: recordingURL)
            } else {
                cell.playerViewController?.player = nil
            }
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath) as! AssignmentInstructionsTableViewCell
            
            cell.instructions = assignment?.feedback ?? "Feedback is not yet available."
            cell.teacher = assignment?.teacher?.name
            
            return cell
        default:
            fatalError("We forgot a case: \(indexPath.row)")
        }
    }
    
    // MARK: - AssignmentMusicPieceTableViewCellDelegate
    
    func musicPiecePageWasSelected(for cell: AssignmentMusicPieceTableViewCell, with page: PDFPage) {
        // Use the sender to pass the pdfPage to prepareSegue
        performSegue(withIdentifier: "ShowPagePreview", sender: page)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? MusicSheetPDFSingleViewController else { return }
        
        detailVC.loadViewIfNeeded()
        
        detailVC.pdfView.document = pdfDocument
        
        if segue.identifier == "ShowPagePreview" {
            // Extract the pdfPage from the sender because we don't have direct access to the page
            guard let pdfPage = sender as? PDFPage else { return }
            detailVC.pdfPage = pdfPage
        }
    }
}
