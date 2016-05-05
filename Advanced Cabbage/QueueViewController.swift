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
    
    @IBOutlet weak var joinCode: UILabel!
    @IBOutlet weak var playerList: UITextView!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func startGame(sender: AnyObject) {
        
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinCode.text = Game.shared.code
        updatePlayerList()
        timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(QueueViewController.checkPlayerUpdates), userInfo: nil, repeats: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        timer.invalidate()
    }
    
    // MARK: Check for updates to player list
    
    func checkPlayerUpdates() {
        print("Checking for updates")
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
