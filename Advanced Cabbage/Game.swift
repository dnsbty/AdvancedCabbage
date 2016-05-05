//
//  Game.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import Foundation
import Alamofire

class Game {
    
    // MARK: Properties
    
    var id = ""
    var code = ""
    var created = NSDate()
    var started = false
    var numPlayers = 0
    var players = []
    var words = []
    
    // MARK: Singleton
    
    class var shared : Game {
        struct Singleton {
            static let instance = Game()
        }
        
        return Singleton.instance
    }
    
    private init() {
        // This guarantees that code outside this file can't instantiate a ScriptureRenderer.
        // So others must use the sharedRenderer singleton.
    }
    
    // MARK: Create Game
    
    func create(name: String) {
        Alamofire.request(APIRouter.CreateGame(name))
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
    
    func join(code: String, name: String) {
        Alamofire.request(APIRouter.JoinGame(code, name))
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
