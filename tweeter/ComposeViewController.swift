//
//  ComposeViewController.swift
//  tweeter
//
//  Created by Jatin Pandey on 9/25/14.
//  Copyright (c) 2014 Jatin Pandey. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var posterName: UILabel!
    
    @IBOutlet weak var chars: UILabel!
    @IBOutlet weak var tView: UITextView!
    var poster: String! = "Yooo"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        posterName.text = poster
        tView.delegate = self
        tView.layer.borderColor = UIColor.blueColor().CGColor
        tView.layer.borderWidth = 2
    }

    func textViewDidChange(textView: UITextView) {
        var tweetVal = tView.text as NSString
        var currentLength = tweetVal.length
        let charsLeft = 40 - currentLength
        chars.text = "\(charsLeft)"
    }

    @IBAction func onTapGoKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTweet(sender: AnyObject) {
        if chars.text?.toInt() >= 0 {
            var status = tView.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            println(status)
            TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(status!)", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println(response)
                self.dismissViewControllerAnimated(true, completion: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error posting tweet")
            })
        }
        else {
            println("Too long")
            let alert = UIAlertView(title: "Unable to post", message: "Make sure tweet is within 40 chars", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
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
