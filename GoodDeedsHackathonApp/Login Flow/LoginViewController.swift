//
//  LoginViewController.swift
//  GoodDeedsHackathonApp
//
//  Created by Andre Assadi on 1/10/18.
//  Copyright © 2018 Nathan Baker. All rights reserved.
//
import FirebaseDatabase
import UIKit
import FirebaseAuth
import NVActivityIndicatorView

struct current {
    static var theUser:User?
}



class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var animationView: NVActivityIndicatorView!
    var touchedAlready = false

    
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        emailField.delegate = self
        passwordField.delegate = self

        // Adds gesture recognizer to view so that the keyboard is removed
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        

    }

    @objc func dismissKeyboard() {
        view.endEditing(true) // removes keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {textField.resignFirstResponder() }
        
        return true
    }

    @IBAction func clickHereTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginToChooseType", sender: self) // performs a segue from the login to a new account
    }
    
    @IBAction func typedEmail(_ sender: Any) {
    }
    
    @IBAction func typedPassword(_ sender: Any) {

    }
    
    
    func fetchUserData(_ UID:String,theButton:UIButton) {
        
        
       let ref = Database.database().reference().child("Users/\(UID)")
        ref.observeSingleEvent(of: .value) { snapshot in
            current.theUser = User(snapshot: snapshot)
            theButton.titleLabel?.alpha = 1
            self.animationView.isHidden = true
            self.touchedAlready = false
            
            
            if current.theUser!.type == "groceryStore" {
                self.performSegue(withIdentifier: "LoginToGroceryMenu", sender: self) // Goes to grocery menu
            }
            else {
                self.performSegue(withIdentifier: "LoginToFoodBankMenu", sender: self) // Goes to food bank menu
            }
            
            
        }
        
        
        
    }
    
    
    
    @IBAction func clickContinue(_ sender: UIButton) {
        
            if emailField.text != "" && passwordField.text != "" && self.touchedAlready == false {
                
                sender.titleLabel?.alpha = 0
                self.touchedAlready = true
                self.animationView.type = .ballPulse
                self.animationView.color = UIColor.white
                self.animationView.startAnimating()
                self.animationView.isHidden = false
            
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                if user != nil {
                    self.fetchUserData((user!.uid), theButton: sender)
                }
                else {
                    sender.titleLabel?.alpha = 1
                    self.animationView.isHidden = true
                    if let myError = error?.localizedDescription {
                        self.alert.title = "Uh Oh"
                        self.alert.message = myError
                        self.present(self.alert, animated: true, completion: nil)
                        self.touchedAlready = false
                    }
                    else {
                        self.alert.title = "Uh Oh"
                        self.alert.message = "Something went wrong. Please try again."
                        self.present(self.alert, animated: true, completion: nil)
                        self.touchedAlready = false
                    }
                }
            })
            
            
        }
        else if emailField.text == "" && passwordField.text == "" {
            
            alert.title = "Uh Oh"
            alert.message = "Please complete all of the fields."
            self.present(alert, animated: true, completion: nil)

            
            
            
        }

        
        
        
        
    }
    

}
