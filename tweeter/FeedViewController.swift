//
//  FeedViewController.swift
//  tweeter
//
//  Created by Jatin Pandey on 9/25/14.
//  Copyright (c) 2014 Jatin Pandey. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

    }
    
    override func viewDidAppear(animated: Bool) {
        getTweets()
    }
    
    func getTweets() {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            self.tableView.reloadData()
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error getting tweets")
        })
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(0, closure: {
            self.getTweets()
            self.refreshControl.endRefreshing()
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        var currentTweet = tweets![indexPath.row]
        cell.timestamp.text = currentTweet.createdAtString
        cell.username.text = currentTweet.user.screenName
        cell.tweet.text = currentTweet.text
        cell.profilePic.setImageWithURL(NSURL(string: currentTweet.user.profileImageUrl))
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        }
        else {
            return 0
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("detailSegue", sender: indexPath)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "composeSegue" {
            println("Compose screen invoked")
            var compNav = segue.destinationViewController as UINavigationController
            var comp = compNav.topViewController as ComposeViewController
        }
        else if segue.identifier == "detailSegue" {
            var detailVC = segue.destinationViewController as DetailViewController
            if var x = tweets?[sender.row] {
                println("Segueing to this row")
                detailVC.tweet = tweets![sender.row]
//                detailVC.tweetLabelString = tweets![sender.row].text
            }
            else {
                println("Tweet not in index")
            }
            println("Row is \(sender.row)")
        }
    }

}
