//
//  MusicSheetPageCollectionViewCell.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/7/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import PDFKit

class MusicSheetPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var pdfView: PDFView! {
        didSet {
            pdfView.displayMode = .singlePage
            pdfView.autoScales = true
            pdfView.isUserInteractionEnabled = false
        }
    }
    
    // maybe use layout subviews to fix scrolling of the pdf page?
}
