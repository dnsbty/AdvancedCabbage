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
    
    @IBAction func submitAnswer(sender: AnyObject) {
        self.performSegueWithIdentifier("nextRound", sender: self)
    }
}
