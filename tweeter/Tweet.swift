//
//  Tweet.swift
//  tweeter
//
//  Created by Jatin Pandey on 9/26/14.
//  Copyright (c) 2014 Jatin Pandey. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User!
    var text: NSString!
    var createdAtString: String!
    var createdAt: NSDate!
    var id: Int!

    init(tweetDict: NSDictionary) {
        self.user = User(userDict: tweetDict["user"] as NSDictionary)
        self.text = tweetDict["text"] as? NSString
        self.createdAtString = tweetDict["created_at"] as? NSString
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.createdAt = formatter.dateFromString(createdAtString)
        self.id = tweetDict["id"] as? Int
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(tweetDict: dictionary))
        }
        
        return tweets
    }

}
