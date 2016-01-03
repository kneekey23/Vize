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
    var auth: Bool = false
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var school: UITextField!
    @IBOutlet weak var userRole: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createAccount(sender: AnyObject) {
        
        ref.createUser(userName.text!, password: password.text!,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    self.DisplayErrorAlert("")
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                    self.auth = true
                    
                    let saveRef = Firebase(url:"https://brilliant-inferno-3353.firebaseio.com/userData")
                    let userData = ["name": self.fullName.text!, "nameOfSchool": self.school.text!, "points": "0", "tasks": [], "role": self.userRole.text!]
                    saveRef.childByAppendingPath(uid).setValue(userData)
                    
                     self.performSegueWithIdentifier("createAccountSuccess", sender: nil)
                    
                }
        })
        
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

        let LVC = segue.destinationViewController as! MainViewController
        //LVC.tabBarController?.
     
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        
        
        return auth
    }
    
    //adds the ability to get rid of they keyboard for any text field on return.NJK
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    func DisplayErrorAlert(var errorMessage: String)
    {
        if(errorMessage.isEmpty){
            errorMessage = "We weren't able to create an account for you. Please try again."
        }
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            //self.navigationController?.popToRootViewControllerAnimated(true)
        })
        alertController.addAction(tryAgainAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
}
