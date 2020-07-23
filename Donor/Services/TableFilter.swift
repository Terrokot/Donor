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

    static func sortByBloodType(donorType: String, patientType: String) -> Bool {
        
        switch donorType {
        case "O-":
            return true
        case "O+":
            switch patientType {
            case "O-":
                return false
            case "A-":
                return false
            case "B-":
                return false
            case "AB-":
                return false
            default:
                return true
            }
        case "A-":
            switch patientType {
            case "O-":
                return false
            case "O+":
                return false
            case "B-":
                return false
            case "B+":
                return false
            default:
                return true
            }
        case "A+":
            if patientType == "A+" || patientType == "AB+" {
                return true
            } else { return false }
        case "B-":
            switch patientType {
            case "B-":
                return  true
            case "B+":
                return true
            case "AB-":
                return  true
            case "AB+":
                return true
            default:
                return false
            }
        case "B+":
            if patientType == "B+" || patientType == "AB+" {
                return true
            } else { return false }
        case "AB-":
            if patientType == "AB-" || patientType == "AB+" {
                return true
            } else { return false }
        case "AB+":
            if patientType == "AB+" {
                return true
            } else { return false }
        default:
            return true
        }
    }

   
    
    func sortByBloodType2(donorType: Blood, patientType: Blood) -> Bool {
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
