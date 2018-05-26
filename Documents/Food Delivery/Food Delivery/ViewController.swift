//
//  ViewController.swift
//  Food Delivery
//
//  Created by Andre Assadi on 5/20/18.
//  Copyright © 2018 BHSAppDevClub. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

struct restaurant {
    static var data:[[String:Any]] = [[:]]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    var allData: [[String : Any]] = [[:]]
    var menuShowing = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 1
        setupNavigationBarItems()
        tableView.allowsSelection = false
        loadRestaurantData()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        self.view.addGestureRecognizer(gesture)

        
    }
    
    @IBAction func clickDeliver(_ sender: UIButton){
        menuLeadingConstraint.constant = -200
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.performSegue(withIdentifier: "mainToDeliver", sender: self)
    }
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        if menuShowing {
            menuLeadingConstraint.constant = -200
        }
        else {
            menuLeadingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
    }
    
    func setupNavigationBarItems() {
        navigationItem.rightBarButtonItem!.target = self
        navigationItem.rightBarButtonItem!.action = #selector(goToSearchView)
    }
    
    @objc func closeMenu(){
        menuLeadingConstraint.constant = -200
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = false
    }
    
    @objc func goToSearchView() {
        self.performSegue(withIdentifier: "mainToSearch", sender: self)
    }
    
    
    @objc func goToDesView() {
        self.performSegue(withIdentifier: "mainToOp", sender: self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellCard")!
        
        if indexPath.row > 0 {
            let titleView = cell.viewWithTag(1) as! UILabel
            let distanceView = cell.viewWithTag(2) as! UILabel
            let imageView = cell.viewWithTag(3) as! CustomImageView
            let backgroundView = cell.viewWithTag(4)!
            backgroundView.layer.shadowOpacity = 0.5
            backgroundView.layer.shadowRadius = 1
            backgroundView.layer.shadowOffset = CGSize(width: -1, height: 1)
            imageView.clipsToBounds = true
            imageView.loadImageUsingUrlString(urlString:  allData[indexPath.row - 1]["imageUrl"] as! String)
            titleView.text = allData[indexPath.row - 1]["name"] as? String
            let distance =   round( (allData[indexPath.row - 1]["distance"] as! Double) * 0.0621371 )/100
            distanceView.text =  "\(distance) mi"
            cell.contentView.backgroundColor = UIColor(red:240/255, green:240/255, blue:240/255, alpha:1)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "Deliver")!
            
            let desButton = cell.viewWithTag(1) as! UIButton
            desButton.addTarget(self, action: #selector(goToDesView), for: UIControlEvents.touchUpInside)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if allData.count > 1 {
            allData.remove(at: 0)
            count = allData.count + 1
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        else {
            return 300
        }
    }
    
    func loadRestaurantData() {
        Firestore.firestore().collection("places").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.allData.append(data)
                }
            }
            restaurant.data = self.allData
            self.tableView.reloadData()
        }
    }
    
    



}






