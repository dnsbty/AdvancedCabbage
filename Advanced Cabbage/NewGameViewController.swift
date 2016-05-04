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
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var joinName: UITextField!
    @IBOutlet weak var joinCode: UITextField!
    @IBAction func createGame(sender: AnyObject) {
        Alamofire.request(APIRouter.CreateGame(name.text!))
            .responseJSON { response in
                // check if the response was successful
                guard response.result.isSuccess else {
                    print("Error while creating game: \(response.result.error)")
                    return
                }
                
                // make sure response types are as expected
                guard let responseJSON = response.result.value as? [String: AnyObject] else {
                    print("Invalid game information received when creating game")
                    return
                }
                
                print("Join code: \(responseJSON["code"])")
                print("Game ID: \(responseJSON["_id"])")
        }
    }
    @IBAction func joinGame(sender: AnyObject) {
        Alamofire.request(APIRouter.JoinGame(joinCode.text!, joinName.text!))
            .responseJSON { response in
                // check if the response was successful
                guard response.result.isSuccess else {
                    print("Error while joining game: \(response.result.error)")
                    return
                }
                
                // make sure response types are as expected
                guard let responseJSON = response.result.value as? [String: AnyObject] else {
                    print("Invalid game information received when joining game")
                    return
                }
                
                print("Join code: \(responseJSON["code"])")
                print("Game ID: \(responseJSON["_id"])")
        }
    }
}
