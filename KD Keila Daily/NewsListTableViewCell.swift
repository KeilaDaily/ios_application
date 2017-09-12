//
//  NewsListTableViewCell.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 2/2/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var newsDateTimeLabel: UILabel!
    @IBOutlet var newsTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        newsImageView.contentMode = .scaleAspectFill
        newsImageView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
