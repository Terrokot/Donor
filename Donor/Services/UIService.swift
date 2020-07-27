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
        else { print("error TopController"); return UIViewController() }
    
    return controller
}

public var keyWindow: UIView {
    
    guard let _window = UIApplication.shared.delegate?.window,
        let window = _window
        else { print("error keyWindow"); return UIView() }
    
    return window
}

//MARK: UIView extension

public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set { clipsToBounds = true; layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor {
        set { layer.borderColor = newValue.cgColor }
        get { print("warning borderColor"); return UIColor.clear }
    }
}

