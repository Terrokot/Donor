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
    let acceptButtonSize: CGFloat = 128
    let cancelButtonSize: CGFloat = 70
    
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
        setupAcceptModeConstraints()
        backgroundColor = UIColor.clear
        setBackgroundImage(heartImage, for: .normal)
        layer.cornerRadius = 150
    }
    
    func cancelMode() {
        setupCancelModeConstraints()
        let cancelImage = UIImage.init(named: "cancel")
        setBackgroundImage(cancelImage, for: .normal)
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
        //translatesAutoresizingMaskIntoConstraints = true
        // removeConstraint(heightAnchor.constraint(equalToConstant: 128))
        // removeConstraint(widthAnchor.constraint(equalToConstant: 128))
        // heightAnchor.constraint(equalToConstant: 70).isActive = true
        // widthAnchor.constraint(equalToConstant: 70).isActive = true
        // frame.size = CGSize(width: cancelButtonSize, height: cancelButtonSize)
        
    }
    private func setupAcceptModeConstraints() {
        // translatesAutoresizingMaskIntoConstraints = true
        //removeConstraint(heightAnchor.constraint(equalToConstant: 70))
        // removeConstraint(widthAnchor.constraint(equalToConstant: 70))
        //heightAnchor.constraint(equalToConstant: 128).isActive = true
        // widthAnchor.constraint(equalToConstant: 128).isActive = true
        //frame.size = CGSize(width: cancelButtonSize, height: acceptButtonSize)
        
        
    }
    
}
