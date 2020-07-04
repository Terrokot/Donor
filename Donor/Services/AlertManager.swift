//
//  AlertManager.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/4/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
    
    private init() {}
    
    static func displayAlert(title:String, message:String, VC: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        VC.present(alertController, animated: true, completion: nil)
    }
}
