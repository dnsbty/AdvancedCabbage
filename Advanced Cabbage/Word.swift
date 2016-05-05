//
//  Word.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import Foundation

class Word {
    var creator: Int
    var word: String
    var numAnswers: Int
    var answers: [Answer]
    var created: NSDate
    var inUse: Bool
    
    init(creator: Int, word: String, numAnswers: Int, answers: [Answer], created: NSDate, inUse: Bool) {
        self.creator = creator
        self.word = word
        self.numAnswers = numAnswers
        self.answers = answers
        self.created = created
        self.inUse = inUse
    }
}
