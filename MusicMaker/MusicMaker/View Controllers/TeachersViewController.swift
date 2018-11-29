//
//  TeachersViewController.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/14/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit



class TeachersViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenuFromUserTap))
        self.view.addGestureRecognizer(touchGesture)
        MusicMakerModelController.shared.fetchTeachers { (teachers, error) in
            guard error == nil else {return}
            if let teachers = teachers {
                self.teachers = teachers
                self.tableView.reloadData()
            }
        }
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
    

    // MARK: - IBActions
    @IBAction func showSideMenu(_ sender: Any) {
        delegate?.menuButtonTapped()
        sideMenuIsShowing = sideMenuIsShowing ? false : true
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
        cell.imageView?.createInitialsImage(for: teacher.name, backgroundColor: .lightGray)
        return cell
    }
    
    
}
