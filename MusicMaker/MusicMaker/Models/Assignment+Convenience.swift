//
//  Assignment+Convenience.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/25/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation
import CoreData
import Firebase

extension Assignment {
    
    @discardableResult
    convenience init(teacher: Teacher, firestoreID: String, fields: [String: Any]) {
        self.init(context: CoreDataStack.shared.mainContext)
        
        teacher.addToAssignments(self)
        self.firestoreID = firestoreID
        update(with: fields)
    }
    
    func update(with fields: [String: Any]) {
        self.dueDate = (fields["dueDate"] as? Timestamp)?.dateValue()
        self.feedback = fields["feedback"] as? String
        self.grade = fields["grade"] as? String
        self.instructions = fields["instructions"] as? String
        self.instrument = fields["instrument"] as? String
        self.level = fields["level"] as? String
        self.piece = fields["piece"] as? String
        
        let oldScoreDocumentURL = self.scoreDocumentURL
        
        if let scoreDocumentURLString = fields["sheetMusic"] as? String {
            self.scoreDocumentURL = URL(string: scoreDocumentURLString)
        } else {
            self.scoreDocumentURL = nil
        }
        
        // Remove the old score document, since it seems it has changed
        if oldScoreDocumentURL != self.scoreDocumentURL {
            removeLocalScoreDocument()
        }
        
        if let recordingURLString = fields["video"] as? String {
            self.recordingURL = URL(string: recordingURLString)
        } else {
            self.recordingURL = nil
        }
        
        self.status = fields["status"] as? String
        self.title = fields["assignmentName"] as? String
    }
    
    private var localRecordingFolderURL: URL {
        // create a folder in core data's folder for recordings
        return NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("Recordings", isDirectory: true)
    }
    
    private var localScoreDocumentFolderURL: URL {
        // create a folder in core data's folder for score documents
        return NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("Scores", isDirectory: true)
    }
    
    func localRecordingURL(for uuid: UUID) -> URL {
        return localRecordingFolderURL.appendingPathComponent("\(uuid.uuidString).mov", isDirectory: false)
    }
    
    func localScoreDocumentURL(for uuid: UUID) -> URL {
        return localScoreDocumentFolderURL.appendingPathComponent("\(uuid.uuidString).pdf", isDirectory: false)
    }
    
    var localRecordingURL: URL? {
        guard let localRecordingUUID = localRecordingUUID else { return nil }
        
        return localRecordingURL(for: localRecordingUUID)
    }
    
    var localScoreDocumentURL: URL? {
        guard let localScoreDocumentUUID = localScoreDocumentUUID else { return nil }
        
        return localScoreDocumentURL(for: localScoreDocumentUUID)
    }
    
    func createLocalRecordingURL() -> URL? {
        let fileManager = FileManager.default
        
        do {
            // create folder if there isn't already one
            try fileManager.createDirectory(at: localRecordingFolderURL, withIntermediateDirectories: true, attributes: nil)
            
            let newLocalRecordingUUID = UUID()
            
            removeLocalRecording()
            
            localRecordingUUID = newLocalRecordingUUID
            
            try CoreDataStack.shared.save()
            
            return localRecordingURL(for: newLocalRecordingUUID)
        } catch {
            NSLog("Error creating local recording url: \(error)")
        }
        
        return nil
    }
    
    func createLocalScoreDocumentURL() -> URL? {
        let fileManager = FileManager.default
        
        do {
            // create folder if there isn't already one
            try fileManager.createDirectory(at: localScoreDocumentFolderURL, withIntermediateDirectories: true, attributes: nil)
            
            let newLocalScoreDocumentUUID = UUID()
            
            removeLocalScoreDocument()
            
            localScoreDocumentUUID = newLocalScoreDocumentUUID
            
            try CoreDataStack.shared.save()
            
            return localScoreDocumentURL(for: newLocalScoreDocumentUUID)
        } catch {
            NSLog("Error creating local score document url: \(error)")
        }
        
        return nil
    }
    
    func removeLocalRecording() {
        guard let oldLocalRecordingUUID = localRecordingUUID else { return }
        
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(at: localRecordingURL(for: oldLocalRecordingUUID))
            localRecordingUUID = nil
        } catch {
            NSLog("Error removing old recording: \(error)")
        }
    }
    
    func removeLocalScoreDocument() {
        guard let oldLocalScoreDocumentUUID = localScoreDocumentUUID else { return }
        
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(at: localScoreDocumentURL(for: oldLocalScoreDocumentUUID))
            localScoreDocumentUUID = nil
        } catch {
            NSLog("Error removing old score document: \(error)")
        }
    }
    
    // when core data is about to delete the assignment, we get a chance to clean up any extra files remaining (recording, pdf, etc.)
    override public func prepareForDeletion() {
        removeLocalRecording()
        removeLocalScoreDocument()
        
        super.prepareForDeletion()
    }
}
