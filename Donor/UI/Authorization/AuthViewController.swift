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
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signUpMode = false
    //var tapCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthService.autoLogIn(vc: self)

        
        bottomButton.setTitleColor(UIColor(red: 0.18, green: 0.21, blue: 0.26, alpha: 1.00), for: .normal)
        bottomButton.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)

        self.passwordTextField.delegate = self
        self.loginTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        
        //setup custom SegC
       donorPatientSegmentedController.items = ["Donor", "Patient"]
       donorPatientSegmentedController.font = UIFont(name: "Avenir-Black", size: 20)
        donorPatientSegmentedController.borderColor = UIColor(red: 0.45, green: 0.49, blue: 0.55, alpha: 1.00)
       donorPatientSegmentedController.unselectedLabelColor = UIColor.black
       donorPatientSegmentedController.thumbColor = UIColor(red: 1.00, green: 0.50, blue: 0.31, alpha: 1.00)
        donorPatientSegmentedController.backgroundColor = AuthColors.backgroundTextField
       donorPatientSegmentedController.selectedIndex = 0
       donorPatientSegmentedController.padding = 5
        
        
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
        
}
//MARK: UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

