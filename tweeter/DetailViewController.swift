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
    var tweetLabelString: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetLabel.text = tweetLabelString
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
