//
//  Artwork.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/12/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    var markerTintColor: UIColor
    let coordinate: CLLocationCoordinate2D
    let identifier: Int
    let type:String
    
    init(title: String, locationName: String, color:UIColor, coordinate: CLLocationCoordinate2D,identifier:Int,type:String) {
        self.title = title
        self.locationName = locationName
        self.markerTintColor = color
        self.coordinate = coordinate
        self.identifier = identifier
        self.type = type
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    
    
    
    
}
