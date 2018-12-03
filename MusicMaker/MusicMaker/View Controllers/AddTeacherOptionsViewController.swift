//
//  QRScannerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/30/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class AddTeacherOptionsViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        setupScrollViewChildren()
        scrollView.isPagingEnabled = true
//        if let features = detectQRCode(UIImage(named: "qrcode")), !features.isEmpty{
//            for case let row as CIQRCodeFeature in features{
//                print(row.messageString ?? "nope")
//            }
//        }
    }
    
    func setupScrollViewChildren() {
        let qrScanner = storyboard!.instantiateViewController(withIdentifier: "QRScanner")
        scrollView.addSubview(qrScanner.view)
        addChild(qrScanner)
        qrScanner.didMove(toParent: self)
        qrScanner.view.translatesAutoresizingMaskIntoConstraints = false
        let qrReader = storyboard!.instantiateViewController(withIdentifier: "QRReader")
        
        scrollView.addSubview(qrReader.view)
        addChild(qrReader)
        qrReader.view.translatesAutoresizingMaskIntoConstraints = false
        qrReader.didMove(toParent: self)
        
        let views: [String: UIView] = ["view": scrollView, "qrScanner": qrScanner.view, "qrReader": qrReader.view]
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[qrScanner(==view)]|", options: [], metrics: nil, views: views)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[qrScanner(==view)][qrReader(==view)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(verticalConstraints + horizontalConstraints)
        
    }

    // MARK: - IBOutlets
    
    @IBOutlet weak var menuBarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: - Properties
    
    
    // MARK: - Private Methods
    
    //Detects a QRCode from a UIImage
    private func detectQRCode(_ image: UIImage?) -> [CIFeature]? {
        if let image = image, let ciImage = CIImage.init(image: image){
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            }else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return features
            
        }
        return nil
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - IBActions

    @IBAction func addQrCodeFromPhotos(_ sender: Any) {
        menuBarLeadingConstraint.constant = view.frame.width / 2
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * 1
        frame.origin.y = 0
        isScrolling = false
        scrollView.scrollRectToVisible(frame, animated: true)
        
        
    }
    
    var isScrolling = true
    
    @IBAction func scanQrCodeButtonTapped(_ sender: Any) {
        menuBarLeadingConstraint.constant = 0
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        isScrolling = false
        scrollView.scrollRectToVisible(scrollView.frame, animated: true)
        
    }
}

extension AddTeacherOptionsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isScrolling {
            menuBarLeadingConstraint.constant = scrollView.contentOffset.x / 2
        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isScrolling = true
    }
    
    
}



