//
//  MusicSheetPDFSingleViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 12/3/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class MusicSheetPDFSingleViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView! {
        didSet {
            pdfView.displayMode = .singlePage
            pdfView.autoScales = true
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
