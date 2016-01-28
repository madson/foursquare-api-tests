//
//  PlacesViewController.swift
//  Nearby Places
//
//  Created by Madson Cardoso on 1/27/16.
//  Copyright © 2016 Madson Cardoso. All rights reserved.
//

import UIKit
import CoreLocation

class PlacesViewController: UITableViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBAction func refreshAction(sender: AnyObject?) {
        
        Places.sharedInstance.loadFromInternet({ (success, error) -> Void in
            
            if success {
                self.tableView.reloadData()
            }
            else {
                print(error)
            }
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.clearsSelectionOnViewWillAppear = true
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - CoreLocation delegates

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.requestLocation()
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.isEmpty {
            return
        }

        Device.sharedInstance.location = locations.last!
        
        refreshAction(nil)
    }
    
    // MARK: - TableView delegates
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Places.sharedInstance.list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell1")!
        
        configureCell(cell, forIndexPath: indexPath)
        
        return cell
    }
    
    // MARK: - Helpers
    
    func configureCell(cell: UITableViewCell, forIndexPath indexPath: NSIndexPath) {
        let place = Places.sharedInstance.list[indexPath.row]
        
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.hereNow
        
        if let iconURL = place.categoryIconURL {
            cell.imageView?.setImageWithURL(iconURL, placeholderImage: UIImage(named: "default_bg_44"))
        }
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            let place = Places.sharedInstance.list[indexPath.row]
            
            if let controller = segue.destinationViewController as? DetailsViewController {
                controller.selectedPlace = place
            }
        }
    }

}
