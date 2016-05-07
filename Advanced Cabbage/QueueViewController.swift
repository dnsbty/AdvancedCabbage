//
//  QueueViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class QueueViewController : UIViewController {
    
    var timer = NSTimer()
    
    // MARK: Outlets
    
    @IBOutlet weak var waitingLabel: UILabel!
    @IBOutlet weak var joinCode: UILabel!
    @IBOutlet weak var playerList: UITextView!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func startGame(sender: AnyObject) {
        startButton.enabled = false
        Game.shared.start({
            self.performSegueWithIdentifier("startGame", sender: self)
        })
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display the code so others can join the game
        joinCode.text = Game.shared.code
        
        // show the button or the label depending on if the user is the creator or not
        if Game.shared.players[Game.shared.playerID].creator {
            waitingLabel.hidden = true
        } else {
            startButton.hidden = true
        }
        
        // display the list of players and update it every 2.5 seconds
        updatePlayerList()
        timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(QueueViewController.checkPlayerUpdates), userInfo: nil, repeats: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        timer.invalidate()
    }
    
    // MARK: Check for updates to player list
    
    func checkPlayerUpdates() {
        Game.shared.getPlayers({
            if Game.shared.started {
                self.performSegueWithIdentifier("startGame", sender: self)
            } else {
                self.updatePlayerList()
            }
        })
    }
    
    // MARK: Update the player list
    
    func updatePlayerList() {
        var list = ""
        for index in 0 ..< Game.shared.players.count {
            list += "\(index+1). \(Game.shared.players[index].name)\n"
        }
        playerList.text = list
    }
}
