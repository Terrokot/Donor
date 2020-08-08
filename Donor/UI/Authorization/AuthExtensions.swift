//
//  AuthExtensions.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/30/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import UIKit

//MARK: UI Setup
extension AuthViewController {
    
    func setupUI() {
        segmentedControllerSetup()
        installConstraints()
    }
    
    private func  segmentedControllerSetup() {
        //setup custom SegC
        donorPatientSegmentedController.items = ["Donor", "Patient"]
        donorPatientSegmentedController.font = UIFont(name: "Avenir-Black", size: 20)
        donorPatientSegmentedController.selectedLabelColor = .white
        donorPatientSegmentedController.borderColor = UIColor(red: 0.45, green: 0.49, blue: 0.55, alpha: 1.00)
        donorPatientSegmentedController.unselectedLabelColor = .lightGray
        donorPatientSegmentedController.thumbColor = Colors.red
        donorPatientSegmentedController.backgroundColor = .white
        donorPatientSegmentedController.selectedIndex = 0
        donorPatientSegmentedController.padding = 0
    }
    
    private func installConstraints() {
        
        switch view.frame.height {
        case let x where x > 667:
            // lager than iphone 8+
            logoTopConstraint.constant         = view.frame.height / 11
            authStackTopConstraint.constant    = view.frame.height / 10.8
            AuthSwitchStack.spacing            = view.frame.height / 16.9
            AuthStack.spacing                  = view.frame.height / 17.1
            loginTopConstraint.constant        = view.frame.height / 17.1
            statusLabelTopConstraint.constant  = view.frame.height / 10.3
        case let x where x < 667:
            // smaller than iphone 8
            logoTopConstraint.constant         = view.frame.height / 14
            authStackTopConstraint.constant    = view.frame.height / 13
            AuthSwitchStack.spacing            = view.frame.height / 20
            AuthStack.spacing                  = view.frame.height / 22
            loginTopConstraint.constant        = view.frame.height / 22
            statusLabelTopConstraint.constant  = view.frame.height / 13
        default:
            break
        }
    }
}

//MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

