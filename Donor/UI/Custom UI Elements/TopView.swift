//
//  TopView.swift
//  Donor
//
//  Created by Egor Tereshonok on 8/2/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class TopView: UIView {
    
    
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
           backgroundColor = UIColor.clear
        if let image = UIImage(named: R.image.topViewImage.name) {
           backgroundColor = UIColor.init(patternImage: image )
        }
           //setBackgroundImage(gradientImage, for: .normal)
           layer.cornerRadius = frame.size.height / 2
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
