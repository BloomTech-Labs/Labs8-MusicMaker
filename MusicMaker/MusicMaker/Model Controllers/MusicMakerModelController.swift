//
//  MusicMakerModelController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/25/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation
import CoreData

class MusicMakerModelController {
    
    /*
    
     Things we want our model controller to do...
     - fetch all teachers
     - fetch all assignments for a teacher
     - submit video for an assignment
     - download pdf for an assignment
     
     eventually...
     - add sign up to the model controller
     - add log in to the model controller
     ... so that everything is MVC compliant
    
    */
    
    var teachers: [Teacher] {
        let fetchRequest: NSFetchRequest<Teacher> = Teacher.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching teachers: \(error)")
            return []
        }

    }
    
    // Use MusicMakerModelController.shared anywhere in the app, instead of passing in a reference every time
    static let shared = MusicMakerModelController()
    
    // Comment this out to generate a single teacher and assignment as dummy data that is saved to core data
//    init() {
//        let teacher = Teacher(context: CoreDataStack.shared.mainContext)
//        teacher.name = "Mr. Bach"
//
//        let assignment = Assignment(context: CoreDataStack.shared.mainContext)
//        assignment.title = "Dummy ASSN #1"
//        teacher.addToAssignments(assignment)
//
//        do {
//            try CoreDataStack.shared.save()
//        } catch {
//            NSLog("Error saving: \(error)")
//        }
//    }
    
    func fetchTeachers(completion: @escaping ([Teacher]?, Error?) -> Void) {
        // fetch all teachers from firebase
    }
    
    func fetchAssigments(for teacher: Teacher, completion: @escaping ([Assignment]?, Error?) -> Void) {
        // fetch all student's assignments for a given teacher from firebase, then fetch the teacher's assignments for each student's assignment
    }
    
    func submit(assignment: Assignment, completion: @escaping (Assignment?, Error?) -> Void) {
        // make sure a video has been recorded for a given assignment, and tell firebase to upload the file at the recordingURL, and update the assignment in firebase with that recordingURL
    }
    
    func downloadScoreDocument(for assignment: Assignment, completion: @escaping (Assignment?, Error?) -> Void) {
        // download the score pdf from firebase and add a reference to it to core data so that we can show thumbnails for it when we are not online
    }
}
