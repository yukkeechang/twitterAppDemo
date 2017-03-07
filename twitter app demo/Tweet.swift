//
//  Tweet.swift
//  twitter app demo
//
//  Created by Yukkee chang on 2/25/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text : String?
    var retweetCount : Int = 0
    var favoritesCount: Int = 0
    var imgUrl : URL?
    var username : String?
    var handle = "@"
    var isFavorited: Bool?
    var isRetweeted: Bool?
    var tweetID: String?
    var timestampValue: String?
    var timestamp : Date?
   
  
     public var dateFormatter : DateFormatter = {
        let dFormatter = DateFormatter()
        dFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
  //      let date = dFormatter.date(from: time)!
        return dFormatter }()
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        username = dictionary.value(forKeyPath: "user.name") as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        isFavorited = dictionary["favorited"] as? Bool
        isRetweeted = dictionary["retweeted"] as? Bool
        tweetID = dictionary["id_str"] as? String
        handle += dictionary.value(forKeyPath: "user.screen_name") as! String
        
        if let timestampValue = dictionary["created_at"] as? String {
            timestamp = dateFormatter.date(from: timestampValue)
        }

        
        
       /* if let timestampValue = dictionary["created_at"] as? String {
        timestamp = dateFormatter.date(from: timestampValue) */
    
        if let profileImageURLString = dictionary.value(forKeyPath:"user.profile_image_url_https") as? String {
            imgUrl = URL(string: profileImageURLString)
        }
  }
    
    
    class func tweetsWithArray(dictionaries : [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        dictionaries.forEach { (dictionary) in tweets.append(Tweet(dictionary:dictionary)) }
        return tweets
    }
  }

extension DateFormatter
{
    /**
     Formats a date as the time since that date (e.g., “Last week, yesterday, etc.”).
     
     - Parameter from: The date to process.
     - Parameter numericDates: Determines if we should return a numeric variant, e.g. "1 month ago" vs. "Last month".
     /Users/luiscastillo/Downloads/twitterAppDemo-master/twitter app demo
     - Returns: A string with formatted `date`.
     */
    class func timeSince(from: Date, numericDates: Bool = false) -> String {
        let calendar = Calendar.current
        let now = NSDate()
        let earliest = now.earlierDate(from as Date)
        let latest = earliest == now as Date ? from : now as Date
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
        
        var result = ""
        
        //you can change the string here to display x years ago, x mins ago etc by altering result
        if components.year! >= 1 {
            result = "\(components.year!)y"
        } else if components.month! >= 1 {
            result = "\(components.month!)m"
        } else if components.weekOfYear! >= 1 {
            result = "\(components.weekOfYear!)w"
        } else if components.day! >= 1 {
            result = "\(components.day!)d"
        } else if components.hour! >= 1 {
            result = "\(components.hour!)h"
        } else if components.minute! >= 1 {
            result = "\(components.minute!)m"
        } else if components.second! >= 1 {
            result = "\(components.second!)s"
        } else {
            result = "Just now"
        }
        
        return result
    }
}


