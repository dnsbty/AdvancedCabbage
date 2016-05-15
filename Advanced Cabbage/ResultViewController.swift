//
//  ResultViewController.swift
//  Advanced Cabbage
//
//  Created by Dennis Beatty on 5/14/16.
//  Copyright © 2016 Dennis Beatty. All rights reserved.
//

import UIKit

class ResultViewController : UIPageViewController {
    var cards = [ResultCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.setViewControllers([self.initialViewController], direction: .Forward, animated: false, completion: nil)
    }
}

extension ResultViewController : UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? CardViewController, let pageIndex = viewController.pageIndex where pageIndex > 0 {
            return viewControllerAtIndex(pageIndex - 1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? CardViewController, let pageIndex = viewController.pageIndex where pageIndex < cards.count - 1 {
            return viewControllerAtIndex(pageIndex + 1)
        }
        
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return cards.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension ResultViewController: ViewControllerProvider {
    
    var initialViewController: UIViewController {
        return viewControllerAtIndex(0)!
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        
        if let cardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardViewController") as? CardViewController {
            
            cardViewController.pageIndex = index
            cardViewController.result = cards[index]
            
            return cardViewController
        }
        
        return nil
    }
}