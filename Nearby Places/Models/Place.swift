//
//  Place.swift
//  Nearby Places
//
//  Created by Madson Cardoso on 1/27/16.
//  Copyright © 2016 Madson Cardoso. All rights reserved.
//

import UIKit
import CoreData

class Place : NSObject {

    var name: String!
    var address: String!
    var phone: String!
    var hereNow: String!
    var categoryIconURL: NSURL?
    
    init(json: [String: AnyObject]) {
        
        super.init()
        
        if let name = json["name"] as? String {
            self.name = name
        }
        
        if let hereNow = json["hereNow"]?["summary"] as? String {
            self.hereNow = hereNow
        }

        if let address = json["location"]?["address"] as? String {
            self.address = address
        }
        
        if let phone = json["contact"]?["formattedPhone"] as? String {
            self.phone = phone
        }

        guard
            let categories = json["categories"] as? [[String: AnyObject]],
            let category = categories.first as [String: AnyObject]?,
            let icon = category["icon"] as? [String: AnyObject],
            let prefix = icon["prefix"] as? String,
            let suffix = icon["suffix"] as? String,
            let url = NSURL(string: "\(prefix)bg_88\(suffix)")
            else {
                return
        }
        
        self.categoryIconURL = url
    }
}
