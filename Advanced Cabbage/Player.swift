//
//  Player.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import Foundation

class Player {
    var id: String
    var name: String
    var number: Int
    var creator: Bool
    
    init(id: String, creator: Bool, name: String, number: Int) {
        self.name = name
        self.id = id
        self.creator = creator
        self.number = number
    }
}
