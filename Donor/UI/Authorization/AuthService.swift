//
//  AuthService.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/16/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit
import AVFoundation

class AuthService {
    
    private init() {}
    
    static func signUpAndLogIn(email: String, password: String, vc: AuthViewController, signUpMode: Bool ) {
        
        let userDefaults = UserDefaults.standard
        let _ = userDefaults.bool(forKey: "signInStatus")
        let _ = userDefaults.object(forKey: "token")
        
        if signUpMode {
            // MARK: SING UP
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                                        
                    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: EmailAuthProvider.credential(withEmail: email, password: password))
                    Defaults["token"] = encodedData
                    Defaults["signInStatus"] = true
                    _Defaults.synchronize()
                    
                    if vc.donorPatientSegmentedController.selectedIndex == 1 {
                        // PATIENT
                        req?.displayName = "Patient"
                        req?.commitChanges(completion: nil)
                        //vc.performSegue(withIdentifier: "patientSegue", sender: nil)
                        vc.present(R.storyboard.patient.patientViewController()!, animated: true, completion: nil)
                    } else {
                        // DONOR
                        req?.displayName = "Donor"
                        req?.commitChanges(completion: nil)
                        // vc.performSegue(withIdentifier: "donorSegue", sender: nil)
                        vc.present(R.storyboard.donor.donorViewController()!, animated: true, completion: nil)
                    }
                } else {
                    AlertManager.displayAlert(title: "Error", message: error?.localizedDescription ?? "Sing up error")
                }
            }
            
        } else {
            // MARK: LOG IN
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: EmailAuthProvider.credential(withEmail: email, password: password))
                Defaults["token"] = encodedData
                Defaults["signInStatus"] = true
                _Defaults.synchronize()
                
                switch user?.user.displayName {
                case "Patient":
                    //vc.performSegue(withIdentifier: "patientSegue", sender: nil)
                    vc.present(R.storyboard.patient.patientViewController()!, animated: true, completion: nil)
                case "Donor":
                    //vc.performSegue(withIdentifier: "donorSegue", sender: nil)
                    vc.present(R.storyboard.donor.donorViewController()!, animated: true, completion: nil)
                default: //ERRORS
                    AlertManager.displayAlert(title: "Error", message: error?.localizedDescription ?? "Sing in error")
                }
            }
        }
    }
    //MARK: Auto Log In
    static func autoLogIn(vc: UIViewController) {
        
        guard let decoded: Data  = Defaults["token"] else {
            print("no data")
            return
        }
        guard let decodedToken = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? AuthCredential else {
            print("decode error")
            return
        }

        Auth.auth().signIn(with: decodedToken) { (user, error) in
            switch user?.user.displayName {
            case "Patient":
                //vc.performSegue(withIdentifier: "patientSegue", sender: nil)
                vc.present(R.storyboard.patient.patientViewController()!, animated: true, completion: nil)
            case "Donor":
                //vc.performSegue(withIdentifier: "donorSegue", sender: nil)
                vc.present(R.storyboard.donor.donorViewController()!, animated: true, completion: nil)
            default: //ERRORS
                AlertManager.displayAlert(title: "Error", message: error?.localizedDescription ?? "Sing in error")
            }
        }
    }
}




