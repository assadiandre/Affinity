//
//  SearchViewController.swift
//  Food Delivery
//
//  Created by Andre Assadi on 5/20/18.
//  Copyright © 2018 BHSAppDevClub. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x:0, y:0, width:280, height:20))

    
    
    @objc func goBackToMenu() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Search Restaurant"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        let rightNavBarButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(goBackToMenu))
        self.navigationItem.rightBarButtonItem = rightNavBarButton

        
        

        // Do any additional setup after loading the view.
    }



}
