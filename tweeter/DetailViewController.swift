//
//  DetailViewController.swift
//  tweeter
//
//  Created by Jatin Pandey on 9/29/14.
//  Copyright (c) 2014 Jatin Pandey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tweetLabel: UILabel!
//    var tweetLabelString: String!
    var tweet: Tweet!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetLabel.text = tweet.text
        println(tweet.id)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(tweet.id).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
//            self.dismissViewControllerAnimated(true, completion: nil)
            self.retweetButton.setTitle("Retweeted", forState: UIControlState.Normal)
            self.retweetButton.enabled = false
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error posting retweet")
                println(error)
        })
    }

    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json?id=\(tweet.id)", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println(response)
                self.favoriteButton.setTitle("Favorited", forState: UIControlState.Normal)
                self.favoriteButton.enabled = false
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error favoriting")
                println(error)
        })
    }

    @IBAction func onReply(sender: AnyObject) {
        // Make this customizable (new screen or expose text field
        var replyText = "Cool%20post"
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(replyText)&in_reply_to_status_id=\(tweet.id)", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            self.replyButton.setTitle("Replied", forState: UIControlState.Normal)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error posting reply")
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
