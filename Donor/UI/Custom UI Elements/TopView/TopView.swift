//
//  TopView.swift
//  Donor
//
//  Created by Egor Tereshonok on 8/2/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

@objc protocol TopViewDelegate: class {
    @objc optional func leftAction()
    @objc optional func rightAction()
}


@IBDesignable
class TopView: UIView {
    
    weak var delegate: TopViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var topViewImage: UIImageView!
    
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    @IBOutlet weak var rightButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightButtonWidthConstraint: NSLayoutConstraint!
    
    
    @IBInspectable public var mailLabelText: String = "Heading" {
        didSet { mainLabelSetup() }
    }
    @IBInspectable public var secondLabelText: String = "subheading" {
        didSet { secondLabelSetup() }
    }
    
    
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
        topViewImage.layer.cornerRadius = frame.size.height / 10
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
    
    //MARK: Outlets Setup
    private func mainLabelSetup() {
        mainLabel.isHidden = false
        mainLabel.text = mailLabelText
    }
    private func secondLabelSetup() {
        secondaryLabel.isHidden = false
        secondaryLabel.text = secondLabelText
    }
    
    //MARK: Actions Setup
    @IBAction func leftTapped(_ sender: Any) {
        delegate?.leftAction?()
    }
    @IBAction func rightTapped(_ sender: Any) {
        delegate?.rightAction?()
    }
    
}
