//
//  Blood.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/23/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation

enum Blood: String {
    case O_minus  = "O-",
         O_plus   = "O+",
         A_minus  = "A-",
         A_plus   = "A+",
         B_minus  = "B-",
         B_plus   = "B+",
         AB_minus = "AB-",
         AB_plus  = "AB+"
    
    func getIndex() -> (Int) {
        switch self {
        case .O_minus:
            return 0
        case .O_plus:
            return 1
        case .A_minus:
            return 2
        case .A_plus:
            return 3
        case .B_minus:
            return 4
        case .B_plus:
            return 5
        case .AB_minus:
            return 6
        case .AB_plus:
            return 7
        }
    }
}
