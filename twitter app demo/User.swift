//
//  User.swift
//  twitter app demo
//
//  Created by Yukkee chang on 2/25/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String?
    var screenname : String?
    var profileURL : URL?
    var tagline : String?
    var dictionary : NSDictionary?
    var followersCount : Int?
    var followingCount : Int?
    var bannerUrl : URL?
    //so you can do user.name, user.screenname and etc don't have to call the dictionary key
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String?
        screenname = dictionary["screen_name"] as! String?
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tagline = dictionary["description"] as! String?

        let profileUrlString = dictionary["profile_image_url_https"] as! String?
        if let profileUrlString  = profileUrlString {
            profileURL = URL(string: profileUrlString)!
        }
        let banner = dictionary["profile_banner_url"] as! String?
        if let banner = banner {
        bannerUrl = URL(string: banner)!
        }
        
    }
    
    static let  userDidLogOut = NSNotification.Name(rawValue: "UserDidLogout")
    static var _currentUser : User?
    class var currentUser : User? {
        set {
            let user = newValue
            _currentUser = user
            let defaults = UserDefaults.standard
            if user != nil {
                let data = try! JSONSerialization.data(withJSONObject: (user?.dictionary)!, options: [])
                defaults.setValue(data, forKey: "currentUser")
            } else {
                defaults.removeObject(forKey: "currentData")
            }
            
            defaults.synchronize()
        }
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.object(forKey: "currentUser") as?
                    Data {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
    }
    class func userWithScreenName(_ screeenName: String, success: @escaping ((User) -> ()), failure : @escaping (Error) -> ()) {
        TwitterClient.sharedInstance.userWithScreenName(screeenName, success: success, failure: failure)
    }

}



