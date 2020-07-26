//
//  HeartButton.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/25/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class HeartButton: UIButton {
    
    let heartImage = UIImage.init(named: "heartRequest")
    let cancelImage = UIImage.init(named: "cancel")
    
    
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
        backgroundColor = UIColor.clear
        setBackgroundImage(heartImage, for: .normal)
        layer.cornerRadius = 150
    }
    
    func cancelMode() {
        setBackgroundImage(cancelImage, for: .normal)
        setupCancelModeConstraints()
    }
    
    func acceptMode() {
        setBackgroundImage(heartImage, for: .normal)
        setupAcceptModeConstraints()
    }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 20
        layer.shadowOpacity = 0.4
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    private func setupCancelModeConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    private func setupAcceptModeConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 128).isActive = true
        widthAnchor.constraint(equalToConstant: 128).isActive = true
        
    }
    
}
