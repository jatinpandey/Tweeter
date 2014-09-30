//
//  ComposeViewController.swift
//  tweeter
//
//  Created by Jatin Pandey on 9/25/14.
//  Copyright (c) 2014 Jatin Pandey. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var tweetView: UITextView!
    var poster: String! = "Yooo"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        posterName.text = poster
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        println(tweetView.text)
        var status = tweetView.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        println(status)
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(status!)", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println(response)
                self.dismissViewControllerAnimated(true, completion: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error posting tweet")
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
