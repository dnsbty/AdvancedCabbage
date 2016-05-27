//
//  ViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 4/22/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKStoreProductViewControllerDelegate {
    
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
    
    func openStoreProductWithiTunesIdentifier(identifier: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        
        let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier ]
        storeViewController.loadProductWithParameters(parameters, completionBlock: {[weak self] (loaded, error) -> Void in
            if loaded {
                self?.presentViewController(storeViewController, animated: true, completion: nil)
            }
            
            })
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

