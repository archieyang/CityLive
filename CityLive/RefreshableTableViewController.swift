//
//  RefreshableTableViewController.swift
//  CityLive
//
//  Created by archie on 15/5/14.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol Refreshable {
    func loadMore() -> Void
    func onData(json: JSON) -> Void
    func addData(json: JSON) -> Void
    func dataCount() -> Int
    
}

class RefreshableTableViewController: UITableViewController, Refreshable{
    
    var isLoadingData = false
    var loadMoreInidicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingMoreFooter: UIView!
    
    @IBAction func refresh(sender: UIRefreshControl) {
        refresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        refresh()
    }

    func refresh() -> Void{
        if isLoadingData {
            if self.refreshControl != nil && self.refreshControl!.refreshing {
                self.refreshControl?.endRefreshing()
                
            }
            return
        }
        
        isLoadingData = true
        loadingMoreFooter.hidden = true
        
        if refreshControl != nil &&  !refreshControl!.refreshing {
            refreshControl?.beginRefreshing()
        }
        
        Alamofire.request(.GET, Urls.cityList).responseJSON {
            (_, _, resJson, _) in

            self.onData(JSON(resJson!))
            
            self.tableView.reloadData()
            if self.refreshControl != nil && self.refreshControl!.refreshing {
                self.refreshControl?.endRefreshing()
                
            }
            self.isLoadingData = false
            self.loadingMoreFooter.hidden = false
        }
    }
    
    func loadMore() {
        if isLoadingData {
            return
        }
        
        isLoadingData = true
        loadMoreInidicator.startAnimating()
        
        
        Alamofire.request(.GET, Urls.cityList, parameters: ["start": dataCount(), "count": 20]).responseJSON {
            (_, _, resJson, _) in
            if resJson != nil {
                self.addData(JSON(resJson!))
            }
            self.isLoadingData = false
            
        }
    }
    
    
    func onData(json: JSON) {
        
    }
    
    func dataCount() -> Int {
        return -1
    }
    
    func addData(json: JSON) {
        
    }

}
