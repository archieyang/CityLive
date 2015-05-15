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
    func initRequest() -> Request?
    func loadMoreRequest() -> Request?
    func onInitData(json: JSON) -> Void
    func addData(json: JSON) -> Void
    
}

class RefreshableTableViewController: UITableViewController, Refreshable{
    
    var isLoadingData = false
    @IBOutlet var loadMoreInidicator: UIActivityIndicatorView!
    
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
        
        initRequest()?.responseJSON {
            (_, _, resJson, _) in

            self.onInitData(JSON(resJson!))
            
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
        
        
        loadMoreRequest()?.responseJSON {
            (_, _, resJson, _) in
            if resJson != nil {
                self.addData(JSON(resJson!))
            }
            self.isLoadingData = false
            
        }
    }
    
    func initRequest() -> Request? {
        return nil
    }
    
    func loadMoreRequest() -> Request? {
        return nil
    }
    
    func onInitData(json: JSON) {
        
    }
    
    
    func addData(json: JSON) {
        
    }

}
