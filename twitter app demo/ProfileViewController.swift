//
//  ProfileViewController.swift
//  twitter app demo
//
//  Created by Yukkee chang on 2/27/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tweetsCount: UILabel!

    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bannerPic: UIImageView!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    var tweets : Tweet?
    var tweet : [Tweet]?
    var userInfo : User!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewloaded()
        setupHeader()
        loadtweets()
        userScreenName = userScreenName != nil ? userScreenName : User.currentUser?.screenname
        tableView.dataSource = self
        tableView.delegate = self

    
    }
    
    var userScreenName : String? {
        didSet
        {
            User.userWithScreenName(tweets!.handle, success: { (user) in
                self.userInfo = user
        //      self.tweetsCount.text = "\(user.tweetCount)"
                self.bannerPic.setImageWith(user.bannerUrl!)
                self.followingCount.text = "\(user.followingCount!)"
                self.followersCount.text = "\(user.followersCount!)"
                self.usernameLabel.text = user.name
                
            }, failure: { (error) in })}
    }
    
    private func viewloaded() {
     handleLabel.text = tweets?.handle
    }
    
    private func setupHeader() {
        profPic.setImageWith((tweets?.imgUrl)!)
        handleLabel.text = tweets?.handle
       
        

        
    }
 
    func loadtweets() {
        TwitterClient.sharedInstance.userTimeline(with: tweets!.handle, success: { (tweet) in
            self.tweet = tweet              
            self.tableView.reloadData()
        }, failure: { (error) in })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadtweets()
    }
    
    
   /*     if tweets.favorited!  { likeButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        else{
            likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        
        if tweets.retweeted!{
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        
        favorites.text = "\(tweets.favoritesCount)"
        retweets.text = "\(tweets.retweetCount)"
    }
    
    @IBAction func retweet(_ sender: Any) {     //|||NOT DONE WITH THESE....COME BACK
        
    }
    
    @IBAction func like(_ sender: Any) {
        
    }
    } */
        
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweet?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! profileViewCell
        cell.tweet = tweet?[indexPath.row]      
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


