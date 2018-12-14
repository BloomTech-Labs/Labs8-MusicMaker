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
import Charts
import FirebaseMessaging

class TeachersViewController: UIViewController, UIGestureRecognizerDelegate {
   

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        splitViewController?.preferredDisplayMode = .allVisible
        splitViewController?.delegate = self
        tableView.rowHeight = 375
        fetchStudent()
        NotificationCenter.default.addObserver(self, selector: #selector(hideQrView), name: .newTeacher, object: nil)
        addTokenIdToStudent()
        refreshTeachers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(addTokenIdToStudent), name: NSNotification.Name("FCMToken"), object: nil)
        refreshTeachers()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tapBGGesture = UITapGestureRecognizer(target: self, action: #selector(teacherViewTappedWhenFormSheetIsShowing))
        tapBGGesture.delegate = self
        tapBGGesture.numberOfTapsRequired = 1
        tapBGGesture.cancelsTouchesInView = false
        self.view.window!.addGestureRecognizer(tapBGGesture)
    }
    
 
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("FCMToken"), object: nil)
        }
    
    
    override func viewDidLayoutSubviews() {
        qrViewTopConstraint.constant = qrViewIsShowing ? -self.view.frame.height : 0
    }

    
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var qrView: UIView!
    @IBOutlet weak var qrViewTopConstraint: NSLayoutConstraint!
    var qrViewIsShowing = false
    
    // MARK: - Properties
    var student: Student?
    var teachers = [Teacher]()
    private var tapBGGesture: UITapGestureRecognizer!

    
    
    // MARK: - Private Methods
    private func refreshTeachers() {
        MusicMakerModelController.shared.fetchTeachers { (teachers, error) in
            guard error == nil else {return}
            if let teachers = teachers {
                self.teachers = teachers
                self.tableView.reloadData()
            }
        }
    }
    @objc private func hideQrView() {
        showQrOptions(self)
        NotificationCenter.default.post(name: .qrHidden, object: nil)
        refreshTeachers()
    }
    @objc private func teacherViewTappedWhenFormSheetIsShowing(sender: UITapGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.ended{
            guard let presentedView = presentedViewController?.view else {
                return
            }
            if !presentedView.bounds.contains(sender.location(in: presentedView)) {
                self.dismiss(animated: true, completion: { () -> Void in
                })
            }
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
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
    
    @objc private func addTokenIdToStudent() {
        guard let currentUsersUid = Auth.auth().currentUser?.uid else {return}
        let database = Firestore.firestore()
        let studentsCollectionReference = database.collection("students").document(currentUsersUid)
        if let fcmToken = Messaging.messaging().fcmToken {
            studentsCollectionReference.setData(["token": fcmToken], merge: true)
        }
    }

    // MARK: - IBActions
    @IBAction func showQrOptions(_ sender: Any) {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            if qrViewTopConstraint.constant == 0 {
                NotificationCenter.default.post(name: .qrShown, object: nil)
                qrViewTopConstraint.constant = -self.view.frame.height
                qrViewIsShowing = true
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                })
            } else {
                qrViewTopConstraint.constant = 0
                qrViewIsShowing = false
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }) { (_) in
                }
            }
        case .pad:
            self.performSegue(withIdentifier: "PresentQRScanner", sender: nil)
        default:
            break
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
            if let navController = segue.destination as? UINavigationController {
                if let userProfileVC = navController.topViewController as? UserProfileViewController {
                    userProfileVC.student = student
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell", for: indexPath) as! TeacherTableViewCell
        let teacher = teachers[indexPath.row]
        cell.teacher = teacher
        cell.pieChartDataEntry = sortTeacherAssignments(for: teacher)
       
        return cell
    }
    
    private func sortTeacherAssignments(for teacher: Teacher) -> [PieChartDataEntry] {
        let numberOfUnsubmittedAssignments = PieChartDataEntry(value: 0, label: "Unsubmitted")
        let numberOfPassedAssignments = PieChartDataEntry(value: 0, label: "Passed")
        let numberOfFailedAssignments = PieChartDataEntry(value: 0, label: "Failed")
        let numberOfPendingAssignments = PieChartDataEntry(value: 0, label: "Pending")
        let other = PieChartDataEntry(value: 0, label: "Other")
        let allAssigments = [numberOfUnsubmittedAssignments, numberOfPassedAssignments, numberOfFailedAssignments, numberOfPendingAssignments, other]
        if let assignments = teacher.assignments as? Set<Assignment> {
            for assignment in assignments {
                switch assignment.status {
                case .unsubmitted(_, _):
                    numberOfUnsubmittedAssignments.value += 1
                case .submitted(grade: "Passed"):
                    numberOfPassedAssignments.value += 1
                case .submitted(grade: "Failed"):
                    numberOfFailedAssignments.value += 1
                case .submitted(grade: nil):
                    numberOfPendingAssignments.value += 1
                case .submitted:
                    other.value += 1
                }
            }
        }
        var pieChartDataEntries = [PieChartDataEntry]()
        for assignment in allAssigments {
            if assignment.value > 0 {
                pieChartDataEntries.append(assignment)
                
            }
        }
        return pieChartDataEntries
    }
}

// MARK: - UITableViewDelegate
extension TeachersViewController: UITableViewDelegate {
    
}

// MARK: - UISplitViewControllerDelegate
extension TeachersViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let _ = splitViewController.viewControllers.last as? UnsubmittedAssignmentViewController, let _ = splitViewController.viewControllers.last as? SubmittedAssignmentViewController {
            return false
        }
        return true
    }
}

// MARK: - UIGestureRecognizerDelegate
func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
}

