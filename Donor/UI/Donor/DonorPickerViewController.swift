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
        
        topViewSetup()
        topView.delegate = self
    }
    
    private func done() {
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

//MARK: - Top View Delegate & Setup

extension DonorPickerViewController: TopViewDelegate {
    func rightAction() {
        done()
    }
    
    fileprivate func topViewSetup() {
        topView.mailLabelText          = "Donor"
        topView.secondLabelText        = "Select blood Type"
        topView.rightButton.isHidden   = false
        topView.rightButton.tintColor  = .white
    }
}
