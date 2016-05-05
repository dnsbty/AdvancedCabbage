//
//  NewGameViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit
import Alamofire

class NewGameViewController : UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var joinName: UITextField!
    @IBOutlet weak var joinCode: UITextField!
    
    // MARK: Actions
    
    @IBAction func createGame(sender: AnyObject) {
        Game.shared.create(name.text!)
    }
    
    @IBAction func joinGame(sender: AnyObject) {
        Game.shared.join(joinCode.text!, name: joinName.text!)
    }
}
