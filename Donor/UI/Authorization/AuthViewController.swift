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


        self.passwordTextField.delegate = self
        self.loginTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        
        //setup custom SegC
       donorPatientSegmentedController.items = ["Donor", "Patient"]
       donorPatientSegmentedController.font = UIFont(name: "Avenir-Black", size: 14)
       donorPatientSegmentedController.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
       donorPatientSegmentedController.unselectedLabelColor = UIColor.black
       donorPatientSegmentedController.thumbColor = .white
       donorPatientSegmentedController.backgroundColor = UIColor(red: 0.82, green: 0.85, blue: 0.88, alpha: 1.00)
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

