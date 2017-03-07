

import UIKit

class DetailTweetViewController: UIViewController {

    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screenName: UILabel!
    
    var tweets: Tweet!
 // var tweet: Tweet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = tweets.username
        viewloaded()
      //  favNrt()
        retweetLabel.text = "\(tweets.retweetCount)"
        favoriteLabel.text = "\(tweets.favoritesCount)"
        
    }
    
    
    private func viewloaded() {
        profPic.setImageWith(tweets.imgUrl!)
        screenName.text = tweets.handle
        tweetTextLabel.text = tweets.text
    }
 /*   private func favNrt() {
    
        if tweets.isFavorited!  {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            
        }
        
        if tweets.isRetweeted!{
            rtButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        else{
            rtButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        
        favoriteLabel.text = "\(tweets?.favoritesCount)"
        retweetLabel.text = "\(tweets?.retweetCount)"
    } */
    
    @IBAction func rtButton(_ sender: Any) {
    }
    
      @IBAction func favButton(_ sender: Any) {
    }
    

    }


