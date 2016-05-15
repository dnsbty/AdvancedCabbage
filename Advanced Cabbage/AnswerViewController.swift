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
    var word : Word?
    var image : UIImage?
    
    @IBOutlet weak var hurryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.getNextWord({ (word, wordID) in
            self.word = word
            if word.inUse || word.numAnswers != Game.shared.currentRound - 1 {
                
                // if the word is in use, set up the timer to check again every 2.5 seconds
                self.timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(self.checkNextWord), userInfo: nil, repeats: true)
                let playerUsing = (Game.shared.playerID + 1) % Game.shared.numPlayers
                self.hurryLabel.text = "Tell \(Game.shared.players[playerUsing].name) to hurry up"
            } else {
                Game.shared.claimWord(wordID, completion: { claimed in
                    if Game.shared.currentRound % 2 == 1 {
                        self.performSegueWithIdentifier("toDrawing", sender: self)
                    } else {
                        Game.shared.getDrawing(self.word!.answers.last!.drawingFilename!, completion: { image in
                            self.image = image
                            self.performSegueWithIdentifier("toWord", sender: self)
                        })
                    }
                })
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDrawing" {
            let destinationVC = segue.destinationViewController as! DrawingViewController
            destinationVC.word = self.word
        } else if segue.identifier == "toWord" {
            let destinationVC = segue.destinationViewController as! WordAnswerViewController
            destinationVC.image = self.image
        }
    }
    
    func checkNextWord() {
        
        // get the next word from the server
        Game.shared.getNextWord({ (word, wordID) in
            
            // if it's no longer in use, stop the timer and go to the next screen
            if !word.inUse && word.numAnswers == Game.shared.currentRound - 1 {
                self.word = word
                self.timer.invalidate()
                Game.shared.claimWord(wordID, completion: { claimed in
                    if Game.shared.currentRound % 2 == 1 {
                        self.performSegueWithIdentifier("toDrawing", sender: self)
                    } else {
                        if let fileName = self.word!.answers.last!.drawingFilename {
                            Game.shared.getDrawing(fileName, completion: { image in
                                self.image = image
                                self.performSegueWithIdentifier("toWord", sender: self)
                            })
                        } else {
                            print("Error in drawing filename")
                        }
                    }
                })
            }
        })
    }
    
}
