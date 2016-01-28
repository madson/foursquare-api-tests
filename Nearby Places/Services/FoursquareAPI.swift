//
//  Session.swift
//  Nearby Places
//
//  Created by Madson Cardoso on 1/28/16.
//  Copyright © 2016 Madson Cardoso. All rights reserved.
//

import UIKit

let API_URL = "https://api.foursquare.com"
let CLIENT_ID = "NUVZBMY2QT0RDM2W1FVDMOYMX23QGTPOMGUO255YHJQBIOHG"
let CLIENT_SECRET = "F5EG4GT2VQZY5SNCETJRYL0YO3XLV5DZVTQ2GVLQNEXMWBAF"
let CLIENT_VERSION = "20200101"

class FoursquareAPI : AFHTTPSessionManager {
    
    static let sharedInstance = FoursquareAPI()
    
    init() {
        let url = NSURL(string: API_URL)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        super.init(baseURL: url, sessionConfiguration: config)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.requestSerializer = AFJSONRequestSerializer()
    }
    
    // MARK: - Helpers
    
    class func defaultParams() -> [String: AnyObject] {
        var params = [String: AnyObject]()
        
        params["client_id"] = CLIENT_ID
        params["client_secret"] = CLIENT_SECRET
        params["v"] = CLIENT_VERSION
        
        return params
    }
}
