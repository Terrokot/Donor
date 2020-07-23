//
//  TableFilter.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/22/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import FirebaseDatabase

class TableFilter {
    
    private init() {}
    
    static func sortByBloodType(donorType: Blood, patientType: Blood) -> Bool {
        let 💖 = true
        let 🖤 = false
        
        let compatibilityTable: [[Bool]] = [
            [💖, 🖤, 🖤, 🖤, 🖤, 🖤, 🖤, 🖤],        // 1 -
            [💖, 💖, 🖤, 🖤, 🖤, 🖤, 🖤, 🖤],        // 1 +
            [💖, 🖤, 💖, 🖤, 🖤, 🖤, 🖤, 🖤],        // 2 -
            [💖, 💖, 💖, 💖, 🖤, 🖤, 🖤, 🖤],        // 2 +
            [💖, 🖤, 🖤, 🖤, 💖, 🖤, 🖤, 🖤],        // 3 -
            [💖, 💖, 🖤, 🖤, 💖, 💖, 🖤, 🖤],        // 3 +
            [💖, 🖤, 💖, 🖤, 💖, 🖤, 💖, 🖤],        // 4 -
            [💖, 💖, 💖, 💖, 💖, 💖, 💖, 💖]         // 4 +
        ]
        
        return compatibilityTable[patientType.getIndex()][donorType.getIndex()]
    }
}

