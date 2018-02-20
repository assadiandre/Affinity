//
//  ModalViewController.swift
//  HalfModalPresentationController
//
//  Created by Martin Normark on 17/01/16.
//  Copyright © 2016 martinnormark. All rights reserved.
//

import UIKit


struct confirmValues  {
    
    static var time1 = ""
    static var time2 = ""
    static var pounds = 0
    static var foodTypes = ""
    static var notes = ""
    static var nodeKey = ""

}


class ModalViewController: UIViewController, HalfModalPresentable, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    let timeTable:[String] = ["12:00 PM","12:30 PM","1:00 PM","1:30 PM","2:00 PM","2:30 PM","3:00 PM","3:30 PM", "4:00 PM", "4:30 PM", "5:00 PM","5:30 PM","6:00 PM","6:30 PM","7:00 PM","7:30 PM","8:00 PM","8:30 PM","9:00 PM","9:30 PM","10:00 PM","10:30 PM","11:00 PM","11:30 PM","12:00 AM", "12:30 AM","1:00 AM","1:30 AM","2:00 AM","2:30 AM","3:00 AM","3:30 AM", "4:00 AM", "4:30 AM", "5:00 AM","5:30 AM","6:00 AM","6:30 AM","7:00 AM","7:30 AM","8:00 AM","8:30 AM","9:00 AM","9:30 AM","10:00 AM","10:00 AM","11:00 AM","11:30 AM"]

    
    @IBAction func cancelModal(_ sender: Any) {
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView1.dataSource = self
        pickerView1.delegate = self
        
        
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "ModalToModal2", sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 2
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0 {
                return timeTable[row]
            }
            else {
                return timeTable[row]
            }
        

        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if component == 0 {
                return timeTable.count
            }
            else {
                return timeTable.count
            }

        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
            if component == 0 {
                label1.text = timeTable[row]
                confirmValues.time1 = timeTable[row]
            }
            else {
                label2.text = timeTable[row]
                confirmValues.time2 = timeTable[row]
            
        }

        
    }
    
    

    
}
