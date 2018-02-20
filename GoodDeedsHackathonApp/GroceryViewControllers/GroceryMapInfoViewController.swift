//
//  GroceryMapInfoViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/13/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit

class GroceryMapInfoViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var impacted: UILabel!
    
    
    @objc func goBack() -> Void {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        
        if all.currentIndex == -1 {
            self.title = current.theUser!.name
            name.text = current.theUser!.name
            address.text = current.theUser!.address
            phoneNumber.text = current.theUser!.phoneNumber
            info.text = current.theUser!.info
            impacted.text = "\(current.theUser!.score) People Impacted"
        }
        else {
            self.title = all.users[all.currentIndex].name
            name.text = all.users[all.currentIndex].name
            address.text = all.users[all.currentIndex].address
            phoneNumber.text = all.users[all.currentIndex].phoneNumber
            info.text = all.users[all.currentIndex].info
            impacted.text = "\(all.users[all.currentIndex].score) People Impacted"
            
        }


        // Do any additional setup after loading the view.
    }

 

}
