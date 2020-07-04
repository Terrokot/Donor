//
//  ViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 6/24/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var donorLabel: UILabel!
    @IBOutlet weak var patientLabel: UILabel!
    @IBOutlet weak var donorPatientSwitch: UISwitch!
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signUpMode = true
    //var tapCheck = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func topTapped(_ sender: Any) {
        
        guard let email = loginTextField.text, let password = passwordTextField.text else { return }
        
        switch signUpMode {
        case true:
            // MARK: SING UP
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "patientSegue", sender: nil)
                } else {
                    AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: self) }
            }
        case false:
            // MARK: LOG IN
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    print("Sign Up Success")
                    self.performSegue(withIdentifier: "patientSegue", sender: nil)
                } else {
                    AlertManager.displayAlert(title: "Error", message: error!.localizedDescription, vc: self)
                }
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

