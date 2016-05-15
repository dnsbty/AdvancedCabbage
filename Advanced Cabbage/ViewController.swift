//
//  ViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 4/22/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! NewGameViewController
        if segue.identifier == "createGame" {
            destinationVC.type = "create"
        } else {
            destinationVC.type = "join"
        }
    }

}

