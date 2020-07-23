//
//  PatientDataModel.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/10/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation

struct Patient {
    var name: String?
    var bloodType: Blood = .O_minus
    var phoneNumber: String = ""
}
