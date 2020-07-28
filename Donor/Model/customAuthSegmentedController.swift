//
//  customSegmentController.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/28/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class customAuthSegmentedController: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
    }
}
