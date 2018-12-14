//
//  QRScannerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/30/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddTeacherOptionsViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        setupScrollViewChildren()
        scrollView.isPagingEnabled = true
        

    }
    
    private func setupScrollViewChildren() {
        qrScanner = storyboard!.instantiateViewController(withIdentifier: "QRScanner") as? QRScannerViewController
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
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[qrScanner(==view)]|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[qrScanner(==view)][qrReader(==view)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(verticalConstraints + horizontalConstraints)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
        preferredContentSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    // MARK: - IBOutlets
    
    @IBOutlet weak var underlineBarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var underlineBar: UIView! {
        didSet {
//            underlineBar.layer.borderColor = UIColor.blue3.cgColor
//            underlineBar.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    private var isScrolling = true
    var isSigningUpWithGoogle = false
    var teacherUniqueId: String?
    var email: String?
    var qrScanner: QRScannerViewController!
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        title = nil
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
            
            if let navigationController = segue.destination as? UINavigationController,
                let studentSignupVC = navigationController.topViewController as? StudentSignupViewController {
                studentSignupVC.isSigningUpWithGoogle = isSigningUpWithGoogle
                studentSignupVC.teacherUniqueId = teacherUniqueId
                studentSignupVC.email = email
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
        let currentUser = Auth.auth().currentUser
        if isSigningUpWithGoogle {
            teacherUniqueId = qrCode
            self.performSegue(withIdentifier: "ShowSignUp", sender: nil)
        }
        if let user = currentUser {
            let database = Firestore.firestore()
            
            
            let teacherDocument = database.collection("teachers").document(qrCode)
            
            teacherDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    NSLog("Error loading teacher \(error)")
                    return
                }
                if let name = documentSnapshot?.data()?["name"] as? [String : String] {
                    database.collection("students").document(user.uid).collection("teachers").document(qrCode).setData(["name": name])
                    database.collection("teachers").document(qrCode).collection("students").document(user.uid).setData(["exists": true])
                    NotificationCenter.default.post(name: .newTeacher, object: nil)
                }
            }
        } else {
            teacherUniqueId = qrCode
            self.performSegue(withIdentifier: "ShowSignUp", sender: nil)
        }
    }
    
    
   
    
}

extension Notification.Name {
    static let newTeacher = Notification.Name("New Teacher")
    static let qrHidden = Notification.Name("QR Hidden")
    static let qrShown = Notification.Name("QR Shown")
}


