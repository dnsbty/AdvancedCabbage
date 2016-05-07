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
    var word: String?
    var drawingFilename: String?
    
    init(creator: Int, drawingFilename: String) {
        self.creator = creator
        self.isDrawing = true
        self.word = nil
        self.drawingFilename = drawingFilename
    }
    
    init(creator: Int, word: String) {
        self.creator = creator
        self.isDrawing = false
        self.word = word
        self.drawingFilename = nil
    }
}
