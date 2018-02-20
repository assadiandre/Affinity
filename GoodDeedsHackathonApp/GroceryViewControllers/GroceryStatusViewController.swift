//
//  GroceryStatusViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/15/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GroceryStatusViewController: UIViewController {
    
    
    @IBOutlet var statusValues : [UILabel]!
    //time
    //location
    //pounds
    //types of foods
    //additional notes
    //status
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Status"
        
        
       let ref = Database.database().reference().child("Orders/\(confirmValues.nodeKey)")
        ref.observeSingleEvent(of: .value) { snapshot in
            let statusDict = snapshot.value as! [String: AnyObject]
            
            
            //self.statusValues[0].text = String( statusDict["date"] as! Double )
            //self.statusValues[1].text = statusDict["locationLongitude"] as! String
//            let longitude = statusDict["locationLongitude"] as! String
//            let lattitude = statusDict["locationLattitude"] as! String
            
            
            self.statusValues[2].text = "\(statusDict["weight"] as! Int)lbs"
            self.statusValues[3].text = statusDict["foodType"] as! String
            self.statusValues[4].text = statusDict["notes"] as! String
            self.statusValues[5].text = statusDict["status"] as! String
        }
    }
    
    
    func yesHandler(sender:UIAlertAction) -> Void {
        
        Database.database().reference().child("Orders/\(confirmValues.nodeKey)").removeValue(completionBlock: { (error, refer) in
            if error != nil {
                print(error)
            } else {
                print(refer)
                print("Child Removed Correctly")
            }
        })
        
        bools.allowFindStatusView = false
        navigationController?.popViewController(animated: true)
        
    }


    @IBAction func cancelPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you want to cancel your food drive?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: yesHandler))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}
