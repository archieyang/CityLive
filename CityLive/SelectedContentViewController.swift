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
        Alamofire.request(.GET, event["image"].stringValue).validate().responseImage{
            (_, _, image, error) in
            
            self.topPoster.image = image
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventDetail" {
            if let destination = segue.destinationViewController as? EventDetailViewController {
                destination.eventJson = event
                destination.poster = topPoster.image
            }
        }
    }

}

extension Alamofire.Request {
    class func imageResourceSerializer() -> Serializer {
        return {
            request, response, data in
            
            if data == nil {
                return (nil, nil)
            }
            
            let image = UIImage(data:data!)
            
            return (image, nil)
        }
    }
    
    func responseImage (completionHandler: (NSURLRequest, NSHTTPURLResponse?, UIImage?, NSError?) -> Void) -> Self {
        return response(serializer: Request.imageResourceSerializer(), completionHandler: {
            (request, response, image, error) in
            
            completionHandler(request, response, image as? UIImage, error)
        })
    }
}
