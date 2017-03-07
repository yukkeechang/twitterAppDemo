//
//  TwitterClient.swift
//  twitter app demo
//
//  Created by Yukkee chang on 2/25/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!,
                                              consumerKey: "X0s325tWkS593op3r6ZiOOaGe",consumerSecret: "YPDOwCsJt4i4ovHAuTGGxZuKI7h713ci9i2RlwPO44A2tOU1Lo")!
    
    func homeTimeLine(success: @escaping ( ([Tweet]) -> ()), failure: @escaping (Error) -> () ) {
        get("1.1/statuses/home_timeline.json",
            parameters: nil ,
            progress: nil,
            success: {(task, response) in
                
                let userDictionary = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries: userDictionary)
                
                success(tweets)
        }, failure: {(task, error) in
            failure(error)
        })
    }
        
        func userTimeline(with screenName: String, success: @escaping (([Tweet]) -> ()), failure : @escaping (Error) -> ()) {
            
            get("1.1/statuses/user_timeline.json",
                parameters: ["screen_name" : screenName],
                progress: nil,
                success: { (task, response) in
                    
                    let dictionaries = response as! [NSDictionary]
                    let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                 
                    success(tweets)
            }, failure: { (task, error) in
                failure(error)
            })
        }
            


    func currentAccount(success: @escaping ((User) -> ()), failure : @escaping ((Error) -> ())) {
        get("1.1/account/verify_credential.json",
            parameters: nil,
            progress: nil,
            success: {(task, response) in
            let dictionaries = response as! NSDictionary
                let user = User(dictionary: dictionaries)
                success(user)
        }, failure: {(task, error) in
            failure(error)
        })
}


    var loginSuccess : ( () -> () )?
    var loginFailure : ((Error) -> () )?

    func login(success : @escaping () -> (), failure: @escaping(Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token",    method: "GET",
                                                        callbackURL: URL(string: "Twitter-client://oauth"),
                                                        scope: nil,
                                                        success: {(requestToken) in
                                                            let url = URL(string: "https://api.twitter.com/oauth/authorize? oauth_token=\(requestToken?.token)!)")
                                                            UIApplication.shared.open(url!)},
                                                        failure: {(error) in })}
    func logout() {
        deauthorize()
        User.currentUser = nil
        NotificationCenter.default.post(name: User.userDidLogOut, object: nil)
    }
    
    func handleOpenURL(_ url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        TwitterClient.sharedInstance.fetchAccessToken(withPath: "oauth/access_token",
                                                       method: "POST",
                                                       requestToken: requestToken,
                                                    
                                                       success: { (accessToken) in
                                                        self.currentAccount(success: {(user: User) in User.currentUser = user
                                                            self.loginSuccess?()
                                                        }, failure: { (error) in
                                                            self.loginFailure?(error)
                                                        })
                                                        
                                                        self.loginSuccess?()
                                                    
        }, failure: { (error) in print("error")
            self.loginFailure?(error!)
        })
    }
    func favorite(tweetID: String, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()){
        post("/1.1/favorites/create.json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    // unfavoriting function
    func unfavorite(tweetID: String, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()){
        post("/1.1/favorites/destroy.json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    // retweet function
    func retweet(tweetID: String, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()){
        post("1.1/statuses/retweet/\(tweetID).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    // unretweet function
    func unretweet(tweetID: String, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()){
        post("1.1/statuses/unretweet/\(tweetID).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    func userWithScreenName(_ screenName: String, success: @escaping ((User) -> ()), failure : @escaping (Error) -> ()) {
        get("1.1/users/show.json",
            parameters: ["screen_name" : screenName],       //|||||||||||||||||
            progress: nil,                                  //||||[THIS IS USED TO ASSOCIATE USER ACCORDING TO SCREENAME]
            success: { (task, response) in
                
                let dictionary = response as!NSDictionary
                let user = User(dictionary: dictionary)
                success(user)
                
        }, failure: { (task, error) in
            failure(error)
        })
    }
}




