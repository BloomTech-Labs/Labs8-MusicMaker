//
//  Teacher+Convenience.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 11/25/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation
import CoreData

extension Teacher {
    @discardableResult
    convenience init(firestoreID: String, fields: [String: Any]) {
        self.init(context: CoreDataStack.shared.mainContext)
        
        self.firestoreID = firestoreID
        update(with: fields)
    }
    
    func update(with fields: [String: Any]) {
        var prefix = ""
        var lastName = ""
        
        if let name = fields["name"] as? [String: Any] {
            prefix = name["prefix"] as? String ?? ""
            lastName = name["lastName"] as? String ?? ""
        }
        
        self.name = "\(prefix) \(lastName)"
    }
}
