//
//  SelectedContentViewController.swift
//  CityLive
//
//  Created by archie on 15/4/26.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SelectedContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topPoster: UIImageView!
    
    var event: JSON!
    var pageIndex: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = event["title"].stringValue
    }
    
    override func viewWillAppear(animated: Bool) {
        Fetcher.fetchImage(event["image"].stringValue) {
            (image, error) in 
            self.topPoster.image = image
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventDetail" {
            if let destination = segue.destinationViewController as? EventDetailViewController {
                destination.eventJson = event
                destination.posterImage = topPoster.image
                destination.hidesBottomBarWhenPushed = true
            }
        }
    }

}


