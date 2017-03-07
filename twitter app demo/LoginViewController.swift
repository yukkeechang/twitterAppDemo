//
//  LoginViewController.swift
//  twitter app demo
//
//  Created by Yukkee chang on 2/20/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        
        if let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!,
                                                    consumerKey: "X0s325tWkS593op3r6ZiOOaGe",
                                                    consumerSecret: "YPDOwCsJt4i4ovHAuTGGxZuKI7h713ci9i2RlwPO44A2tOU1Lo") {
            twitterClient.deauthorize()
            twitterClient.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "Twitter-client://oauth"), scope: nil, success: {
                
                (requestToken: BDBOAuth1Credential?) in
                print("f")
                let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")
                UIApplication.shared.open(url!)
                //switches out of your app to something else
                print("logged in, got token")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            },  failure: { (error) in
                
            })
            
        }
        
        
    }
    
}


