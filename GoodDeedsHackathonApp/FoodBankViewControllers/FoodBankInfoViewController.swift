//
//  FoodBankInfoViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/27/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit

class FoodBankInfoViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var impacted: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    }
}
