//
//  NewsByCategoryHeaderTableViewCell.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/5/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class NewsByCategoryHeaderTableViewCell: UITableViewCell {

    @IBOutlet var headerCategoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerCategoryImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
