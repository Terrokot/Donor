//
//  TopViewController.swift
//  Donor
//
//  Created by Egor Tereshonok on 8/2/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    let image = UIImage(named: R.image.topViewImage.name)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    
    func setup() {
        setShadow()
        view.backgroundColor = UIColor.clear
    }
    
    private func setShadow() {
        view.layer.shadowColor   = UIColor.black.cgColor
        view.layer.shadowOffset  = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowRadius  = 8
        view.layer.shadowOpacity = 0.3
        view.clipsToBounds       = true
        view.layer.masksToBounds = false
    }
}

