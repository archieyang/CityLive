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

class EventListViewController: UITableViewController {

    var events: [JSON]! = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
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
                    self.events.removeAll(keepCapacity: true)
                    self.events.extend(evts)
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.events.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventCell
        
        cell.eventName.text = self.events[indexPath.row]["title"].stringValue
         

        return cell
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
