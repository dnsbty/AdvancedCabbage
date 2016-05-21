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
    
    override func viewDidLoad() {
        if urlString != nil {
            guard let url = NSURL(string: urlString!) else {
                print("Error converting string to URL")
                return
            }
            webView.loadRequest(NSURLRequest(URL: url))
        }
    }
}
