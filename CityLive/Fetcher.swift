//
//  Fetcher.swift
//  CityLive
//
//  Created by archie on 15/5/16.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Alamofire

final class Fetcher {
    class func fetchImage(url: String, callback: (UIImage?, NSError?)->Void) -> Void {
        Alamofire.request(.GET, url).validate().responseImage{
            (_, _, image, error) in
            
            callback(image, error)
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