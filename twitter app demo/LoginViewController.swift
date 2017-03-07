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
        
        
        TwitterClient.sharedInstance.login(success: { 
            
            // logged in now, can segue into the next view controller
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }) { (error: Error) in
            print("Error: \(error.localizedDescription)")
        }
        
        
    }

}
