//
//  UIService.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/25/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation
import UIKit

public var topmostController: UIViewController {
    
    var topController = UIApplication.shared.keyWindow?.rootViewController;
    
    while topController?.presentedViewController != nil {
        topController = topController?.presentedViewController;
    }
    
    guard let controller = topController
        else { print("errorTopController"); return UIViewController() }
    
    return controller
}

public var keyWindow: UIView {
    
    guard let _window = UIApplication.shared.delegate?.window,
        let window = _window
        else { print("errorkeyWindow"); return UIView() }
    
    return window
}
