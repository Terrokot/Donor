//
//  DonorCell.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/25/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class DonorCell: UITableViewCell {
    
    public static let reuseId = "DonorCell"
    
    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        backgroundColor = .clear
        selectionStyle = .none
        tintColor = .systemRed
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setup() {
        setShadow()
        backgroundColor = .clear
        selectionStyle  = .none
        tintColor       = .systemRed
        
        let image = UIImage.init(named: R.image.loginIconActive.name)
            //?.resized(to: CGSize(width: patientImage.frame.width, height: patientImage.frame.height))
        patientImage.image               = image
        patientImage.layer.cornerRadius  = patientImage.frame.width / 2
        
        patientImage.clipsToBounds       = true
        cardView.layer.cornerRadius      = 10
        cardView.clipsToBounds           = true
        
        //
    }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius  = 4
        layer.shadowOpacity = 0.3
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    private func secondShadow() {
        let secondShadowLayer = CALayer()
        secondShadowLayer.shadowRadius   = 20
        secondShadowLayer.shadowColor    = UIColor.systemRed.cgColor
        secondShadowLayer.shadowOpacity  = 0.5
        secondShadowLayer.masksToBounds  = false
        layer.insertSublayer(secondShadowLayer, at: 1)
    }
}

