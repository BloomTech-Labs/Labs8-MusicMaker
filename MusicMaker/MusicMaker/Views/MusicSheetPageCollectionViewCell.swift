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
            pdfView.autoScales = false
            pdfView.isUserInteractionEnabled = false
            pdfView.minScaleFactor = 0.01
            
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pdfView.minScaleFactor = 0.01
        pdfView.scaleFactor = pdfView.scaleFactorForSizeToFit
    }
    
    // maybe use layout subviews to fix scrolling of the pdf page?
}
