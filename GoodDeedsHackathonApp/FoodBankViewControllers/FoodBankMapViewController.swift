//
//  FoodBankMapViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/25/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase


struct orders {
    static var all:[Order] = []
    static var index = 0
}

class FoodBankMapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!

    var myLocation:Artwork?
    let regionRadius: CLLocationDistance = 5000
    let geoCoder = CLGeocoder()


    
    @objc func pressNearMe(sender:UIBarButtonItem) -> Void {
        
        self.performSegue(withIdentifier: "FoodBankMapToSelect", sender: self)
        
    }
    
    
    
    func placeMarker(address:String,title:String,description:String,color:UIColor,myLocation:Bool,identifier:Int,type:String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    
                    return
            }
            let artwork = Artwork(title: title,
                                    locationName: description,
                                    color: color,
                                    coordinate: (location.coordinate),
                                    identifier:identifier, type:type)
            
            if myLocation == true {
                self.myLocation = artwork
            }
            
            self.mapView.addAnnotation(artwork)
            
        }
    }
    
    
    func loadOthers(completion: @escaping( Bool )->(Void) ) {
        
        let ref = Database.database().reference().child("Users")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            
            let allUsersKeys = snapshot.value as! [String: AnyObject ]
            
            for (key, _) in allUsersKeys {
                
                let newRef = Database.database().reference().child("Users/\(key)")
                
                newRef.observeSingleEvent(of: .value) { snapshot in
                    
                    if snapshot.key != current.theUser!.UID {
                        all.users.append( User(snapshot: snapshot) )
                        completion(true)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    
    func loadOthersOrders( ) {
        
        let ref = Database.database().reference().child("Orders")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            
            let allUsersKeys = snapshot.value as! [String: AnyObject ]
            
            for (key, _) in allUsersKeys {
                
                let newRef = Database.database().reference().child("Orders/\(key)")
                
                newRef.observeSingleEvent(of: .value) { snapshot in
                    
                    orders.all.append( Order(snapshot: snapshot) )
                    
                }
                
            }
            
        }
        
    }
    
    
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        
        all.currentIndex = Int( view.motionIdentifier! )!
        self.performSegue(withIdentifier: "FoodBankMapToInfo", sender: self)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let ref = Database.database().reference()
        ref.child("Orders").observe(.childAdded, with: { snapshot in
            
            print(snapshot)
            
        })
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.style = .done
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0667, green: 0.698, blue: 0, alpha: 1.0)
        self.title = "Donation Map"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 24)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Near Me", style: .done, target: self, action: #selector(pressNearMe))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0667, green: 0.698, blue: 0, alpha: 1.0)
        
        mapView.delegate = self
        
        mapView.register(ArtworkMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        self.placeMarker(address: current.theUser!.address,title:"Your Location",description:current.theUser!.info, color: UIColor.purple,myLocation: true,identifier: -1,type:"")
        
        loadOthers { (DidFinish) -> (Void) in
            for i in 0 ..< all.users.count {
                self.placeMarker(address: all.users[i].address,title:all.users[i].name,description:all.users[i].info, color: UIColor.red,myLocation: false,identifier: i,type:all.users[i].type)
            }
        }
        loadOthersOrders( )
        
        
        self.placeMarker(address: "3068 Claremont Ave Berkeley CA",title: "Star Grocery",description:"Small grocery shop on Claremont Ave", color: UIColor.red ,myLocation: false,identifier: -1,type:"groceryStore")
        
        self.placeMarker(address: "2642 Ashby Ave Berkeley CA",title: "Ashby Marketplace",description:"Small grocery shop on Ashby Ave", color: UIColor.red ,myLocation: false,identifier: -1,type:"groceryStore")
        
        self.placeMarker(address: "3000 Telegraph Ave Berkeley CA",title: "Whole Foods Market",description:"Hopefully all natural produce ;)", color: UIColor.red ,myLocation: false,identifier: -1,type:"groceryStore")
        
        self.placeMarker(address: "1524 20th St San Francisco CA",title: "The Good Life Grocery",description:"Organic meats and more", color: UIColor.red ,myLocation: false,identifier: -1,type:"groceryStore")
        
        self.placeMarker(address: "5316 Telegraph Ave Berkeley CA",title: "Telegraph Community Center",description:"Always for the needy", color: UIColor.red ,myLocation: false,identifier: -1,type:"foodBank")
        
        self.placeMarker(address: "3610 San Pablo Ave, Emeryville, CA 94608",title: "Emeryville Citizens Assistance Program - ECAP",description:"Always for the needy", color: UIColor.red ,myLocation: false,identifier: -1,type:"foodBank")
        
        self.placeMarker(address: "114 Montecito Ave, Oakland, CA 94610",title: "St. Paul's Episcopal Church",description:"Always for the needy", color: UIColor.red ,myLocation: false,identifier: -1,type:"foodBank")
        
        
        
        geoCoder.geocodeAddressString(current.theUser!.address) { (placemarks, error) in
            let placemarks = placemarks
            let location = placemarks?.first?.location
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate,
                                                                      self.regionRadius * 2.0, self.regionRadius * 2.0)
            self.mapView.setRegion(coordinateRegion, animated: true)
            //self.centerMapOnLocation(location: location! )
        }


        // Do any additional setup after loading the view.
    }




}
