//
//  HeartButton.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/25/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class HeartButton: UIButton {
    
    let image = UIImage.init(named: "heartRequest")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        setShadow()
        setTitle("", for: .normal)
        setBackgroundImage(image, for: .normal)
        layer.cornerRadius = 150
    }
    
    func cancelMode() {
        setBackgroundImage(.none, for: .normal)
    }
    
    private func setShadow() {
         layer.shadowColor   = UIColor.black.cgColor
         layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
         layer.shadowRadius  = 20
         layer.shadowOpacity = 0.4
         clipsToBounds       = true
         layer.masksToBounds = false
     }
    
}
