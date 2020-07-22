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
                                        
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(true, forKey: "signInStatus")
                    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: EmailAuthProvider.credential(withEmail: email, password: password))
                    userDefaults.set(encodedData, forKey: "token")
                    userDefaults.synchronize()
                    
                    if vc.donorPatientSwitch.isOn {
                        // PATIENT
                        req?.displayName = "Patient"
                        req?.commitChanges(completion: nil)
                        //vc.performSegue(withIdentifier: "patientSegue", sender: nil)
                        vc.present(R.storyboard.patient.navigationController()!, animated: true, completion: nil)
                    } else {
                        // DONOR
                        req?.displayName = "Donor"
                        req?.commitChanges(completion: nil)
                        // vc.performSegue(withIdentifier: "donorSegue", sender: nil)
                        vc.present(R.storyboard.donor.navigationController()!, animated: true, completion: nil)
                    }
                } else {
                    AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: vc)
                }
            }
            
        } else {
            // MARK: LOG IN
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(true, forKey: "signInStatus")
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: EmailAuthProvider.credential(withEmail: email, password: password))
                userDefaults.set(encodedData, forKey: "token")
                userDefaults.synchronize()
                
                switch user?.user.displayName {
                case "Patient":
                    //vc.performSegue(withIdentifier: "patientSegue", sender: nil)
                    vc.present(R.storyboard.patient.navigationController()!, animated: true, completion: nil)
                case "Donor":
                    //vc.performSegue(withIdentifier: "donorSegue", sender: nil)
                    vc.present(R.storyboard.donor.navigationController()!, animated: true, completion: nil)
                default: //ERRORS
                    AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: vc)
                }
            }
        }
    }
    //MARK: Auto Log In
    static func autoLogIn(vc: UIViewController) {
        let userDefaults = UserDefaults.standard
        
        guard let decoded  = userDefaults.data(forKey: "token") else {
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
                vc.present(R.storyboard.patient.navigationController()!, animated: true, completion: nil)
            case "Donor":
                //vc.performSegue(withIdentifier: "donorSegue", sender: nil)
                vc.present(R.storyboard.donor.navigationController()!, animated: true, completion: nil)
            default: //ERRORS
                AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: vc)
            }
        }
    }
}




