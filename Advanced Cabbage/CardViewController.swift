//
//  CardViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/14/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class CardViewController : UIViewController {
    
    var pageIndex : Int?
    var result : ResultCard?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (result?.word == nil) {
            Game.shared.getDrawing((result?.drawingFilename)!, completion: { image in
                self.imageView.image = image
                self.imageView.hidden = false
            })
        } else {
            label.text = result?.word
            label.hidden = false
        }
    }
}
