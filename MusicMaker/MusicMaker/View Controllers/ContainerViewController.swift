//
//  ContainerViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ContainerViewController: UIViewController {

    
    // MARK: - Properties
    var teachersViewController: TeachersViewController!
    var sideMenuViewController: SideMenuViewController!
    var student: Student?
    let database = Firestore.firestore()
    
    // MARK: - IBOutlets
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var teachersView: UIView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudent()
        self.sideMenu.transform = CGAffineTransform(translationX: -self.sideMenu.frame.width, y: 0)
        self.sideMenu.layer.shadowOpacity = 0.8
        sideMenuViewController = self.children[1] as? SideMenuViewController
        teachersViewController = self.children[0].children[0] as? TeachersViewController
        teachersViewController.delegate = self
        sideMenuViewController.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Private Methods
    private func hideSideMenu() {
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.sideMenu.transform = CGAffineTransform(translationX: -self.sideMenu.frame.width, y: 0)
            self.teachersView.transform = .identity
        })
    }
    
    private func showSideMenu() {
//        view.bringSubviewToFront(sideMenu)
        sideMenu.alpha = 1
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.sideMenu.transform = .identity
            self.teachersView.transform = CGAffineTransform(translationX: self.sideMenu.frame.width, y: 0)
        })
    }
    
    private func fetchStudent() {
        if student == nil {
            guard let currentUsersUid = Auth.auth().currentUser?.uid else {return}
            let studentsCollectionReference = database.collection("students").document(currentUsersUid)
            studentsCollectionReference.getDocument { (document, error) in
                if let document = document {
                    if let dataDescription = document.data() as? [String : String] {
                        self.student = Student(dataDescription)
                        self.teachersViewController.student = self.student
                        self.sideMenuViewController.student = self.student
                        
                    }
                }
            }
        }
    }
}

// MARK: - TeachersViewControllerDelegate
extension ContainerViewController: TeachersViewControllerDelegate {
    func menuButtonTapped() {
        teachersViewController.sideMenuIsShowing ? hideSideMenu() : showSideMenu()
    }
}

// MARK: - SideMenuDelegate
extension ContainerViewController: SideMenuDelegate {
    func userProfileClicked() {
        self.performSegue(withIdentifier: "ShowUserProfile", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserProfile" {
            let destinationVC = segue.destination.children[0] as? UserProfileViewController
            destinationVC?.student = student
        }
    }
    
}



