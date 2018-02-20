//
//  ArtworkViews.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/14/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import NVActivityIndicatorView
import Foundation
import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    
    
    override var annotation: MKAnnotation? {
        willSet {
            
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = artwork.markerTintColor
            //      glyphText = String(artwork.discipline.first!)
            
            switch artwork.type {
                case "groceryStore":
                    glyphImage = UIImage(named:"shop")
                case "foodBank":
                    glyphImage = UIImage(named:"restaurant")
                case "deliveryMan" :
                    glyphImage = UIImage(named:"car")
                default : break
            }
            
            
            motionIdentifier = String( artwork.identifier )

            //glyphImage = UIImage(named:"restaurant")
            
        }
    }
}
