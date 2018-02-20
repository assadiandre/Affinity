//
//  Modal3ViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/14/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit

class Modal3ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate {
    
    
    @IBOutlet weak var typesOfFoods: UITextField!
    @IBOutlet weak var additionalNotes: UITextView!
    @IBOutlet weak var textScrollViews: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typesOfFoods.delegate = self
        additionalNotes.delegate = self
        textScrollViews.delegate = self
        
        textScrollViews.isScrollEnabled = false
        typesOfFoods.paddingLeft = 5
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextTouched(_ sender: Any) {
        self.performSegue(withIdentifier: "Modal3ToModal4", sender: self)
        confirmValues.foodTypes = typesOfFoods.text!
        confirmValues.notes = additionalNotes.text!
    }

    @objc func dismissKeyboard() {
        textScrollViews.setContentOffset(CGPoint(x: 0, y: 0), animated: false) // sets the scrollviews position to the top automatically
        textScrollViews.isScrollEnabled = false // enables or disables scrolling
        view.endEditing(true) // removes keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textScrollViews.setContentOffset(CGPoint(x: 0, y: 0), animated: false) // sets the
        textScrollViews.isScrollEnabled = false
        textField.resignFirstResponder() // closes keyboard on return key touch
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textScrollViews.setContentOffset(CGPoint(x: 0, y: 0), animated: false) // sets the
            textScrollViews.isScrollEnabled = false
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textScrollViews.isScrollEnabled = true
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textScrollViews.isScrollEnabled = true
        return true
    }
    
    
    
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
