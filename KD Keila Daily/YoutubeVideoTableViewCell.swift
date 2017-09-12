//
//  YoutubeVideoTableViewCell.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 5/29/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class YoutubeVideoTableViewCell: UITableViewCell {

    @IBOutlet var lbDateTime: UILabel!
    @IBOutlet var lbViewCount: UILabel!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var imgVideoImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
