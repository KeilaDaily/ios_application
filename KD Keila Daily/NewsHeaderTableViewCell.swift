//
//  NewsHeaderTableViewCell.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/5/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import ImageSlideshow

class NewsHeaderTableViewCell: UITableViewCell {
    @IBOutlet var newsHeaderSlideShow: ImageSlideshow!
    @IBOutlet var advertisingImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [newsHeaderSlideShow].forEach {
            $0?.contentScaleMode = .scaleAspectFill
            $0?.slideshowInterval = 10.0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
