//
//  NewAccountViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/10/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//

import UIKit
import FirebaseAuth

extension UITextField { // extension of UITextField to add padding to textfields
    
    var paddingLeft: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    var paddingRight: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

class NewAccountViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var fields: [UITextField]!
    @IBOutlet var fieldNames: [UILabel]!
    @IBOutlet weak var fieldScroll: UIScrollView!
    @IBOutlet weak var info: UITextView!
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        

        configureForBuisness()
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))

        
        
        for currentField in fields {
            currentField.delegate = self
            currentField.paddingLeft = 5
        }
        info.delegate = self
        
        self.title = "New Account"

        // Adds gesture recognizer to view so that the keyboard is removed
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        fieldScroll.isScrollEnabled = true
 
    }
    
    func configureForBuisness() {
        fieldNames[2].text = "Business Name"
        fieldNames[8].text = "Info"
    }

    
    @objc func dismissKeyboard() {
        fieldScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true) // sets the scrollviews position to the top automatically
        view.endEditing(true) // removes keyboard
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        fieldScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            fieldScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true) // sets the
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    var allowDone = true
    

    
    
    

    @IBAction func donePressed(_ sender: Any) {
        for currentField in fields {
            if currentField.text == "" {
                self.allowDone = false
            }
        }
        
        if allowDone == true {
            
            Auth.auth().createUser(withEmail: fields[0].text!, password: fields[1].text!, completion: { (user, error) in
                if user != nil {
                    User(UID: user!.uid, name: self.fields[2].text!, address: self.fields[3].text! + " " + self.fields[6].text! + " " + self.fields[5].text! + " " + self.fields[4].text!, phoneNumber: self.fields[7].text!, info: self.info.text!, score: 0, email: self.fields[0].text!, type: chosenState.result)
                    self.dismiss(animated: true)
                }
                else {
                    if let myError = error?.localizedDescription {
                        
                        self.alert.title = "Uh Oh"
                        self.alert.message = myError
                        self.present(self.alert, animated: true, completion: nil)
                    }
                    else {
                        self.alert.title = "Uh Oh"
                        self.alert.message = "Something went wrong, please try again."
                        self.present(self.alert, animated: true, completion: nil)
                    }
                }
            })
            
            

        }
        else {
            alert.title = "Uh Oh"
            alert.message = "Please complete all of the fields to continue."
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    

}
