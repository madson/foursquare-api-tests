//
//  Device.swift
//  Nearby Places
//
//  Created by Madson Cardoso on 1/28/16.
//  Copyright © 2016 Madson Cardoso. All rights reserved.
//

import UIKit
import CoreLocation

class Device {
    
    static let sharedInstance = Device()
    
    var location: CLLocation
    
    init () {
        location = CLLocation(latitude: -23.579451, longitude: -46.648672)
    }
}

