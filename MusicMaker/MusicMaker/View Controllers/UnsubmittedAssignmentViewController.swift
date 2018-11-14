//
//  UnsubmittedAssignmentViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/6/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import PDFKit

class UnsubmittedAssignmentViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UITableViewDataSource
    
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
            
            cell.assignmentTitle = "this is a test assignment"
            cell.dueDate = Date()   // sets date and time in custom cell
            cell.instrument = "🎻"
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicPieceCell", for: indexPath) as! AssignmentMusicPieceTableViewCell
            
            cell.musicPiece = "this is a test music piece name that is really really long because i want to see"
            cell.pdfDocument = PDFDocument(url: Bundle.main.url(forResource: "SamplePDF", withExtension: "pdf")!)
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as! AssignmentInstructionsTableViewCell
            
            cell.instructions = "This instruction is just a test because I want to see how long this will go on for, but I really don't know until I start testing it. This could take some times as I think of something to type here. This is stil not long enough so I'm going to make up some more stuff. Maybe this should be good now?"
            cell.teacher = "Mrs. Mozart"
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordButtonCell", for: indexPath) as! RecordButtonTableViewCell
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SaveSubmitCell", for: indexPath) as! AssignmentSaveSubmitTableViewCell
            
//            cell.delegate = self
            return cell
        default:
            fatalError("We forgot a case: \(indexPath.row)")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
