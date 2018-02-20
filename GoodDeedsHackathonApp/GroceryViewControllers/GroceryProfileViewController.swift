//
//  GroceryProfileViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/16/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import FirebaseAuth

class GroceryProfileViewController: UIViewController {
    

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

        // Do any additional setup after loading the view.
    }
    
    @objc func signOut(sender:UIBarButtonItem) -> Void {
        
        try! Auth.auth().signOut()
        
        dismiss(animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.0667, green: 0.698, blue: 0, alpha: 1.0)
        self.title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 24)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(signOut))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white

    }

    


}
