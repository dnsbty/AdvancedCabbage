//
//  AnswerViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/14/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class AnswerViewController : UIViewController {
    
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.getNextWord({ word in
            if word.inUse {
                
                // if the word is in use, set up the timer to check again every 2.5 seconds
                self.timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(self.checkNextWord), userInfo: nil, repeats: true)
            } else {
                
                // if the word isn't in use, go to the next screen
                if Game.shared.currentRound % 2 == 1 {
                    self.performSegueWithIdentifier("toDrawing", sender: self)
                } else {
                    self.performSegueWithIdentifier("toWord", sender: self)
                }
            }
        })
    }
    
    func checkNextWord() {
        
        // get the next word from the server
        Game.shared.getNextWord({ word in
            
            // if it's no longer in use, stop the timer and go to the next screen
            if !word.inUse {
                self.timer.invalidate()
                if Game.shared.currentRound % 2 == 1 {
                    self.performSegueWithIdentifier("toDrawing", sender: self)
                } else {
                    self.performSegueWithIdentifier("toWord", sender: self)
                }
            }
        })
    }
    
}
