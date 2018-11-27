//
//  Assignment+Convenience.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/25/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation
import CoreData

extension Assignment {
    
    private var localRecordingFolderURL: URL {
        // create a folder in core data's folder for recordings
        return NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("Recordings", isDirectory: true)
    }
    
    func localRecordingURL(for uuid: UUID) -> URL {
        return localRecordingFolderURL.appendingPathComponent("\(uuid.uuidString).mov", isDirectory: false)
    }
    
    var localRecordingURL: URL? {
        guard let localRecordingUUID = localRecordingUUID else { return nil }
        
        return localRecordingURL(for: localRecordingUUID)
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
    
    // when core data is about to delete the assignment, we get a chance to clean up any extra files remaining (recording, pdf, etc.)
    override public func prepareForDeletion() {
        removeLocalRecording()
        
        super.prepareForDeletion()
    }
}
