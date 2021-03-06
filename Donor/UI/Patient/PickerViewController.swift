//
//  PickerViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/12/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

protocol PickerViewControllerDelegate {
    func sendData(_ data: Patient)
}

class PickerViewController: UIViewController {
    
    @IBOutlet weak var topView: TopView!
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobilePhoneTextField: UITextField!
    
    override var shouldAutorotate: Bool { return false }
    
    var pickerViewControllerDelegate: PickerViewControllerDelegate?
    var data = Patient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewSetup()
        topView.delegate = self
        
        self.nameTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text         = data.name
        mobilePhoneTextField.text  = data.phoneNumber
    }
    
    fileprivate func done() {
        if  nameTextField.text != "",
            mobilePhoneTextField.text != "" {
            
            data.name         = nameTextField.text!
            data.phoneNumber  = mobilePhoneTextField.text!
            writeToDefaults()
            pickerViewControllerDelegate?.sendData(data)
            print(data)
            dismiss(animated: true, completion: nil)
        }
        else {
            AlertManager.displayAlert(title: "error", message: "fill all forms")
        }
    }
    
    //MARK: Defaults
    func writeToDefaults() {
        Defaults["userName"]         = data.name
        Defaults["userPhoneNumber"]  = data.phoneNumber
        Defaults["userBloodType"]    = data.bloodType.rawValue
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Blood.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if let bloodType = Blood.elementByIndex(index: row)?.rawValue {
            return NSAttributedString(string: bloodType, attributes: [NSAttributedString.Key.foregroundColor: Colors.red])
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let bloodType = Blood.elementByIndex(index: row) {
            data.bloodType = bloodType
        }
    }
}

//MARK: - UITextFieldDelegate
extension PickerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

//MARK: - Top View Delegate & Setup
extension PickerViewController: TopViewDelegate {
    func rightAction() {
        done()
    }
    
    fileprivate func topViewSetup() {
        topView.mailLabelText          = "Profile"
        topView.secondLabelText        = "Fill the form"
        topView.rightButton.isHidden   = false
        topView.rightButton.tintColor  = .white
    }
}
