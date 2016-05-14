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
    var words = [Word]()
    var playerID = 0
    var currentRound = 0
    var currentWord : Word? = nil
    
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
    
    // MARK: Submit word
    func submitWord(word: String, completion: () -> Void) {
        Alamofire.request(APIRouter.SubmitWord(self.id, self.playerID, word))
            .responseJSON { response in
                // check if the response was successful
                guard response.result.isSuccess else {
                    print("Error while submitting word: \(response.result.error)")
                    return
                }
                
                // make sure response types are as expected
                guard let words = response.result.value as? [AnyObject] else {
                    print("Invalid information received when submitting word")
                    return
                }
                
                self.parseWordList(words)
                completion()
        }
    }
    
    // MARK: Get next word
    func getNextWord(completion: (word: Word) -> Void) {
        let wordID = (Game.shared.playerID + Game.shared.currentRound) % Game.shared.numPlayers
        Alamofire.request(APIRouter.GetWord(self.id, wordID))
            .responseJSON { response in
                // check if the response was successful
                guard response.result.isSuccess else {
                    print("Error while submitting word: \(response.result.error)")
                    return
                }
                
                // make sure response types are as expected
                guard let wordData = response.result.value as? [String: AnyObject] else {
                    print("Invalid information received when getting word")
                    return
                }
                
                // parse the word object and save it into the array
                if let word = self.parseWord(wordData) {
                    self.words[wordID] = word
                    completion(word: word)
                }
        }
    }
    
    // MARK: Submit answers
    // MARK: Submit drawing
    
    func submitDrawing(imageData: UIImage, completion: () -> Void) {
        guard let image = UIImageJPEGRepresentation(imageData, 0.5) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        let wordID = (Game.shared.playerID + Game.shared.currentRound) % Game.shared.numPlayers
        
        Alamofire.upload(
            APIRouter.SubmitAnswerDrawing(self.id, wordID),
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(data: image, name: "drawing", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartFormData.appendBodyPart(data: String(self.playerID).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"player")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.validate()
                    upload.responseJSON { response in
                        guard response.result.isSuccess else {
                            print("Error while uploading file: \(response.result.error)")
                            return
                        }
                        
                        completion()
                    }
                case .Failure(let encodingError):
                    print("Encoding error: \(encodingError)")
                }
            }
        )
    }
    
    // MARK: Helpers
    // MARK: Parse a list of players
    
    private func parsePlayerList(list: [AnyObject]) {
        
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
    
    // MARK: Parse a list of words
    
    private func parseWordList(list: [AnyObject]) {
        
        // clear the current word list
        self.words.removeAll()
        
        // iterate through all words in the array
        for index in 0 ..< list.count {
            
            // convert the untyped object to a dictionary
            guard let word = list[index] as? [String: AnyObject] else {
                print("Invalid word list received")
                return
            }
            
            // parse the word and append it to the array
            if let parsed = parseWord(word) {
                self.words.append(parsed)
            }
        }
    }
    
    // MARK: Parse a single word
    
    private func parseWord(wordObject: [String: AnyObject]) -> Word? {
        guard let inUse = wordObject["inUse"] as? Bool,
            word = wordObject["word"] as? String,
            creator = wordObject["creator"] as? Int,
            answerList = wordObject["answers"] as? [AnyObject] else {
                print("Invalid word information received: \(wordObject)")
                return nil
        }
        
        // parse out the answers
        if let answers = parseAnswerList(answerList) {
            return Word(creator: creator, word: word, numAnswers: answers.count, answers: answers, created: created, inUse: inUse)
        }
        
        return nil
    }
    
    // MARK: Parse a list of answers
    
    private func parseAnswerList(list: [AnyObject]) -> [Answer]? {
        var answers = [Answer]()
        
        // iterate through all answers in the list
        for index in 0 ..< list.count {
            
            // make sure the answer has all the expected fields
            guard let isDrawing = list[index]["isDrawing"] as? Bool,
                creator = list[index]["creator"] as? Int else {
                    print("Invalid answer information received")
                    return nil
            }
            
            // get the drawing filename or word depending on what the answer is
            if (isDrawing) {
                guard let drawingFilename = list[index]["drawingFilename"] as? String else {
                    print("Invalid drawing filename received")
                    return nil
                }
                answers.append(Answer(creator: creator, drawingFilename: drawingFilename))
            } else {
                guard let word = list[index]["word"] as? String else {
                    print("Invalid answer word received")
                    return nil
                }
                answers.append(Answer(creator: creator, word: word))
            }
        }
        return answers
    }
}
