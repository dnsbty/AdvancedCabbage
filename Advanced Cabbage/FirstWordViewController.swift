//
//  FirstWordViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/6/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class FirstWordViewController : UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var word: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func submitWord(sender: AnyObject) {
        Game.shared.submitWord(word.text!, completion: {
            Game.shared.currentRound += 1
            if Game.shared.currentRound == Game.shared.numPlayers {
                self.performSegueWithIdentifier("gameOver", sender: self)
            } else {
                self.performSegueWithIdentifier("nextRound", sender: self)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        word.delegate = self
    }
    
    // MARK: Text Field Delegate Functions
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        submitWord(self)
        return true
    }
}
