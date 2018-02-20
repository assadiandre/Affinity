//
//  FoodBankInfoViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/25/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import FirebaseStorage
import MapKit

class FoodBankOrderInfoViewController: UIViewController {
    
    @IBOutlet var statusValues : [UILabel]!
    //time
    //location
    //pounds
    //types of foods
    //additional notes
    //status
    
    
    var venueLat:NSString = "37.8445977"
    var venueLng:NSString = "-122.2424093"
    var venueName = "Destination"
    
    func openMapForPlace() {
        
        let lat1 : NSString = self.venueLat
        let lng1 : NSString = self.venueLng
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.venueName)"
        mapItem.openInMaps(launchOptions: options)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Info"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 24)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        
        
        self.statusValues[2].text = "\(orders.all[orders.index].weight as! Int)lbs"
        self.statusValues[3].text = orders.all[orders.index].foodType as! String
        self.statusValues[4].text = orders.all[orders.index].notes as! String
        self.statusValues[5].text = orders.all[orders.index].status as! String

        // Do any additional setup after loading the view.
    }

    @IBAction func claimPressed(_ sender: UIButton) {
        
        openMapForPlace()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
