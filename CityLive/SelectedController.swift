//
//  SelectedController.swift
//  CityLive
//
//  Created by archie on 15/4/26.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SelectedController: UIPageViewController, UIPageViewControllerDataSource{

    var pageViewController: UIPageViewController!
    
    var titles: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titles = [String]()
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SelectedPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        self.view.backgroundColor = UIColor.whiteColor()

        
    }
    //TODO: unwrap NSUserDefaults.standardUserDefaults().stringForKey(CityTableViewController.Constants.CityDefaultsKey) not checked
    override func viewWillAppear(animated: Bool) {
        Alamofire.request(.GET, Urls.eventList, parameters: [
            "loc": NSUserDefaults.standardUserDefaults().stringForKey(CityTableViewController.Constants.CityDefaultsKey)!,
            "day_type": "week",
            "type": "all",
            "count": 10]).responseJSON{
            (_, _, resJson, _) in
            if(resJson != nil) {
                let json = JSON(resJson!)
                
                let events = json["events"].array!
                
                for var i = 0; i < events.count; ++i {
                    self.titles.append(events[i]["title"].stringValue)
                }
                
                
                var initVC = self.contentViewControllerAtIndex(0) as SelectedContentViewController
                
                var viewControllers = [initVC]
                
                self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
                
                self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height - (self.parentViewController?.parentViewController as! UITabBarController).tabBar.frame.size.height)
                
                self.addChildViewController(self.pageViewController)
                self.view.addSubview(self.pageViewController.view)
                self.pageViewController.didMoveToParentViewController(self)
                
            }
            println(resJson)
        }
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
