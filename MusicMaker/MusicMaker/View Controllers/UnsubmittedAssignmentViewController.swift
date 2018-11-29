//
//  UnsubmittedAssignmentViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/6/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import PDFKit
import AVFoundation

class UnsubmittedAssignmentViewController: UITableViewController, AssignmentMusicPieceTableViewCellDelegate, AssignmentSubmitTableViewCellDelegate {
    
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
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = assignment?.localRecordingURL {
            return 6
        } else {
            return 4
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! AssignmentHeaderTableViewCell
            
            cell.assignmentTitle = assignment?.title
            cell.dueDate = assignment?.dueDate   // sets date and time in custom cell
            cell.instrument = assignment?.instrumentEmoji
            cell.level = assignment?.level
            
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
            cell.teacher = assignment?.teacher?.name
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordButtonCell", for: indexPath) as! RecordButtonTableViewCell
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaybackCell", for: indexPath) as! AssignmentPlaybackTableViewCell
            
            cell.playerViewController?.player = AVPlayer(url: assignment!.localRecordingURL!)
            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SaveSubmitCell", for: indexPath) as! AssignmentSaveSubmitTableViewCell
            
            cell.delegate = self
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
    
    // MARK: - AssignmentSubmitTableViewCellDelegate
    
    func submitButtonWasPressed(for cell: AssignmentSaveSubmitTableViewCell) {
        guard let assignment = assignment else { return }
        
        class AlertLoadingIndicatorViewController: UIViewController {
            override func loadView() {
                let view = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 60)))
                view.translatesAutoresizingMaskIntoConstraints = false
                
                let loadingIndicator = UIActivityIndicatorView(frame: view.bounds)
                loadingIndicator.style = .whiteLarge
                loadingIndicator.color = .gray
                loadingIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                loadingIndicator.startAnimating()
                
                view.addSubview(loadingIndicator)
                
                self.view = view
                
                self.preferredContentSize = view.bounds.size
            }
        }
        
        let loadingAlert = UIAlertController(title: "Submitting Assignment…", message: nil, preferredStyle: .alert)
        
        loadingAlert.setValue(AlertLoadingIndicatorViewController(), forKey: "contentViewController")
        
        present(loadingAlert, animated: true, completion: nil)
        
        MusicMakerModelController.shared.submit(assignment: assignment) { (assignment, error) in
            loadingAlert.dismiss(animated: true, completion: nil)
            
            if let error = error {
                NSLog("Error submitting video: \(error)")
                let errorAlert = UIAlertController(title: "Error Submitting Assignment", message: "Please try again later.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            } else {
                let successAlert = UIAlertController(title: "Assignment Submitted!", message: "Your assignment has been successfully submitted! Good luck!", preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "Yay!", style: .default, handler: nil))
                self.present(successAlert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recordVC = segue.destination as? RecordingViewController else { return }
        
        recordVC.assignment = assignment
        recordVC.pdfDocument = pdfDocument
        
        if segue.identifier == "ShowPagePreview" {
            // Extract the pdfPage from the sender because we don't have direct access to the page
            guard let pdfPage = sender as? PDFPage else { return }
            recordVC.pdfPage = pdfPage
        } else if let pdfDocument = pdfDocument {
            recordVC.pdfPage = pdfDocument.page(at: 0)
        }
    }

}
