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
    var assignment: Assignment? = MusicMakerModelController.shared.teachers.first?.assignments?.anyObject() as? Assignment {
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
            tableView.reloadData()
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
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicPieceCell", for: indexPath) as! AssignmentMusicPieceTableViewCell
            
            cell.musicPiece = "this is a test music piece name that is really really long because i want to see"
            cell.pdfDocument = pdfDocument
            cell.delegate = self
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as! AssignmentInstructionsTableViewCell
            
            cell.instructions = "This instruction is just a test because I want to see how long this will go on for, but I really don't know until I start testing it. This could take some times as I think of something to type here. This is stil not long enough so I'm going to make up some more stuff. Maybe this should be good now?"
//            cell.teacher = "Mrs. Mozart"
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath) as! AssignmentInstructionsTableViewCell
            
            cell.feedback = "This is the teacher's feedback for the student regarding their performance."
//            cell.teacher = "Mrs. Mozart"
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaybackCell", for: indexPath) as! AssignmentPlaybackTableViewCell
            
            cell.playerViewController?.player = AVPlayer(url: assignment!.localRecordingURL!)
            
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
}
