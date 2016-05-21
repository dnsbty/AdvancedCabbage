//
//  WebViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/21/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class WebViewController : UIViewController {
    var urlString : String?
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        if urlString != nil {
            guard let url = NSURL(string: urlString!) else {
                print("Error converting string to URL")
                return
            }
            webView.loadRequest(NSURLRequest(URL: url))
            navBar.title = url.host
        }
    }
    
    @IBAction func closeWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sharePage(sender: AnyObject) {
        if let url = NSURL(string: urlString!) {
            let objectsToShare = [url]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
}
