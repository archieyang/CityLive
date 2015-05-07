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
    var posterImage: UIImage!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.image = posterImage
        titleLabel.text = eventJson["title"].stringValue
        timeLabel.text = eventJson["begin_time"].stringValue
        addressLabel.text = eventJson["address"].stringValue
        hostLabel.text = eventJson["owner"]["name"].stringValue
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
