//
//  TeachersViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import AVFoundation


class TeachersViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenuFromUserTap))
        touchGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(touchGesture)
        MusicMakerModelController.shared.fetchTeachers { (teachers, error) in
            guard error == nil else {return}
            if let teachers = teachers {
                self.teachers = teachers
                self.tableView.reloadData()
            }
        }
        qrView.setupCaptureSession()
        let captureMetadataOutput = AVCaptureMetadataOutput()
        qrView.captureSession?.addOutput(captureMetadataOutput)
     
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
  
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        
        qrView.isHidden = true
        qrView.captureSession?.startRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var sideMenuIsShowing = false
    weak var delegate: TeachersViewControllerDelegate?
    var student: Student?
    var teachers = [Teacher]()
    // MARK: - Private Methods
    @objc private func hideMenuFromUserTap() {
        if sideMenuIsShowing {
            showSideMenu(self)
        }
    }
    @IBOutlet weak var qrView: QRView!
    

    // MARK: - IBActions
    @IBAction func showSideMenu(_ sender: Any) {
        delegate?.menuButtonTapped()
        sideMenuIsShowing = sideMenuIsShowing ? false : true
    }
    
    @IBAction func showQR(_ sender: Any) {
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let teacher = teachers[indexPath.row]
        if segue.identifier == "ShowAssignments" {
            let destinationVc = segue.destination as? AssignmentsViewController
            if let assignmentsVc = destinationVc {
                assignmentsVc.teacher = teacher
            }
        }
    }
}


// MARK: - UITableViewDataSource
extension TeachersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell", for: indexPath)
        let teacher = teachers[indexPath.row]
        cell.textLabel?.text = teacher.name
        cell.imageView?.image = cell.imageView?.returnImageForInitials(for: teacher.name, backgroundColor: .lightGray)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TeachersViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "ShowAssignments", sender: nil)
//    }
    
    
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension TeachersViewController: AVCaptureMetadataOutputObjectsDelegate {
    
}
