//
//  EventDetailViewController.swift
//  CityLive
//
//  Created by archie on 15/5/5.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventDetailViewController: UIViewController {
    var eventJson: JSON!
    var poster: UIImage!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var poserImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var host: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        titleLabel.text = eventJson["title"].stringValue
        time.text = eventJson["begin_time"].stringValue
        location.text = eventJson["address"].stringValue
        host.text = eventJson["owner"]["name"].stringValue
        poserImage.image = poster
        eventDescription.text = eventJson["content"].stringValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
