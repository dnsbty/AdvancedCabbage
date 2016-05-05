//
//  Answer.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/4/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import Foundation

class Answer {
    var creator: Int
    var isDrawing: Bool
    var word: String
    var drawingFilename: String
    
    init(creator: Int, isDrawing: Bool, word: String, drawingFilename: String) {
        self.creator = creator
        self.isDrawing = isDrawing
        self.word = word
        self.drawingFilename = drawingFilename
    }
}
