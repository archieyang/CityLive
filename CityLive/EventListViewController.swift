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
import Kingfisher

class EventListViewController: RefreshableTableViewController {

    var events: [JSON]! = [JSON]()
    
    override func viewWillAppear(animated: Bool) {
        if events.count == 0 {
            refresh()
        }
    }
    
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
        cell.poserImage.kf_setImageWithURL(NSURL(string: event["image"].stringValue)!)
        
        
        
        if indexPath.row == self.events.count - 1 {
            loadMore()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showEventDetail", sender: self)
    }
    
    override func initRequest() -> Request? {
        return Alamofire.request(.GET, Urls.eventList, parameters: getBaseParams(startFrom: 0))
    }
    
    override func loadMoreRequest() -> Request? {
        return Alamofire.request(.GET, Urls.eventList, parameters: getBaseParams(startFrom: self.events.count))
    }
    
    
    private func getBaseParams(startFrom start:Int ) -> [String: AnyObject] {
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
        
        params["start"] = start
        
        return params
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
    


    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventDetail" {
            if let destinationVC = segue.destinationViewController  as? EventDetailViewController {
                if let indexPath = self.tableView.indexPathForSelectedRow() {
                    destinationVC.eventJson = events[indexPath.row]
                }
                
            }
        }
    }
    

}
