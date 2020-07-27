//
//  donorPatientSegmentControll.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/27/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class donorPatientSegmentControll: UISegmentedControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = frame.size.height / 2
        
    }

}
