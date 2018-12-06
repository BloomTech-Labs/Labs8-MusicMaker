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
    
    deinit {
        teacherListener?.remove()
        for (_, listener) in assignmentListeners {
            listener.remove()
        }
    }
    
    private var teacherListener: ListenerRegistration?
    private var assignmentListeners: [String: ListenerRegistration] = [:]
    
    func fetchTeachers(completion: @escaping ([Teacher]?, Error?) -> Void) {
        guard let currentStudentUID = Auth.auth().currentUser?.uid else {
            completion(teachers, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Not authenticated"]))
            return
        }
        
        let database = Firestore.firestore()
        
        let teachersCollection = database.collection("students").document(currentStudentUID).collection("teachers")
        
        // load teachers manually, either when the app is launched, or when the user pulls to refresh
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
                    
                    // Automatically fetch assignments for the teacher that we just updated
                    self.fetchAssigments(for: teacher, completion: { _,_ in })
                } else {
                    // document does not exist anymore, so delete from core data
                    moc.delete(teacher)
                    self.assignmentListeners[firestoreID]?.remove()
                }
            }
            
            // create new core data entries with whatever was left over in firestore
            for (firestoreID, teacherDocument) in firestoreDocumentLookup {
                let teacher = Teacher(firestoreID: firestoreID, fields: teacherDocument.data())
                
                // Automatically fetch assignments for the teacher that we just created
                self.fetchAssigments(for: teacher, completion: { _,_ in })
            }
            
            do {
                try CoreDataStack.shared.save()
                
                completion(self.teachers, nil)
            } catch {
                NSLog("Error saving core data: \(error)")
                
                completion(self.teachers, error)
            }
        }
        
        // add a listener, only once, so that future updates can get merged with core data automatically
        if teacherListener == nil {
            teacherListener = teachersCollection.addSnapshotListener({ [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    NSLog("Error adding listener for teachers: \(error)")
                    return
                }
                
                // If firestore doesn't return any documents, bail early
                guard let teacherDocuments = querySnapshot?.documents else {
                    NSLog("Error adding listener for teachers: No teacher documents found")
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
                        
                        // No need to get the assignments since we already have done so for this teacher
                    } else {
                        // document does not exist anymore, so delete from core data
                        moc.delete(teacher)
                        self.assignmentListeners[firestoreID]?.remove()
                    }
                }
                
                // create new core data entries with whatever was left over in firestore
                for (firestoreID, teacherDocument) in firestoreDocumentLookup {
                    let teacher = Teacher(firestoreID: firestoreID, fields: teacherDocument.data())
                    
                    // Automatically fetch assignments for the teacher that we just created
                    self.fetchAssigments(for: teacher, completion: { _,_ in })
                }
                
                do {
                    try CoreDataStack.shared.save()
                } catch {
                    NSLog("Error saving core data: \(error)")
                }
            })
        }
    }
    
    func fetchAssigments(for teacher: Teacher, completion: @escaping ([Assignment]?, Error?) -> Void) {
        guard let currentStudentUID = Auth.auth().currentUser?.uid else {
            completion(teacher.sortedAssignments, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Not authenticated"]))
            return
        }
        
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
        
        if assignmentListeners[teacherFirestoreID] == nil {
            assignmentListeners[teacherFirestoreID] = assignmentsCollection.addSnapshotListener({ (snapshot, error) in
                
                // If firestore returned an error, bail early
                if let error = error {
                    NSLog("Error adding listener for assignments for teacher [\(teacherFirestoreID)]: \(error)")
                    return
                }
                
                // If firestore doesn't return any documents, bail early
                guard let assignmentDocuments = snapshot?.documents else {
                    NSLog("No assignment documents found for teacher [\(teacherFirestoreID)]")
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
                } catch {
                    NSLog("Error saving core data: \(error)")
                }
            })
        }
    }
    
    func submit(assignment: Assignment, completion: @escaping (Assignment?, Error?) -> Void) {
        guard let currentStudentUID = Auth.auth().currentUser?.uid else {
            completion(assignment, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Not authenticated"]))
            return
        }
        
        guard let localRecordingURL = assignment.localRecordingURL else {
            completion(assignment, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "No local recording URL found."]))
            return
        }
        
        guard let teacherFirestoreID = assignment.teacher?.firestoreID else {
            completion(assignment, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid Assignment Teacher"]))
            return
        }
        
        guard let assignmentFirestoreID = assignment.firestoreID else {
            completion(assignment, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid Assignment"]))
            return
        }
        
        let serverFileName = UUID().uuidString + ".mov"
        
        let reference = Storage.storage().reference(withPath: "video").child(serverFileName)
        
        reference.putFile(from: localRecordingURL, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(assignment, error)
                return
            }
            
            reference.downloadURL(completion: { (url, error) in
                guard let downloadURL = url else {
                    completion(assignment, error)
                    return
                }
                
                let database = Firestore.firestore()
                
                let assignmentDocument = database.collection("students").document(currentStudentUID).collection("teachers").document(teacherFirestoreID).collection("assignments").document(assignmentFirestoreID)
                
                assignmentDocument.setData(["video": downloadURL.absoluteString], merge: true, completion: { (error) in
                    completion(assignment, error)
                })
            })
        }
    }
    
    func downloadScoreDocument(for assignment: Assignment, completion: @escaping (Assignment?, Error?) -> Void) {
        guard let scoreDocumentURL = assignment.scoreDocumentURL else {
            completion(nil, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "No score document found."]))
            return
        }
        let reference = Storage.storage().reference(forURL: scoreDocumentURL.absoluteString)
        
        guard let localScoreDocumentURL = assignment.createLocalScoreDocumentURL() else {
            completion(nil, NSError(domain: MusicMakerModelController.ErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not create local URL for score document."]))
            return
        }
        
        reference.write(toFile: localScoreDocumentURL) { (localURL, error) in
            completion(assignment, error)
        }
    }
}
