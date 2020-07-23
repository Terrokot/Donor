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
        let compatibilityTable: [[Bool]] = [
        [true, false, false, false, false, false, false, false],        // 1 -
        [true, true,  false, false, false, false, false, false],        // 1 +
        [true, false, true,  false, false, false, false, false],        // 2 -
        [true, true,  true,  true,  false, false, false, false],        // 2 +
        [true, false, false, false, true,  false, false, false],        // 3 -
        [true, true,  false, false, true,  true,  false, false],        // 3 +
        [true, false, true,  false, true,  false, true,  false],        // 4 -
        [true, true,  true,  true,  true,  true,  true,  true ]         // 4 +
        ]
        
        return compatibilityTable[patientType.getIndex()][donorType.getIndex()]
    }
}
                 
