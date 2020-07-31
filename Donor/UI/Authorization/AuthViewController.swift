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
//MARK: UI Setup
extension AuthViewController {
    
    private func setupUI() {
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
        donorPatientSegmentedController.thumbColor = AuthColors.red
        donorPatientSegmentedController.backgroundColor = .white
        donorPatientSegmentedController.selectedIndex = 0
        donorPatientSegmentedController.padding = 0
    }
    
    private func installConstraints() {
        /*
         switch view.frame.height {
         case 736:
         logoTopConstraint.constant         = 57
         authStackTopConstraint.constant    = 60
         AuthSwitchStack.spacing            = 45
         AuthStack.spacing                  = 40
         statusLabelTopConstraint.constant  = 75
         print("iphone 8+")
         case 812:
         logoTopConstraint.constant         = 63
         authStackTopConstraint.constant    = 73
         AuthSwitchStack.spacing            = 47
         AuthStack.spacing                  = 46
         statusLabelTopConstraint.constant  = 83
         print("iphone X/Pro")
         case 896:
         logoTopConstraint.constant         = 98
         authStackTopConstraint.constant    = 86
         AuthSwitchStack.spacing            = 54
         AuthStack.spacing                  = 54
         statusLabelTopConstraint.constant  = 83
         print("iphone Xr/11/Max")
         
         default:
         print("another iphone")
         break
         }
         */
        switch view.frame.height {
        case let x where x > 667:
            logoTopConstraint.constant         = view.frame.height / 11
            authStackTopConstraint.constant    = view.frame.height / 10.8
            AuthSwitchStack.spacing            = view.frame.height / 16.9
            AuthStack.spacing                  = view.frame.height / 17.1
            loginTopConstraint.constant        = view.frame.height / 17.1
            statusLabelTopConstraint.constant  = view.frame.height / 10.3
        case let x where x < 667:
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

//MARK: UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

