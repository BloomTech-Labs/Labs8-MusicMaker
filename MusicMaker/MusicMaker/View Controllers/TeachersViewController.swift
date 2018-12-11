//
//  TeachersViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth
import FirebaseFirestore

class TeachersViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudent()
        NotificationCenter.default.addObserver(self, selector: #selector(hideQrView), name: .newTeacher, object: nil)
        
        refreshTeachers()
    }
    
    @objc func hideQrView() {
        showQrOptions(self)
        NotificationCenter.default.post(name: .qrHidden, object: nil)
        refreshTeachers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTeachers()
    }
    
    func refreshTeachers() {
        MusicMakerModelController.shared.fetchTeachers { (teachers, error) in
            guard error == nil else {return}
            if let teachers = teachers {
                self.teachers = teachers
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var qrView: UIView!
    @IBOutlet weak var qrViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var student: Student?
    var teachers = [Teacher]()
    
    
    
    
    // MARK: - Private Methods
    private func fetchStudent() {
        if student == nil {
            guard let currentUsersUid = Auth.auth().currentUser?.uid else {return}
            let database = Firestore.firestore()
            let studentsCollectionReference = database.collection("students").document(currentUsersUid)
            studentsCollectionReference.getDocument { (document, error) in
                if let document = document {
                    if let dataDescription = document.data() as? [String : String] {
                        self.student = Student(dataDescription)
                    }
                }
            }
        }
    }
    

    // MARK: - IBActions
   
    
    @IBAction func showQrOptions(_ sender: Any) {
        
        if qrViewTopConstraint.constant == 0 {
            NotificationCenter.default.post(name: .qrShown, object: nil)
            qrViewTopConstraint.constant = -qrView.frame.height
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            qrViewTopConstraint.constant = 0
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (_) in
                
            }
        }
        
      
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "ShowAssignments":
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let teacher = teachers[indexPath.row]
            if let destinationVc = segue.destination as? AssignmentsTableViewController {
                destinationVc.teacher = teacher
            }
        case "ShowUserProfile":
            if let destinationVc = segue.destination as? UserProfileViewController {
                destinationVc.student = student
            }
        default:
            break
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
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TeachersViewController: UITableViewDelegate {
    
}
