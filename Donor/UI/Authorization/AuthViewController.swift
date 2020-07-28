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
    
    @IBOutlet weak var donorPatientSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signUpMode = false
    //var tapCheck = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func topTapped(_ sender: Any) {
        guard let email = loginTextField.text, let password = passwordTextField.text else { return }
        AuthService.signUpAndLogIn(email: email, password: password, vc: self, signUpMode: signUpMode)
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if signUpMode {
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            donorPatientSegmentedController.isHidden = true
            signUpMode = false
        } else {
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
            donorPatientSegmentedController.isHidden = false
            signUpMode = true
        }
    }
        
    @IBAction func autoAuthTapped(_ sender: Any) {
        AuthService.autoLogIn(vc: self)
    }
}

