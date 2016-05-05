//
//  QueueViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class QueueViewController : UIViewController {
    
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
        print("View loaded")
        joinCode.text = Game.shared.code
    }
}
