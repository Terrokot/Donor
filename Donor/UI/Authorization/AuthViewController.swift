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
    
    
    @IBOutlet weak var bottomStack: NSLayoutConstraint!
    
    
    var signUpMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthService.autoLogIn(vc: self)
        
        self.passwordTextField.delegate = self
        self.loginTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        
         segmentedControllerSetup()
        
        
    }
    
    @IBAction func topTapped(_ sender: Any) {
        guard let email = loginTextField.text, let password = passwordTextField.text else { return }
        AuthService.signUpAndLogIn(email: email, password: password, vc: self, signUpMode: signUpMode)
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if signUpMode {
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Sign Up", for: .normal)
            logInStatusLabel.text = "First time there?"
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
//MARK: UI Setup
extension AuthViewController {
    
    private func  segmentedControllerSetup() {
        //setup custom SegC
        donorPatientSegmentedController.items = ["Donor", "Patient"]
        donorPatientSegmentedController.font = UIFont(name: "Avenir-Black", size: 20)
        donorPatientSegmentedController.selectedLabelColor = .white
        donorPatientSegmentedController.borderColor = UIColor(red: 0.45, green: 0.49, blue: 0.55, alpha: 1.00)
        donorPatientSegmentedController.unselectedLabelColor = .lightGray
        donorPatientSegmentedController.thumbColor = AuthColors.red
        donorPatientSegmentedController.backgroundColor = .white
        donorPatientSegmentedController.selectedIndex = 0
        donorPatientSegmentedController.padding = 0
    }
    
    
    
}


//MARK: UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

