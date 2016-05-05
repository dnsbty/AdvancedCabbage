//
//  Player.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import Foundation

class Player {
    var name: String
    var id: Int
    var creator: Bool
    
    init(name : String, id: Int, creator: Bool) {
        self.name = name
        self.id = id
        self.creator = creator
    }
}
