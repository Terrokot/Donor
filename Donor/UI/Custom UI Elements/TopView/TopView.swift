//
//  TopView.swift
//  Donor
//
//  Created by Egor Tereshonok on 8/2/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

@IBDesignable
class TopView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    

      override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
           commonInit()
           setShadow()
           backgroundColor = UIColor.clear
           layer.cornerRadius = frame.size.height / 2
       }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.3
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    private func commonInit() {
         let bundle = Bundle(for: TopView.self)
         bundle.loadNibNamed("TopView", owner: self, options: nil)
         addSubview(contentView)
         contentView.frame = self.bounds
         contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
     }
    
}
