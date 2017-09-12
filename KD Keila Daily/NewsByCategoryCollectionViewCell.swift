//
//  NewsByCategoryCollectionViewCell.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/24/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class NewsByCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var newsTitleLabel: UILabel!
    
    override func awakeFromNib() {
        newsImageView.contentMode = .scaleToFill
    }
    
}
