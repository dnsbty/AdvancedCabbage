//
//  NewGameViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit
import Alamofire

class NewGameViewController : UIViewController {
    
    var type: String?
    
    // MARK: Outlets
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var joinName: UITextField!
    @IBOutlet weak var joinCode: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "create" {
            name.text = NSUserDefaults.standardUserDefaults().objectForKey("name") as? String
            name.becomeFirstResponder()
        } else {
            joinName.text = NSUserDefaults.standardUserDefaults().objectForKey("name") as? String
            joinName.becomeFirstResponder()
        }
    }
    
    // MARK: Actions
    
    @IBAction func createGame(sender: AnyObject) {
        createButton.enabled = false
        Game.shared.create(name.text!, completion: {
            self.performSegueWithIdentifier("createQueue", sender: self)
        })
        NSUserDefaults.standardUserDefaults().setObject(name.text!, forKey: "name")
    }
    
    @IBAction func joinGame(sender: AnyObject) {
        joinButton.enabled = false
        Game.shared.join(joinCode.text!, name: joinName.text!, completion: {
            self.performSegueWithIdentifier("joinQueue", sender: self)
        })
        NSUserDefaults.standardUserDefaults().setObject(joinName.text!, forKey: "name")
    }
}
