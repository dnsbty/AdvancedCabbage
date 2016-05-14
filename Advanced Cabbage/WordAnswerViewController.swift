//
//  WordAnswerViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/12/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class WordAnswerViewController : UIViewController {
    @IBOutlet weak var answerWord: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func submitAnswer(sender: AnyObject) {
        submitButton.enabled = false
        Game.shared.submitAnswer(answerWord.text!, completion: {
            Game.shared.currentRound += 1
            
            if Game.shared.currentRound == Game.shared.numPlayers + 20 {
                self.performSegueWithIdentifier("gameOver", sender: self)
            } else {
                self.performSegueWithIdentifier("nextRound", sender: self)
            }
        })
    }
}
