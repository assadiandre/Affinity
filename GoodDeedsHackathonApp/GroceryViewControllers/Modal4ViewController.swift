//
//  Modal4ViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/14/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase



class Modal4ViewController: UIViewController  {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var pounds: UILabel!
    @IBOutlet weak var foods: UILabel!
    @IBOutlet weak var notes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        time.text = confirmValues.time1 + " - " + confirmValues.time2
        location.text = current.theUser!.address
        pounds.text = "\(confirmValues.pounds)lbs "
        foods.text = confirmValues.foodTypes
        notes.text = confirmValues.notes
        
        // Do any additional setup after loading the view.
    }


    @IBAction func confirmTouched(_ sender: Any) {
        
        
        
            if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
                delegate.interactiveDismiss = false
            }
        
            bools.allowFindStatusView = true

            let currentDate = Date()
            let dayString = date.getDayFormatter.string(from: currentDate)
            let monthString = date.getMonthFormatter.string(from: currentDate)
            let orderDate1 = date.formatter.date(from: "\(monthString) \(dayString), \(confirmValues.time1)")
            let orderDate2 = date.formatter.date(from: "\(monthString) \(dayString), \(confirmValues.time2)")

            

        let newOrder = Order(name:current.theUser!.name, date: orderDate1!, date2: orderDate2! , location: CLLocation(latitude: 321, longitude: 123), weight: confirmValues.pounds, foodType: confirmValues.foodTypes, NOTE: confirmValues.notes, groceryStoreID: current.theUser!.UID)
            newOrder.pushToCloud()


// store all data in firebase
// when open app, drops placemarkers on ALL signed participants
// when an order goes through ALL signed participants are notified
        


    //       let ref = Database.database().reference().child("Orders/-L2vc36Fg3s10XsHTFb5")
    //        ref.observeSingleEvent(of: .value) { snapshot in
    //            var order = Order(snapshot: snapshot)
    //            print(date.formatter.string(from: order.date))
    //            print(date.formatter.string(from: order.date2))
    //        }

            // Goes back to start
            performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
        
    }
    
 
    

}
