//
//  MusicSheetPDFSingleViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import PDFKit

class MusicSheetPDFSingleViewController: UIViewController {
    
    var pdfPage: PDFPage? {
        didSet {
            guard let pdfPage = pdfPage else { return }
            pdfView?.go(to: pdfPage)
        }
    }
    
    @IBOutlet weak var pdfView: PDFView! {
        didSet {
            pdfView.displayMode = .singlePage
            pdfView.autoScales = true
        }
    }
    
    @IBAction func previousPage(_ sender: Any) {
        pdfView.goToPreviousPage(sender)
    }
    
    @IBAction func nextPage(_ sender: Any) {
        pdfView.goToNextPage(sender)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
