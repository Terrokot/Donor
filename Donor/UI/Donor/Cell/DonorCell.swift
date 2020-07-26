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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup() {
        
            setShadow()
        
            let image = UIImage.init(named: R.image.loadingCat.name)

            patientImage.image = image
            patientImage.layer.cornerRadius = patientImage.frame.width / 2
            patientImage.clipsToBounds = true
            cardView.layer.cornerRadius = 10
            cardView.clipsToBounds = true
        }
    
    private func setShadow() {
            layer.shadowColor   = UIColor.black.cgColor
            layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
            layer.shadowRadius  = 5
            layer.shadowOpacity = 0.4
            clipsToBounds       = true
            layer.masksToBounds = false
        }
    
    }
    
