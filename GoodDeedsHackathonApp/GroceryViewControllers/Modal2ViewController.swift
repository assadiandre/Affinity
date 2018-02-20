//
//  Modal2ViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/14/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit

class Modal2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var pickerView1: UIPickerView!
    var poundsTable:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView1.dataSource = self
        pickerView1.delegate = self

        // Do any additional setup after loading the view.
        
        for i in 1 ... 500 {
            poundsTable.append(i)
        }
    }

    @IBAction func nextTouched(_ sender: Any) {
        self.performSegue(withIdentifier: "Modal2ToModal3", sender: self)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return "\(poundsTable[row])lbs"

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return poundsTable.count

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        label1.text = "\(poundsTable[row])lbs"
        confirmValues.pounds = poundsTable[row]

        
    }
    
    



}
