//
//  profileViewCellTableViewCell.swift
//  twitter app demo
//
//  Created by Yukkee chang on 3/5/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit

class profileViewCell: UITableViewCell {

    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    
    var tweet: Tweet? {
        didSet{
            handle.text = tweet?.handle
            username.text = tweet?.username
            profPic.setImageWith((tweet?.imgUrl)!)
            tweetText.text = tweet?.text
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
