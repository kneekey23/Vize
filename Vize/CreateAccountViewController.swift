//
//  CreateAccountViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateAccountViewController: UIViewController, UITextFieldDelegate{
    
     let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com")
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var school: UITextField!
    @IBOutlet weak var userRole: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        school.delegate = self
        userRole.delegate = self
        fullName.delegate = self
        userName.delegate = self
        password.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         if segue.identifier == "ToSurveySegue"{
            
            //create account in db
            
            ref.authUser(userName.text!, password:password.text!) {
                error, authData in
                if error != nil {
                    // Something went wrong. :(
                } else {
                    // Authentication just completed successfully :)
                    
                    // The logged in user's unique identifier
                    print(authData.uid)
                    
                    // Create a new user dictionary accessing the user's info
                    // provided by the authData parameter
                    let newUser = [
                        "provider": authData.provider,
                        "displayName": authData.providerData["displayName"] as? NSString as? String
                    ]
                    
                    // Create a child path with a key set to the uid underneath the "users" node
                    // This creates a URL path like the following:
                    //  - https://<YOUR-FIREBASE-APP>.firebaseio.com/users/<uid>
                    self.ref.childByAppendingPath("users")
                        .childByAppendingPath(authData.uid).setValue(newUser)
                    
                    let saveRef = Firebase(url:"https://brilliant-inferno-3353.firebaseio.com/userData")
                    let userData = ["name": self.fullName.text!, "nameOfSchool": self.school.text!, "points": "0", "tasks": [], "role": self.userRole.text!]
                    saveRef.childByAppendingPath(authData.uid).setValue(userData)
                }
            }
            
         }
         else{
            let LVC = segue.destinationViewController as! MainViewController
            LVC.navigationItem.hidesBackButton = true
        }
        
     
    }
    
    //adds the ability to get rid of they keyboard for any text field on return.NJK
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
}
