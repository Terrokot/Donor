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
    
    @IBOutlet weak var donorPatientSegmentedController: AuthSegmentedController!
    
    @IBOutlet weak var logInStatusLabel: UILabel!
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    //Logo costraints
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var authStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabelTopConstraint: NSLayoutConstraint!
    // Stack Views
    @IBOutlet weak var AuthSwitchStack: UIStackView!
    @IBOutlet weak var AuthStack: UIStackView!

    
    override var shouldAutorotate: Bool { return false }
    
    var signUpMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        AuthService.autoLogIn(vc: self)
        
        self.passwordTextField.delegate = self
        self.loginTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func topTapped(_ sender: Any) {
        guard let email = loginTextField.text, let password = passwordTextField.text else { return }
        AuthService.signUpAndLogIn(email: email, password: password, vc: self, signUpMode: signUpMode)
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if signUpMode {
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Sign Up", for: .normal)
            logInStatusLabel.text = "Don't have an account?"
            donorPatientSegmentedController.isHidden = true
            signUpMode = false
        } else {
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Log In", for: .normal)
            logInStatusLabel.text = "Already have an account?"
            donorPatientSegmentedController.isHidden = false
            signUpMode = true
        }
    }
}
