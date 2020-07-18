//
//  DonorCell.swift
//  Donor
//
//  Created by Egor Tereshonok on 7/19/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class DonorCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
