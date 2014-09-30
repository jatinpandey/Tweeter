//
//  User.swift
//  tweeter
//
//  Created by Jatin Pandey on 9/27/14.
//  Copyright (c) 2014 Jatin Pandey. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrent"
let userDidLoginNotification = "userDidLogin"
let userDidLogoutNotification = "userDidLogout"

class User: NSObject {
    var name: String!
    var screenName: String!
    var profileImageUrl: String!
    var tagline: String!
    var dictionary: NSDictionary!

    init(userDict: NSDictionary) {
        self.dictionary = userDict
        self.name = userDict["name"] as? NSString
        self.screenName = userDict["screen_name"] as? NSString
        self.profileImageUrl = userDict["profile_image_url"] as? NSString
        self.tagline = userDict["description"] as? NSString
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(userDict: dictionary)
        }
        }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
    }
    
}
