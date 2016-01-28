//
//  Detail.swift
//  Nearby Places
//
//  Created by Madson Cardoso on 1/28/16.
//  Copyright © 2016 Madson Cardoso. All rights reserved.
//

import UIKit

class DetailsViewController: UITableViewController {
    
    var selectedPlace: Place?
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelHereNow: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    
    override func viewDidLoad() {
        self.navigationItem.title = selectedPlace?.name
        
        labelName.text = selectedPlace?.name
        labelHereNow.text = selectedPlace?.hereNow
        labelAddress.text = selectedPlace?.address
        labelPhone.text = selectedPlace?.phone
    }

}
