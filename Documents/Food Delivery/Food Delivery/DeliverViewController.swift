//
//  DeliverViewController.swift
//  Food Delivery
//
//  Created by Andre Assadi on 5/21/18.
//  Copyright © 2018 BHSAppDevClub. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseFirestore


class DeliverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    var menuShowing = false
    var foundPerson = false
    var allRequests:[[String:String]] = [[:]]
    var tableViewAmount = 2

    @IBAction func clickOrder(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func flipSwitch(sender:UISwitch) {
        loadRequestData()
        foundPerson = true
        tableViewAmount = 4
        tableView.reloadData()
    }
    
    
    func matchRestaurant(_ reqs:[[String:Any]]) {
        
        for restaurant in restaurant.data {
            for i in 0 ..< reqs.count {
                if String(describing: restaurant["id"]) == String(describing: reqs[i]["Restaurant"])  {
                    allRequests.append(
                        [  "Res_Name":restaurant["name"] as! String ,
                           "Res_Distance":String(restaurant["distance"] as! Double ),
                           "Res_Image":restaurant["imageUrl"] as! String,
                           "User_Name": reqs[i]["User_Name"] as! String,
                           "User_Last":reqs[i]["User_Last"] as! String
                        ])
                }
            }
        }
        print(self.allRequests)

        
        
    }
    
    func loadRequestData() {
        var allRequests:[[String:Any]] = [[:]]
        Firestore.firestore().collection("requests_tests").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if allRequests[0].isEmpty {
                        allRequests[0] = data
                    }
                    else {
                       allRequests.append(data)
                    }
                }
            }
            self.matchRestaurant(allRequests)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "AvailableCell")!
        
        if indexPath.row == 0 {
            
            let switchView = cell.viewWithTag(1) as! UISwitch
            switchView.isOn = foundPerson
            switchView.addTarget(self, action: #selector(flipSwitch(sender:)), for: .valueChanged)
            
        }

        
        if foundPerson == true {
            if indexPath.row == 3 {
                cell = tableView.dequeueReusableCell(withIdentifier: "MapCell")!
                let mapView = cell.viewWithTag(1) as! MKMapView
                
                mapView.clipsToBounds = false
                mapView.layer.shadowOpacity = 0.5
                mapView.layer.shadowRadius = 1
                mapView.layer.shadowOffset = CGSize(width:-1,height:1)
                
                let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.8445857, -122.24241189999998)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                mapView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: 37.8445857, longitude: -122.24241189999998)
                mapView.addAnnotation(annotation)
                cell.contentView.backgroundColor = UIColor(red:240/255,green:240/255,blue:240/255,alpha:1)
            }
            else if indexPath.row == 2 {
                cell = tableView.dequeueReusableCell(withIdentifier: "ActiveCell")!
                let imageView = cell.viewWithTag(1) as! UIImageView
                imageView.clipsToBounds = true
                imageView.image = UIImage(named:"food")
                let textView = cell.viewWithTag(2) as! UILabel
                textView.text = "81°c Café"
                let backgroundView = cell.viewWithTag(3)!
                backgroundView.layer.shadowOpacity = 0.5
                backgroundView.layer.shadowRadius = 1
                backgroundView.layer.shadowOffset = CGSize(width:-1,height:1)
                cell.contentView.backgroundColor = UIColor(red:240/255,green:240/255,blue:240/255,alpha:1)
                
            }
        }

        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "ActiveHeader")!
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewAmount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        }
        else if indexPath.row == 1 {
            return 45
        }
        else {
            return 400
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        setupNavigationBarItems()
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 1
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func closeMenu(){
        menuLeadingConstraint.constant = -200
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = false
    }
    
    @objc func openMenu(_ sender: UIBarButtonItem) {
        if menuShowing {
            menuLeadingConstraint.constant = -200
        }
        else {
            menuLeadingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
    }

    
    func setupNavigationBarItems() {
        self.navigationItem.title = "Deliver"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"list"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(openMenu))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"search"), landscapeImagePhone: nil, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
    }

}
