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
    
    var events: [JSON]!
    
    var pageIndes: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        events = [JSON]()
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SelectedPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.translucent = true
        
    }

    override func viewWillAppear(animated: Bool) {
        if events.count != 0 {
            return
        }
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height - (self.parentViewController?.parentViewController as! UITabBarController).tabBar.frame.size.height)
        var params = [String : AnyObject]()
        if let loc = NSUserDefaults.standardUserDefaults().stringForKey(CityTableViewController.Constants.CityDefaultsKey) {
            params = [
                "loc": loc,
                "day_type": "week",
                "type": "all",
                "count": 10
            ]
        } else {
            params = [
                "loc": 108288,//beijng city code
                "day_type": "week",
                "type": "all",
                "count": 10
            ]
        }
        Alamofire.request(.GET, Urls.eventList, parameters: params).responseJSON{
            (_, _, resJson, _) in
            if(resJson != nil) {
                let json = JSON(resJson!)
                
                
                if let evts = json["events"].array {
//                    for var i = 0; i < events.count; ++i {
////                        self.titles.append(events[i]["title"].stringValue)
//                        self.events.append(<#newElement: T#>)
//
//                    }
                    self.events.removeAll(keepCapacity: true)
                    self.events.extend(evts)
                }
                
                var initVC = self.contentViewControllerAtIndex(0) as SelectedContentViewController
                
                var viewControllers = [initVC]
                
                self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
//                
                
                self.addChildViewController(self.pageViewController)
                self.view.addSubview(self.pageViewController.view)
                self.pageViewController.didMoveToParentViewController(self)
                
//                self.navigationController?.navigationBar.translucent = false
                
                
            }
        }
    }
    
    
    func contentViewControllerAtIndex(index: Int) -> SelectedContentViewController {
        var cvc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectedContentViewController") as! SelectedContentViewController
        cvc.event = events[index]
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
        
        if index == NSNotFound || index == events.count - 1 {
            return nil
        }
        
        ++index
        
        return contentViewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return events.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
