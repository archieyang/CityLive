//
//  CityTableViewController.swift
//  CityLive
//
//  Created by archie on 15/4/25.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CityTableViewController: RefreshableTableViewController {
    var data = [City]()
    
    
    var selectedCityId: String = ""
    
    let CityNumPerRequest = 20;
    
//    @IBOutlet weak var loadMoreInidicator: UIActivityIndicatorView!
//    @IBOutlet weak var loadingMoreFooter: UIView!
//    
//    @IBAction func refresh(sender: UIRefreshControl) {
//        refresh()
//    }
    
    // MARK: - Tabitem actions
    
    @IBAction func onFinish(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        NSUserDefaults.standardUserDefaults().setObject(selectedCityId, forKey: Constants.CityDefaultsKey)
    }
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        if let preSelectedCity = NSUserDefaults.standardUserDefaults().stringForKey(Constants.CityDefaultsKey) {
            selectedCityId = preSelectedCity
        }
    }

    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath) as! CityCell
        
        let city = data[indexPath.row]
        
        if city.name != nil {
            cell.cityName?.text = data[indexPath.row].name!
        }
        
        if city.id != nil {
            cell.citySelected.hidden = self.selectedCityId != city.id
        }
        
        if indexPath.row == data.count - 1 {
            loadMore()
        }

        return cell
    }
    
    struct Constants {
        static let CityDefaultsKey = "user-city-key"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if data[indexPath.row].id != nil {
            selectedCityId = data[indexPath.row].id!
            self.tableView.reloadData()
        }
    }

    override func initRequest() -> Request? {
        return Alamofire.request(.GET, Urls.cityList, parameters: ["start": 0, "count": 20])
    }
    
    override func loadMoreRequest() -> Request? {
        return Alamofire.request(.GET, Urls.cityList, parameters: ["start": dataCount(), "count": 20])
    }
    
    
    override func onInitData(json: JSON) {
        self.data = City.JSON2CityList(json["locs"])
        self.tableView.reloadData()
    }
    
    override func addData(json: JSON) {
        self.data.extend(City.JSON2CityList(json["locs"]))
        self.tableView.reloadData()
    }
    
    func dataCount() -> Int {
        return self.data.count
    }
    
    
    
    struct City {
        let parent: String?
        let id: String?
        let habitable: String?
        let name: String?
        let uid: String?
        
        static func JSON2CityList(json: JSON) -> [City] {
            var cities = [City]()
            for cityJSONItem in json.arrayValue {
                cities.append(City(
                    parent: cityJSONItem["parent"].string,
                    id: cityJSONItem["id"].string,
                    habitable: cityJSONItem["habitable"].string,
                    name: cityJSONItem["name"].string,
                    uid: cityJSONItem["uid"].string))
            }
            return cities
        }
    }

}
