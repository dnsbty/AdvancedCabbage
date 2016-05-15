//
//  ViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 4/22/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var results : [ResultCard]?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "createGame" {
            let destinationVC = segue.destinationViewController as! NewGameViewController
            destinationVC.type = "create"
        } else if segue.identifier == "joinGame" {
            let destinationVC = segue.destinationViewController as! NewGameViewController
            destinationVC.type = "join"
        } else if segue.identifier == "showResults" {
            let destinationVC = segue.destinationViewController as! ResultViewController
            destinationVC.cards = results!
        }
    }

    @IBAction func showResults(sender: AnyObject) {
        Game.shared.generateResultCards(Game.shared.playerID, completion: { results in
            self.results = results
            self.performSegueWithIdentifier("showResults", sender: self)
        })
    }
}

