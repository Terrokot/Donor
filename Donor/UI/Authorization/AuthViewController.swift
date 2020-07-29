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
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: R.image.auth.name)!)
        
        let backgroundImage = UIImage.init(named: R.image.auth.name)
        let backgroundImageView = UIImageView.init(frame: self.view.frame)

        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 1

        self.view.insertSubview(backgroundImageView, at: 0)

        AuthService.autoLogIn(vc: self)


        self.passwordTextField.delegate = self
        self.loginTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.borderWidth = 2
        loginTextField.layer.borderColor = UIColor.white.cgColor
        loginTextField.layer.borderWidth = 2
        
        
        
        //setup custom SegC
       donorPatientSegmentedController.items = ["Donor", "Patient"]
       donorPatientSegmentedController.font = UIFont(name: "Avenir-Black", size: 20)
        donorPatientSegmentedController.borderColor = UIColor.white
       donorPatientSegmentedController.unselectedLabelColor = UIColor.black
       donorPatientSegmentedController.thumbColor = UIColor(red: 1.00, green: 0.42, blue: 0.51, alpha: 1.00)
        donorPatientSegmentedController.backgroundColor = UIColor.clear
       donorPatientSegmentedController.selectedIndex = 0
       donorPatientSegmentedController.padding = 5
        
        bottomButton.setTitleColor(UIColor(red: 0.18, green: 0.21, blue: 0.26, alpha: 1.00), for: .normal)
        
        
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

