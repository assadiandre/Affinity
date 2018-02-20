//
//  User.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/18/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class User {
    
    var UID:String
    var name:String
    var address:String
    var location: CLLocation?
    var phoneNumber:String
    var info:String
    var score:Int
    var email:String
    var type:String
    
    
    func geoCode(address: String?, completion: @escaping(CLLocation)->(Void)) {
        let geoCoder = CLGeocoder()
        var location: CLLocation?
        
        geoCoder.geocodeAddressString(address!) { (placemarks, error) in
            if placemarks != nil {
                location = placemarks!.first!.location!
                completion(location!)
            }
        

        }
    }
    
    
    // new account grocery or food bank
    init(UID:String,name:String,address:String,phoneNumber:String,info:String,score:Int,email:String,type:String ) {
        self.UID = UID
        self.name = name
        self.address = address
        self.location = nil
        self.phoneNumber = phoneNumber
        self.info = info
        self.score = score
        self.email = email
        self.type = type
        geoCode(address: self.address) { location in
            self.location = location
            self.pushToCloud()
        }
    }
    
    // new account driver
//    init(UID:String,name:String,phoneNumber:String,info:String,score:Int,email:String,type:String ) {
//
//        self.UID = UID
//        self.name = name
//        self.phoneNumber = phoneNumber
//        self.info = info
//        self.score = score
//        self.email = email
//        self.type = type
//
//    }

    func pushToCloud() {
        
        let ref = Database.database().reference()
        let currentRef = ref.child("Users/\(self.UID)")
        
        currentRef.child("UID").setValue(self.UID)
        currentRef.child("name").setValue(self.name)
        currentRef.child("phoneNumber").setValue(self.phoneNumber)
        currentRef.child("email").setValue(self.email)
        currentRef.child("locationLongitude").setValue(self.location!.coordinate.longitude)
        currentRef.child("locationLatitude").setValue(self.location!.coordinate.latitude)
        currentRef.child("address").setValue(self.address)
        currentRef.child("score").setValue(self.score)
        currentRef.child("info").setValue(self.info)
        currentRef.child("type").setValue(self.type)
    }
    
//    func pushDriverToCloud() {
//        let ref = Database.database().reference()
//        let currentRef = ref.child("Users/\(self.UID!)")
//
//        currentRef.child("UID").setValue(self.UID!)
//        currentRef.child("name").setValue(self.name!)
//        currentRef.child("phoneNumber").setValue(self.phoneNumber!)
//        currentRef.child("info").setValue(self.info!)
//        currentRef.child("score").setValue(self.info!)
//        currentRef.child("email").setValue(self.email!)
//        currentRef.child("type").setValue(self.type!)
//
//    }
    
    // fetch data given 
    init(snapshot: DataSnapshot) {
        let userDict = snapshot.value as! [String: AnyObject]
        let lattitude = userDict["locationLatitude"] as? CLLocationDegrees
        let longitude = userDict["locationLongitude"] as? CLLocationDegrees
        self.location = CLLocation(latitude: lattitude!, longitude: longitude!)
        self.UID = userDict["UID"] as! String
        self.name = userDict["name"] as! String
        self.address = userDict["address"] as! String
        //self.locationLatitude = locationLatitude
        //self.locationLongitude = locationLongitude
        self.phoneNumber = userDict["phoneNumber"] as! String
        self.info = userDict["info"] as! String
        self.score = userDict["score"]! as! Int
        self.email = userDict["email"] as! String
        self.type = userDict["type"] as! String
    }
    
    
    

    
    
    
    
}
