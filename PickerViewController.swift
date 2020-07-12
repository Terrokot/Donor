//
//  PickerViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/12/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

protocol PickerViewControllerDelegate {
    func sendData(_ data: PatientDataModel)
}

class PickerViewController: UIViewController {

    @IBOutlet var pickerView: UIPickerView!
    
    
    var pickerViewControllerDelegate: PickerViewControllerDelegate?
    var data = PatientDataModel()
    let bloodTypes: [String]  = ["O-", "O+", "B-", "B+", "A-", "A+", "AB-", "AB+"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func doneButton(_ sender: Any) {
        pickerViewControllerDelegate?.sendData(data)
        print(data)
        dismiss(animated: true, completion: nil)
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        bloodTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodTypes[row] 
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        data.bloodType = bloodTypes[row]
    }
}
