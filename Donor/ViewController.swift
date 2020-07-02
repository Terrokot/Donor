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
        if loginTextField.text == "" || passwordTextField.text == "" {
            displayAlert(title: "Missing Information", message: "You must provide both a email and password")
        } else {
            if let email = loginTextField.text, let password = passwordTextField.text {
                if signUpMode {
                    // SING UP
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if error != nil {
                            self.displayAlert(title: "Error", message: error!.localizedDescription)
                        } else {
                            print("Sign Up Success")
                            print(user?.additionalUserInfo as Any)
                            self.performSegue(withIdentifier: "patientSegue", sender: nil)

                        }
                    }
                } else {
                    // LOG IN
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if error != nil {
                            self.displayAlert(title: "Error", message: error!.localizedDescription)
                        } else {
                            print("Log In Success")
                            print(user?.additionalUserInfo as Any)
                            self.performSegue(withIdentifier: "patientSegue", sender: nil)
                        }
                    }
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
    
    func displayAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}

