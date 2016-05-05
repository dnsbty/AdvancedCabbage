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
    
    // MARK: Outlets
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var joinName: UITextField!
    @IBOutlet weak var joinCode: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func createGame(sender: AnyObject) {
        createButton.enabled = false
        Game.shared.create(name.text!, completion: {
            self.performSegueWithIdentifier("createQueue", sender: self)
        })
    }
    
    @IBAction func joinGame(sender: AnyObject) {
        joinButton.enabled = false
        Game.shared.join(joinCode.text!, name: joinName.text!, completion: {
            self.performSegueWithIdentifier("joinQueue", sender: self)
        })
    }
}
