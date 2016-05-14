//
//  AnswerViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/14/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class AnswerViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.getNextWord({ word in
            if Game.shared.currentRound % 2 == 1 {
                self.performSegueWithIdentifier("toDrawing", sender: self)
            } else {
                self.performSegueWithIdentifier("toWord", sender: self)
            }
        })
    }
    
}
