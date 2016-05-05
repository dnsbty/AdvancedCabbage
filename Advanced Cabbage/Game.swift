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
    var playerID = 0
    var currentRound = 0
    
    // MARK: Singleton
    
    class var shared : Game {
        struct Singleton {
            static let instance = Game()
        }
        
        return Singleton.instance
    }
    
    private init() {
        // This guarantees that code outside this file can't instantiate a Game.
        // So others must use the shared singleton.
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
                self.playerID = 0
                
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
                        print(response.result.value)
                        return
                }
                
                self.code = code
                self.id = id
                self.numPlayers = numPlayers
                self.parsePlayerList(players)
                self.playerID = numPlayers - 1
                
                completion()
        }
    }
    
    // MARK: Get player list
    
    func getPlayers(completion: () -> Void) {
        Alamofire.request(APIRouter.GetPlayers(self.id))
            .responseJSON { response in
                // check if the response was successful
                guard response.result.isSuccess else {
                    print("Error while retrieving player list: \(response.result.error)")
                    return
                }
                
                // make sure response types are as expected
                guard let responseJSON = response.result.value as? [String: AnyObject],
                    started = responseJSON["started"] as? Bool,
                    players = responseJSON["players"] as? [AnyObject] else {
                        print("Invalid information received when retrieving player list")
                        return
                }
                
                self.parsePlayerList(players)
                self.numPlayers = self.players.count
                self.started = started
                
                completion()
        }
    }
    
    // MARK: Start Game
    
    func start(completion: () -> Void) {
        Alamofire.request(APIRouter.StartGame(self.id))
            .responseJSON { response in
                // check if the response was successful
                guard response.result.isSuccess else {
                    print("Error while retrieving player list: \(response.result.error)")
                    return
                }
                
                // make sure response types are as expected
                guard let responseJSON = response.result.value as? [String: AnyObject],
                    started = responseJSON["started"] as? Bool else {
                        print("Invalid information received when starting game")
                        return
                }
                
                self.started = started
                completion()
        }
    }
    
    // MARK: Helpers
    // MARK: Parse a list of players
    
    func parsePlayerList(list: [AnyObject]) {
        
        // clear the current player array
        self.players.removeAll()
        
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
