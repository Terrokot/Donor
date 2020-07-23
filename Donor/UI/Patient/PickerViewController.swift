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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if  nameTextField.text != "",
            mobilePhoneTextField.text != "" {
            data.name = nameTextField.text!
            data.phoneNumber = mobilePhoneTextField.text!
            pickerViewControllerDelegate?.sendData(data)
            print(data)
            dismiss(animated: true, completion: nil)
        }
        else {
            AlertManager.displayAlert(title: "error", message: "fill all forms", vc: self)
        }
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
