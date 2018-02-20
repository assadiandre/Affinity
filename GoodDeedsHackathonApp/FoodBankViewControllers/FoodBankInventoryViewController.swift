//
//  FoodBankInventoryViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/28/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit

class FoodBankInventoryViewController: UIViewController, UITableViewDelegate,    UITextFieldDelegate
, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Inventory"
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let cellField = cell.viewWithTag(1) as! UITextField
        cellField.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    @IBAction func tapConfirm(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        orders.index = indexPath.row
//    }
    
    
    
    
    

}
