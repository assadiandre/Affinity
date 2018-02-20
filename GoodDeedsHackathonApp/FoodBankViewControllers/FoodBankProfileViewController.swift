//
//  FoodBankProfileViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/25/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import FirebaseAuth

class FoodBankProfileViewController: UIViewController {
    
    
    @IBOutlet weak var impact: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var info: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        impact.text = "\(current.theUser!.score) People Impacted"
        name.text = "\(current.theUser!.name) "
        address.text = "\(current.theUser!.address) "
        phone.text = "\(current.theUser!.phoneNumber) "
        info.text = "\(current.theUser!.info) "
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0667, green: 0.698, blue: 0, alpha: 1.0)
        self.title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 24)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOut))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Inventory", style: .done, target: self, action: #selector(inventoryClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.style = .done
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func signOut(sender:UIBarButtonItem) -> Void {
        
        try! Auth.auth().signOut()
        
        dismiss(animated: true)
        
    }

    @objc func inventoryClicked(sender:UIBarButtonItem) -> Void {
        
        self.performSegue(withIdentifier: "ProfileToInventory", sender: self)
        
    }



}
