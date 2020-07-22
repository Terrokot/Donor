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
}
