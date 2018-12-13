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
    
    @IBOutlet weak var highlightView: UIView!
    
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
    
    override var isSelected: Bool {
        didSet {
            // check isSelected and set the view isHidden
            if isSelected {
                highlightView?.isHidden = false
                highlightView?.layer.borderWidth = 3.0
                highlightView?.layer.borderColor = #colorLiteral(red: 0.007843137255, green: 0.5176470588, blue: 0.6588235294, alpha: 0.8)
            } else {
                highlightView?.isHidden = true
            }
        }
    }
}
