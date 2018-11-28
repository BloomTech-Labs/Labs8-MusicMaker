//
//  TeachersViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase


class TeachersViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenuFromUserTap))
        self.view.addGestureRecognizer(touchGesture)
        fetchStudent()
    }
    
    
    // MARK: - Properties
    var sideMenuIsShowing = false
    var student: Student?
    weak var delegate: TeachersViewControllerDelegate?
    let database = Firestore.firestore()
    
    // MARK: - Private Methods
    @objc private func hideMenuFromUserTap() {
        if sideMenuIsShowing {
            showSideMenu(self)
        }
    }
    
    func fetchStudent() {
        if student == nil {
            guard let currentUsersUid = Auth.auth().currentUser?.uid else {return}
            let studentsCollectionReference = database.collection("students").document(currentUsersUid)
            studentsCollectionReference.getDocument { (document, error) in
                if let document = document {
                    if let dataDescription = document.data() as? [String : String] {
                        self.student = Student(dataDescription)
                        print(self.student?.firstName)
                    }
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func showSideMenu(_ sender: Any) {
        delegate?.menuButtonTapped()
        sideMenuIsShowing = sideMenuIsShowing ? false : true
    }
}
