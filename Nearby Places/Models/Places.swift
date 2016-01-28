//
//  Places.swift
//  Nearby Places
//
//  Created by Madson Cardoso on 1/27/16.
//  Copyright © 2016 Madson Cardoso. All rights reserved.
//

import UIKit
import CoreLocation

extension CLLocation {
    
    func commaSeparatedDescription() -> String {
        
        let lat = self.coordinate.latitude
        let lon = self.coordinate.longitude
        
        return "\(lat),\(lon)"
    }

}

class Places: NSObject {
    
    static let sharedInstance = Places()
    
    var list = [Place]()
    
    func loadFromInternet(result: (success: Bool, error: NSError?) -> Void) {
        
        var params = FoursquareAPI.defaultParams()
        params["ll"] = Device.sharedInstance.location.commaSeparatedDescription()
        
        FoursquareAPI.sharedInstance.GET("/v2/venues/search", parameters: params, progress:nil,
            success: { (task, json) -> Void in
                
                guard
                    let dict = json as? [String: AnyObject],
                    let response = dict["response"] as? [String: AnyObject],
                    let venues = response["venues"] as? [[String: AnyObject]]
                    else {
                        return
                }
                
                self.list = self.parseJSONList(venues)
                result(success: true, error: nil)
            },
            failure: { (task, error) -> Void in
                
                print(error)
                result(success: false, error: error)
            })
    }
    
    func parseJSONList(nodes: [[String: AnyObject]]) -> [Place] {
        var array = [Place]()
        
        for node in nodes {
            let place = Place(json: node)
            
            array.append(place)
        }
        
        return array
    }
    
}
