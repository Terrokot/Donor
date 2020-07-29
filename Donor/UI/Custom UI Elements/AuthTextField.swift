//
//  AuthLabel.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/29/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class AuthTextField: UITextField {
    
    var containerView = UIView()
    
    var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = AuthColors.backgroundTextField
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = AuthColors.borderColor.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var contentsLayer: UIView = {
        let view = UIView()
        view.backgroundColor = AuthColors.backgroundTextField
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        addSubview(mainView)
        mainView.addSubview(contentsLayer)
        
        NSLayoutConstraint.activate([
            // Constrains your mainView to the ViewController's view
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainView.heightAnchor.constraint(equalToConstant: frame.height),
            mainView.widthAnchor.constraint(equalToConstant: frame.width),
            // Constrains your contentsLayer to the mainView
            contentsLayer.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            contentsLayer.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            contentsLayer.heightAnchor.constraint(equalTo: mainView.heightAnchor),
            contentsLayer.widthAnchor.constraint(equalTo: mainView.widthAnchor)
        ])
        
    }
}
