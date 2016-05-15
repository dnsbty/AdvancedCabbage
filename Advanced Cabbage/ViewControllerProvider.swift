//
//  ViewControllerProvider.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/14/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

protocol ViewControllerProvider {
    var initialViewController: UIViewController { get }
    func viewControllerAtIndex(index: Int) -> UIViewController?
}
