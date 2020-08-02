//
//  DonorPickerViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/22/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

protocol DonorPickerViewControllerDelegate {
    func sendData(_ data: Donor)
}

class DonorPickerViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var topView: TopView!
    
    override var shouldAutorotate: Bool { return false }
    
    var donorPickerViewControllerDelegate: DonorPickerViewControllerDelegate?
    var data = Donor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.mailLabelText = "KOKOKOKO"
    
        
        
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        donorPickerViewControllerDelegate?.sendData(data)
        print(data)
        dismiss(animated: true, completion: nil)
    }
}

extension DonorPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
