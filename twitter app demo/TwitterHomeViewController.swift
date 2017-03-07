//
//  TwitterHomeViewController.swift
//  twitter app demo
//
//  Created by Yukkee chang on 2/25/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit

class TwitterHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, tableViewCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    var tweet : Tweet?
    var user : User?


    override func viewDidLoad() {
        super.viewDidLoad()
      //  tableView.rowHeight = UITableViewAutomaticDimension
       // tableView.estimatedRowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
         let refreshControl = UIRefreshControl()
         refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        
//        sharedInstance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sharedInstance()
    }
    
  

    private func sharedInstance() {
        TwitterClient.sharedInstance.homeTimeLine(success: { ( tweets : [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            print("RELOADING DATA")
            
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            print("REFRESH CONTROL")
            refreshControl.endRefreshing()
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
        let tweet = tweets?[indexPath.row]
        cell.delegate = self
        cell.tweet = tweet
        cell.indexpath = indexPath
        cell.timestampLabel.text =  DateFormatter.timeSince(from: (tweet?.timestamp)!)
        cell.usernameLabel.text = tweet?.username
        print("TWEET: \(tweet!)")
        print("USERNAME: \(tweet?.username)")
        cell.profPicImageView.setImageWith((tweet?.imgUrl)!)
        cell.tweetTextLabel.text = tweet?.text
        cell.handleLabel.text = tweet?.handle
        return cell
    }
    
    

    
    var indexPath : NSIndexPath!
    
    func onFavoritee(for cell:tableViewCell) {
        
        if cell.tweet.isFavorited == false {
            TwitterClient.sharedInstance.favorite(tweetID: cell.tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweets?[(cell.indexpath?.row)!] = tweet
                self.tableView.reloadRows(at: [cell.indexpath!], with: .none)
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
        } else{
            TwitterClient.sharedInstance.unfavorite(tweetID: cell.tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweets?[(cell.indexpath?.row)!] = tweet
                self.tableView.reloadRows(at: [cell.indexpath!], with: .none)
                
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
        
    }
    
    func onRetweett(for cell: tableViewCell) {
        if cell.tweet.isRetweeted == false {
            TwitterClient.sharedInstance.retweet(tweetID: cell.tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweets?[(cell.indexpath?.row)!] = tweet
                self.tableView.reloadRows(at: [cell.indexpath!], with: .none)
            }, failure: { (error: Error) in
                print("error found in func retweett")
                print(error.localizedDescription)
               
            })
        }
        else{
            
            TwitterClient.sharedInstance.unretweet(tweetID: cell.tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweets?[(cell.indexpath?.row)!] = tweet
                self.tableView.reloadRows(at: [cell.indexpath!], with: .none)
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailView") {
            let cell = sender as! tableViewCell
            let indexPath = tableView.indexPath(for: cell)
            tweet = tweets[indexPath!.row]
            let detailedViewController = segue.destination as! DetailTweetViewController
            detailedViewController.tweets = tweet
      }
       /* if(segue.identifier == "newTweet") {
                let currentUser = self.user
                let navVC = segue.destination as? UINavigationController
                let tweetVC = navVC?.viewControllers.first as! newTweetViewController
                tweetVC.user = currentUser!
            
        } */
        if(segue.identifier == "user") {
            if let button = sender as? UIButton {
                if let superview = button.superview {   //GET BUTTON'S SUPERVIEW
                    if let cell = superview.superview as? UITableViewCell {
                        let indexPath = tableView.indexPath(for: cell) as NSIndexPath!
                        tweet = tweets[(indexPath?.row)!]
                        print("\(indexPath?.row)") //[TESTING!! OUTPUTS ROW NUMBER]
                        let userView = segue.destination as! ProfileViewController
                        userView.tweets = tweet
                    }
                }
            }
        }
    }

}
