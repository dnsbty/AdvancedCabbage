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
    var players = [Player]()
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
    
    func create(name: String, completion: () -> Void) {
        Alamofire.request(APIRouter.CreateGame(name))
            .responseJSON { response in
                // check if the response was successful
                guard response.result.isSuccess else {
                    print("Error while creating game: \(response.result.error)")
                    return
                }
                
                // make sure response types are as expected
                guard let responseJSON = response.result.value as? [String: AnyObject],
                    code = responseJSON["code"] as? String,
                    id = responseJSON["_id"] as? String,
                    numPlayers = responseJSON["numPlayers"] as? Int,
                    players = responseJSON["players"] as? [AnyObject] else {
                        print("Invalid game information received when creating game")
                        return
                }
                
                self.code = code
                self.id = id
                self.numPlayers = numPlayers
                self.parsePlayerList(players)
                
                completion()
        }
    }
    
    // MARK: Join Game
    
    func join(code: String, name: String, completion: () -> Void) {
        Alamofire.request(APIRouter.JoinGame(code, name))
            .responseJSON { response in
                // check if the response was successful
                guard response.result.isSuccess else {
                    print("Error while joining game: \(response.result.error)")
                    return
                }
                
                // make sure response types are as expected
                guard let responseJSON = response.result.value as? [String: AnyObject],
                    code = responseJSON["code"] as? String,
                    id = responseJSON["_id"] as? String,
                    numPlayers = responseJSON["numPlayers"] as? Int,
                    players = responseJSON["players"] as? [AnyObject] else {
                        print("Invalid game information received when joining game")
                        return
                }
                
                self.code = code
                self.id = id
                self.numPlayers = numPlayers
                self.parsePlayerList(players)
                
                completion()
        }
    }
    
    // MARK: Parse a list of players
    
    func parsePlayerList(list: [AnyObject]) {
        
        // iterate through all players in the array
        for index in 0 ..< list.count {
            
            // make sure the player has all expected fields
            guard let id = list[index]["_id"] as? String,
                creator = list[index]["creator"] as? Bool,
                name = list[index]["name"] as? String,
                number = list[index]["number"] as? Int else {
                    print("Invalid player information received")
                    return
            }
            
            // if so create a new player object, and append it to the array
            self.players.append(Player(id: id, creator: creator, name: name, number: number))
        }
    }
}
