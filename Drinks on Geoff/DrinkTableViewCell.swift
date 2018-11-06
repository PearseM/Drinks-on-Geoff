//
//  DrinkTableViewCell.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 04/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
