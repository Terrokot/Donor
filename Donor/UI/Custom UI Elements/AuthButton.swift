//
//  AuthButton.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/30/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class AuthButton: UIButton {
    
         override init(frame: CGRect) {
            super.init(frame: frame)
            setupButton()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupButton()
        }
        
        func setupButton() {
            //setShadow()
            setTitleColor(.white, for: .normal)
            titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
            backgroundColor      = Colors.red
            layer.cornerRadius   = frame.height / 2
            layer.borderWidth    = 0.5
            layer.borderColor    = Colors.borderColor.cgColor
        }
        
        private func setShadow() {
            layer.shadowColor   = UIColor.black.cgColor
            layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
            layer.shadowRadius  = 5
            layer.shadowOpacity = 0.5
            clipsToBounds       = true
            layer.masksToBounds = false
        }
    }
