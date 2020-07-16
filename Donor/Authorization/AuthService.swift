//
//  AuthService.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/16/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    private init() {}
    
    static func signUpAndLogIn(email: String, password: String, vc: AuthViewController, signUpMode: Bool ) {
        
        if signUpMode {
            // MARK: SING UP
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                    
                    if vc.donorPatientSwitch.isOn {
                        // PATIENT
                        req?.displayName = "Patient"
                        req?.commitChanges(completion: nil)
                        vc.performSegue(withIdentifier: "patientSegue", sender: nil)
                    } else {
                        // DONOR
                        req?.displayName = "Donor"
                        req?.commitChanges(completion: nil)
                        vc.performSegue(withIdentifier: "donorSegue", sender: nil)
                    }
                } else {
                    AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: vc)
                }
            }
            
        } else {
            // MARK: LOG IN
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                switch user?.user.displayName {
                case "Patient":
                    vc.performSegue(withIdentifier: "patientSegue", sender: nil)
                case "Donor":
                    vc.performSegue(withIdentifier: "donorSegue", sender: nil)
                default: //ERRORS
                    AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: vc)
                }
            }
        }
    }
}




