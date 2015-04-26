//
//  SelectedController.swift
//  CityLive
//
//  Created by archie on 15/4/26.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class SelectedController: UIPageViewController, UIPageViewControllerDataSource{

    var pageViewController: UIPageViewController!
    
    var titles: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        titles = ["Page 1", "Page 2", "Page 3", "Page 4", "Page 5"]
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SelectedPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        var initVC = self.contentViewControllerAtIndex(0) as SelectedContentViewController
        
        var viewControllers = [initVC]
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 200)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
    }
    
    func contentViewControllerAtIndex(index: Int) -> SelectedContentViewController {
        var cvc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectedContentViewController") as! SelectedContentViewController
        cvc.titleText = titles[index]
        cvc.pageIndex = index
        return cvc
    }
    
    
    // MARK:UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! SelectedContentViewController
        
        var index = vc.pageIndex as Int
    
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        --index
        
        
        return contentViewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! SelectedContentViewController
        
        var index = vc.pageIndex as Int
        
        if index == NSNotFound || index == titles.count - 1 {
            return nil
        }
        
        ++index
        
        return contentViewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return titles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
