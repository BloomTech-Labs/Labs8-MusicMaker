//
//  MusicMakerModelController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/25/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation
import Firebase
import CoreData

class MusicMakerModelController {
    
    static let ErrorDomain = "MusicMakerModelControllerErrorDomain"
    
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
        guard var currentStudentUID = Auth.auth().currentUser?.uid else {
            completion(teachers, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Not authenticated"]))
            return
        }
        
        currentStudentUID = "NKMNNypkVXUj4BSSyTPb" // Temporarily set it to the user with actual assignments
        
        let database = Firestore.firestore()
        
        let teachersCollection = database.collection("students").document(currentStudentUID).collection("teachers")
        
        teachersCollection.getDocuments { (snapshot, error) in
            // Seems like this is being called on the main queue, so no need for DispatchQueue.main.async { ... }
            
            // If firestore returned an error, bail early
            if let error = error {
                completion(self.teachers, error)
                return
            }
            
            // If firestore doesn't return any documents, bail early
            guard let teacherDocuments = snapshot?.documents else {
                completion(self.teachers, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "No teacher documents found"]))
                return
            }
            
            var firestoreDocumentLookup: [String: QueryDocumentSnapshot] = [:]
            
            for teacherDocument in teacherDocuments {
                firestoreDocumentLookup[teacherDocument.documentID] = teacherDocument
            }
            
            let moc = CoreDataStack.shared.mainContext
            
            for teacher in self.teachers {
                // remove any core data entries without a firestoreID
                guard let firestoreID = teacher.firestoreID else {
                    moc.delete(teacher)
                    continue
                }
                
                if let teacherDocument = firestoreDocumentLookup[firestoreID] {
                    // document exists, so we should update the teacher in core data
                    teacher.update(with: teacherDocument.data())
                    
                    // remove the entry from the firestore lookup, so we don't end up creating new core data entries with it
                    firestoreDocumentLookup[firestoreID] = nil
                } else {
                    // document does not exist anymore, so delete from core data
                    moc.delete(teacher)
                }
            }
            
            // create new core data entries with whatever was left over in firestore
            for (firestoreID, teacherDocument) in firestoreDocumentLookup {
                Teacher(firestoreID: firestoreID, fields: teacherDocument.data())
            }
            
            do {
                try CoreDataStack.shared.save()
                
                completion(self.teachers, nil)
            } catch {
                NSLog("Error saving core data: \(error)")
                
                completion(self.teachers, error)
            }
        }
    }
    
    func fetchAssigments(for teacher: Teacher, completion: @escaping ([Assignment]?, Error?) -> Void) {
        guard var currentStudentUID = Auth.auth().currentUser?.uid else {
            completion(teacher.sortedAssignments, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Not authenticated"]))
            return
        }
        
        currentStudentUID = "NKMNNypkVXUj4BSSyTPb" // Temporarily set it to the user with actual assignments
        
        guard let teacherFirestoreID = teacher.firestoreID else {
            completion(teacher.sortedAssignments, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid Teacher"]))
            return
        }
        
        let database = Firestore.firestore()
        
        let assignmentsCollection = database.collection("students").document(currentStudentUID).collection("teachers").document(teacherFirestoreID).collection("assignments")
        
        assignmentsCollection.getDocuments { (snapshot, error) in
            // Seems like this is being called on the main queue, so no need for DispatchQueue.main.async { ... }
            
            // If firestore returned an error, bail early
            if let error = error {
                completion(teacher.sortedAssignments, error)
                return
            }
            
            // If firestore doesn't return any documents, bail early
            guard let assignmentDocuments = snapshot?.documents else {
                completion(teacher.sortedAssignments, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "No assignment documents found"]))
                return
            }
            
            var firestoreDocumentLookup: [String: QueryDocumentSnapshot] = [:]
            
            for assignmentDocument in assignmentDocuments {
                firestoreDocumentLookup[assignmentDocument.documentID] = assignmentDocument
            }
            
            let moc = CoreDataStack.shared.mainContext

            for assignment in teacher.sortedAssignments {
                // remove any core data entries without a firestoreID
                guard let firestoreID = assignment.firestoreID else {
                    moc.delete(assignment)
                    continue
                }

                if let assignmentDocument = firestoreDocumentLookup[firestoreID] {
                    // document exists, so we should update the assignment in core data
                    assignment.update(with: assignmentDocument.data())

                    // remove the entry from the firestore lookup, so we don't end up creating new core data entries with it
                    firestoreDocumentLookup[firestoreID] = nil
                } else {
                    // document does not exist anymore, so delete from core data
                    moc.delete(assignment)
                }
            }

            // create new core data entries with whatever was left over in firestore
            for (firestoreID, assignmentDocument) in firestoreDocumentLookup {
                Assignment(teacher: teacher, firestoreID: firestoreID, fields: assignmentDocument.data())
            }

            do {
                try CoreDataStack.shared.save()

                completion(teacher.sortedAssignments, nil)
            } catch {
                NSLog("Error saving core data: \(error)")

                completion(teacher.sortedAssignments, error)
            }
        }
    }
    
    func submit(assignment: Assignment, completion: @escaping (Assignment?, Error?) -> Void) {
        // make sure a video has been recorded for a given assignment, and tell firebase to upload the file at the recordingURL, and update the assignment in firebase with that recordingURL
    }
    
    func downloadScoreDocument(for assignment: Assignment, completion: @escaping (Assignment?, Error?) -> Void) {
        // download the score pdf from firebase and add a reference to it to core data so that we can show thumbnails for it when we are not online
    }
}
