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
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobilePhoneTextField: UITextField!
    
    var pickerViewControllerDelegate: PickerViewControllerDelegate?
    var data = Patient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = data.name
        mobilePhoneTextField.text = data.phoneNumber
    }

    @IBAction func doneButton(_ sender: Any) {
        if  nameTextField.text != "",
            mobilePhoneTextField.text != "" {
            data.name = nameTextField.text!
            data.phoneNumber = mobilePhoneTextField.text!
            writeToDefaults()
            pickerViewControllerDelegate?.sendData(data)
            print(data)
            dismiss(animated: true, completion: nil)
        }
        else {
            AlertManager.displayAlert(title: "error", message: "fill all forms")
        }
    }
    
    func writeToDefaults() {
        Defaults["userName"] = data.name
        Defaults["userPhoneNumber"] = data.phoneNumber
        Defaults["userBloodType"] = data.bloodType.rawValue
    }
    
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Blood.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let bloodType = Blood.elementByIndex(index: row)?.rawValue {
            return bloodType
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let bloodType = Blood.elementByIndex(index: row) {
            data.bloodType = bloodType
        }
    }
}
