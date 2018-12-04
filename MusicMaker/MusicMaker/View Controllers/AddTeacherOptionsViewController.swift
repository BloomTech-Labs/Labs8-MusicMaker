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

    }
    
    private func setupScrollViewChildren() {
        let qrScanner = storyboard!.instantiateViewController(withIdentifier: "QRScanner") as! QRScannerViewController
        qrScanner.delegate = self
        scrollView.addSubview(qrScanner.view)
        addChild(qrScanner)
        qrScanner.didMove(toParent: self)
        qrScanner.view.translatesAutoresizingMaskIntoConstraints = false
        let qrReader = storyboard!.instantiateViewController(withIdentifier: "QRReader") as! AddQRPhotoViewController
        qrReader.delegate = self
        
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
    
    @IBOutlet weak var underlineBarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var underlineBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    private var isScrolling = true
    var isSigningUpWithGoogle = false
    var teacherUniqueId: String?
    var email: String?
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - IBActions

    @IBAction func addQrCodeFromPhotos(_ sender: Any) {
        underlineBarLeadingConstraint.constant = view.frame.width / 2
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * 1
        frame.origin.y = 0
        isScrolling = false
        scrollView.scrollRectToVisible(frame, animated: true)
        
        
    }
    
    
    @IBAction func scanQrCodeButtonTapped(_ sender: Any) {
        underlineBarLeadingConstraint.constant = 0
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        isScrolling = false
        scrollView.scrollRectToVisible(scrollView.frame, animated: true)
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowSignUp":
            if let destinationVC = segue.destination as? StudentSignupViewController {
                destinationVC.isSigningUpWithGoogle = isSigningUpWithGoogle
                destinationVC.teacherUniqueId = teacherUniqueId
                destinationVC.email = email
            }
        default:
            break
        }
    }
    
}

// MARK: - UIScrollViewDelegate
extension AddTeacherOptionsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isScrolling {
            underlineBarLeadingConstraint.constant = scrollView.contentOffset.x / 2
        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isScrolling = true
    }
}

// MARK: - QRScanningDelegate
extension AddTeacherOptionsViewController: QRScanning {
    
    func qrCodeScanned(_ qrCode: String) {
        
        if teacherUniqueId != qrCode {
            teacherUniqueId = qrCode
            self.performSegue(withIdentifier: "ShowSignUp", sender: nil)
        }
    }
    
    
   
    
}



