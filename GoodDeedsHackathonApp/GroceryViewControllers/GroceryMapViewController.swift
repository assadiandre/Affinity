//
//  GroceryMapViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/12/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Material
import NVActivityIndicatorView
import FirebaseDatabase
import Firebase




class GroceryMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var findingFoodStatusView: UIView!
    @IBOutlet weak var animationView: NVActivityIndicatorView!
    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
    
    let regionRadius: CLLocationDistance = 5000
    let geoCoder = CLGeocoder()
    var artworks: [Artwork] = []
    var coordinates: [CLLocation] = []
    var currentAnim:Artwork?
    
 
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        
        // When you transition from short VC to normal vc
        
        findingFoodStatusView.isHidden = false
        animationView.type = .ballPulse
        animationView.color = UIColor.white
        animationView.startAnimating()
        
        mapView.removeAnnotation(currentAnim!)
        currentAnim?.markerTintColor = UIColor(red:1.0, green:114/255, blue:110/255, alpha:1 )
        mapView.addAnnotation(currentAnim!)
    }
    
    
    
    @objc func removeRequest(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "GroceryMapToStatus", sender: self)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        if bools.allowFindStatusView == false {
            
            animationView.stopAnimating()
            findingFoodStatusView.isHidden = true
            
            mapView.removeAnnotation(currentAnim!)
            currentAnim?.markerTintColor = UIColor.purple
            mapView.addAnnotation(currentAnim!)
        }
        else {
            findingFoodStatusView.isHidden = false
            animationView.type = .ballPulse
            animationView.color = UIColor.white
            animationView.startAnimating()
            
            mapView.removeAnnotation(currentAnim!)
            currentAnim?.markerTintColor = UIColor(red:1.0, green:114/255, blue:110/255, alpha:1 )
            mapView.addAnnotation(currentAnim!)
            
        }
        
    }
    


    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
        
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
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
            let artwork = ( Artwork(title: title,
                                          locationName: description,
                                          color: color,
                                          coordinate: (location.coordinate),
                                          identifier:identifier,type:type) )
            if myLocation == true {
                self.currentAnim = artwork
            }
            self.mapView.addAnnotation(artwork)
            
        }
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
    
        all.currentIndex = Int( view.motionIdentifier! )!
        self.performSegue(withIdentifier: "GroceryMapToGroceryMapInfo", sender: self)
    
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.register(ArtworkMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        navigationController?.navigationBar.barTintColor = UIColor(red: 0.0667, green: 0.698, blue: 0, alpha: 1.0)
        self.title = "Donation Map"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 24)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        
        
        mapView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeRequest))
        tap.cancelsTouchesInView = false
        findingFoodStatusView.addGestureRecognizer(tap)
        

        self.placeMarker(address: current.theUser!.address,title:"Your Location",description:current.theUser!.info, color: UIColor.purple,myLocation: true,identifier: -1,type:"")
        
        
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

        
        }

}














