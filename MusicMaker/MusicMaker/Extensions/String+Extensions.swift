//
//  String+Extensions.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/26/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation

extension String {
    
    //Gets the initials for a given first and last name
    var initials: String {
        var initials = String()
        let firstAndLastName = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstInitial = firstAndLastName.first?.first {
            initials.append(firstInitial)
        }
        
        if let lastInitial = firstAndLastName.last?.first {
            initials.append(lastInitial)
        }
        
        return initials
    }
    
}
