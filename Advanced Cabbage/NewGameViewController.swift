//
//  NewGameViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit
import Alamofire

class NewGameViewController : UIViewController, UITextFieldDelegate {
    
    var type: String?
    
    // MARK: Outlets
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var joinName: UITextField!
    @IBOutlet weak var joinCode: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = NSUserDefaults.standardUserDefaults().objectForKey("name") as? String
        if type == "create" {
            name.text = userName
            name.delegate = self
            name.becomeFirstResponder()
        } else {
            joinName.text = userName
            joinName.delegate = self
            joinCode.delegate = self
            if userName != nil {
                joinCode.becomeFirstResponder()
            } else {
                joinName.becomeFirstResponder()
            }
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
        Game.shared.join(joinCode.text!.uppercaseString, name: joinName.text!, completion: {
            self.performSegueWithIdentifier("joinQueue", sender: self)
        })
        NSUserDefaults.standardUserDefaults().setObject(joinName.text!, forKey: "name")
    }
    
    // MARK: Text Field Delegate Functions
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField.tag {
        case 1: // create game name
            createGame(self)
            break
        case 2: // join game name
            joinCode.becomeFirstResponder()
            break
        case 3: // join game code
            joinGame(self)
            break
        default:
            return false
        }
        return true
    }
}
