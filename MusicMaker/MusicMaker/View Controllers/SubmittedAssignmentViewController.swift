//
//  SubmittedAssignmentViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/28/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import PDFKit

class SubmittedAssignmentViewController: UITableViewController, AssignmentMusicPieceTableViewCellDelegate {
    
    // This is our dummy assignment that is in core data
    var assignment: Assignment? = MusicMakerModelController.shared.teachers.first?.assignments?.anyObject() as? Assignment
    
    var pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "SamplePDF", withExtension: "pdf")!)!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
