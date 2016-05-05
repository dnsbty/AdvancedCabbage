//
//  APIRouter.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import Foundation
import Alamofire

public enum APIRouter: URLRequestConvertible {
    static let baseURLPath = "https://api.advancedcabbage.com"
    
    case CreateGame(String)
    case JoinGame(String, String)
    case GetPlayers(String)
    
    public var URLRequest : NSMutableURLRequest {
        let result : (path: String, method: Alamofire.Method, parameters: [String: AnyObject]?) = {
            switch self {
            case .CreateGame(let name):
                let params = ["name": name]
                return ("/games", .POST, params)
            case .JoinGame(let code, let name):
                let params = ["code": code, "name": name]
                return ("/games/join", .POST, params)
            case .GetPlayers(let id):
                return ("/games/\(id)/players", .GET, nil)
            }
        }()
        
        let URL = NSURL(string: APIRouter.baseURLPath)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        URLRequest.HTTPMethod = result.method.rawValue
        URLRequest.timeoutInterval = NSTimeInterval(10 * 1000)
        
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}
