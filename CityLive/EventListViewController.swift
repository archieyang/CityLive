//
//  EventListViewController.swift
//  CityLive
//
//  Created by archie on 15/5/13.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EventListViewController: RefreshableTableViewController {

    var events: [JSON]! = [JSON]()
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventCell
        
        let event = events[indexPath.row]
        cell.eventName.text = event["title"].stringValue
        cell.timeLabel.text = event["begin_time"].stringValue
        cell.locLabel.text = event["address"].stringValue
        cell.hostLabel.text = event["owner"]["name"].stringValue
        
        Fetcher.fetchImage(event["image"].stringValue){
            (image, error) in
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? EventCell {
                cell.poserImage.image = image
            }
        }

        
        
        if indexPath.row == self.events.count - 1 {
            loadMore()
        }
        
        return cell
    }
    
    override func initRequest() -> Request? {
        self.events.removeAll(keepCapacity: false)
        
        return loadMoreRequest()
    }
    
    override func loadMoreRequest() -> Request? {
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
        
        params["start"] = self.events.count
        
        return Alamofire.request(.GET, Urls.eventList, parameters: params)
    }
    
    override func addData(json: JSON) {
        if let evts = json["events"].array {
            self.events.extend(evts)
            self.tableView.reloadData()
        }
    }
    
    override func onInitData(json: JSON) {
        if let evts = json["events"].array {
            self.events = evts
            self.tableView.reloadData()
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
