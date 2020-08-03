//
//  HeartButton.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/25/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class HeartButton: UIButton {
    
    let heartImage = UIImage.init(named: R.image.heartRequest.name)
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
        backgroundColor = UIColor.clear
        setBackgroundImage(heartImage, for: .normal)
        layer.cornerRadius = frame.size.height / 2
    }
    
    func cancelMode() {
        let cancelImage = UIImage.init(named: R.image.cancel.name)
        setBackgroundImage(cancelImage, for: .normal)
    }
    func acceptMode() {
        setBackgroundImage(heartImage, for: .normal)
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
