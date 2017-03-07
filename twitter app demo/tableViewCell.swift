//
//  tableViewCell.swift
//  twitter app demo
//
//  Created by Yukkee chang on 2/25/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

protocol tableViewCellDelegate {
    func onRetweett(for cell: tableViewCell)
    func onFavoritee(for cell: tableViewCell)
}



import UIKit

class tableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var profPicImageView: UIImageView!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var handleLabel: UILabel!
    
    var delegate: tableViewCellDelegate?
    var indexpath : IndexPath?
    
       var tweet : Tweet! {
        
        didSet {
            usernameLabel.text = tweet?.username

           
            if tweet.isFavorited! {
                favButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            }
            else{
                favButton.setImage(UIImage(named: "favor-icon"), for: .normal)

            }
            
            if tweet.isFavorited! && tweet.favoritesCount == 0 { tweet.favoritesCount += 1 }
            
            
            if tweet.isRetweeted!{
                rtButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
            else{
                rtButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            }
            
            if tweet.isRetweeted! && tweet.retweetCount == 0 {tweet.favoritesCount += 1 }
            
            favoritesLabel.text = "\(tweet.favoritesCount)"
            retweetLabel.text = "\(tweet.retweetCount)"
        }
     }

    /* timestampLabel.text = "\(DateFormatter.localizedString(from: tweet.timestamp!, dateStyle: .short, timeStyle: .none))" */
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        delegate?.onFavoritee(for: self)
    }
    
    
    @IBAction func retweetTapped(_ sender: Any) {
        delegate?.onRetweett(for: self)
    }
  
    

}

