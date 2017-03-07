//
//  newTweetViewController.swift
//  twitter app demo
//
//  Created by Yukkee chang on 3/5/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit

class newTweetViewController: UIViewController {
    var user : User?
    
    
    @IBAction func cancelButton(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetButton(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
        
        
    }
    
  
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
