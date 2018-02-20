//
//  FoodBankSelectViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/25/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FoodBankSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title = "Near Me"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 24)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.style = .done


        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
       let cellTitle = cell.viewWithTag(1) as! UILabel
        cellTitle.text = orders.all[indexPath.row].name
        
        
        let cellImage = cell.viewWithTag(3) as! UIImageView
        cellImage.image = UIImage(named:"food")
//
//            let cellTitle = cell.viewWithTag(1) as! UILabel
//
//        let cellInfo = cell.viewWithTag(2) as! UILabel
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.all.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        orders.index = indexPath.row
        self.performSegue(withIdentifier: "SelectToInfo", sender: self)
    }
    

    


}
