//
//  File.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/27/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

struct Student {
    
    let firstName: String
    let lastName: String
    let email: String
    let level: String
    let instrument: String
    
    
    init?(_ dictionary: [String: String]) {
        guard let firstName = dictionary["firstName"],
            let lastName = dictionary["lastName"],
            let email = dictionary["email"],
            let level = dictionary["level"],
        let instrument = dictionary["instrument"] else {return nil}
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.level = level
        self.instrument = instrument
        
    }
    
    
}
