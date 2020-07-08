//
//  ViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 6/24/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var donorLabel: UILabel!
    @IBOutlet weak var patientLabel: UILabel!
    @IBOutlet weak var donorPatientSwitch: UISwitch!
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signUpMode = false
    //var tapCheck = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func topTapped(_ sender: Any) {
        
        guard let email = loginTextField.text, let password = passwordTextField.text else { return }
        
        switch signUpMode {
        case true:
            // MARK: SING UP
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                    
                    if self.donorPatientSwitch.isOn {
                        // PATIENT
                        req?.displayName = "Patient"
                        req?.commitChanges(completion: nil)
                        self.performSegue(withIdentifier: "patientSegue", sender: nil)
                    } else {
                        //DONOR
                        req?.displayName = "Donor"
                        req?.commitChanges(completion: nil)
                        self.performSegue(withIdentifier: "donorSegue", sender: nil)

                    }
                    
                } else {
                    AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: self) }
            }
            
        case false:
            // MARK: LOG IN
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    switch user?.user.displayName {
                    case "Patient":
                        self.performSegue(withIdentifier: "patientSegue", sender: nil)
                    case "Donor":
                        self.performSegue(withIdentifier: "donorSegue", sender: nil)
                        print("petuh")
                    default:
                        break
                    }
                } else {
                    AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: self) }
            }
        }
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if signUpMode {
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            donorLabel.isHidden = true
            patientLabel.isHidden = true
            donorPatientSwitch.isHidden = true
            signUpMode = false
        } else {
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
            donorLabel.isHidden = false
            patientLabel.isHidden = false
            donorPatientSwitch.isHidden = false
            signUpMode = true
        }
    }
}

