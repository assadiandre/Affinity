//
//  ViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Nathan Baker on 1/7/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit

struct chosenState {
    
    static var result = "" // Global variable that is used for checking what type the user selected
}

class ChooseTypeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.style = .done
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.0667, green: 0.698, blue: 0, alpha: 1.0)
        self.title = "Affinity"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 24)!,NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    @objc func cancel() {
        self.dismiss(animated: true)
    }
    
    @IBAction func GroceryStore(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ChooseTypeToNewAccount", sender: self)
        chosenState.result = "groceryStore"
    }
    
    @IBAction func FoodBank(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ChooseTypeToNewAccount", sender: self)
        chosenState.result = "foodBank"
    }
    


}

