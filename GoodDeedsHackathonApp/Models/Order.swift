//
//  Order.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/14/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import Foundation
import MapKit
import FirebaseDatabase

class Order {
    var status: String!
    var date: Date!
    var date2: Date!
    var location: CLLocation!
    var weight: Int!
    var foodType: String!
    var notes: String?
    var orderID: String!
    var groceryStoreID: String!
    var driverID: Int?
    var shelterID: Int?
    var name:String!
    
    init(name:String,date: Date, date2:Date, location: CLLocation, weight: Int, foodType: String, NOTE: String?, groceryStoreID: String) {
        self.status = "Grocery Store Just Made Order"
        self.date = date
        self.date2 = date2
        self.location = location
        self.weight = weight
        self.foodType = foodType
        if let notes = NOTE {
            self.notes = notes
        }
        self.name = name
        self.groceryStoreID = groceryStoreID
        self.orderID = Database.database().reference().child("Orders").childByAutoId().key
        confirmValues.nodeKey = self.orderID
    }
    
    init(snapshot: DataSnapshot) {
        let orderDict = snapshot.value as! [String: AnyObject]
        self.status = orderDict["status"] as! String
//        self.status = snapshot.value(forKey: "status") as! String
        self.name = orderDict["name"] as! String
        self.weight = orderDict["weight"] as! Int
        self.foodType = orderDict["foodType"] as! String
        self.notes = orderDict["notes"] as! String
        self.orderID = snapshot.key
        self.groceryStoreID = orderDict["groceryStoreID"] as! String
        if let driverID = orderDict["driverID"] as? Int {
            self.driverID = driverID
        }
        if let shelterID = orderDict["shelterID"] as? Int {
            self.shelterID = shelterID
        }
        self.date = Date(timeIntervalSince1970: orderDict["date"] as! TimeInterval)
        self.date2 = Date(timeIntervalSince1970: orderDict["date2"] as! TimeInterval)
        let locationLongitude = orderDict["locationLongitude"] as! CLLocationDegrees
        let locationLattitude = orderDict["locationLattitude"] as! CLLocationDegrees
        self.location = CLLocation(latitude: locationLattitude, longitude: locationLongitude)
    }
    
    func pushToCloud() {
        let ref = Database.database().reference()
        let currentRef = ref.child("Orders/\(self.orderID!)")
        
        currentRef.child("name").setValue(self.name)

        currentRef.child("date").setValue(self.date.timeIntervalSince1970)
        currentRef.child("date2").setValue(self.date2.timeIntervalSince1970)
        currentRef.child("locationLongitude").setValue(self.location.coordinate.longitude)
        currentRef.child("locationLattitude").setValue(self.location.coordinate.latitude)
        currentRef.child("weight").setValue(self.weight)
        currentRef.child("foodType").setValue(self.foodType)
        if let notes = self.notes {
            currentRef.child("notes").setValue(notes)
        }
        currentRef.child("groceryStoreID").setValue(groceryStoreID)
        if let driverID = self.driverID {
            currentRef.child("driverID").setValue(driverID)
        }
        if let shelterID = self.shelterID {
            currentRef.child("shelterID").setValue(shelterID)
        }
        currentRef.child("status").setValue(self.status)
    }
    
    
}
