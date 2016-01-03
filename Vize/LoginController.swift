//
//  ViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController ,UITextFieldDelegate {
    
      let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com")
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    var auth: Bool = false
  
    @IBAction func logIn(sender: AnyObject) {
        
        
        ref.authUser(userName.text, password: password.text) {
            error, authData in
            if error != nil {
                // an error occured while attempting login
                
                self.auth = false
                if(!self.auth){
                    self.DisplayErrorAlert("")
                }
                
                // by default, transition
             
            } else {
                self.auth = true
                self.performSegueWithIdentifier("login", sender: nil)
                // user is logged in, check authData for data
                
             
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     self.navigationController?.setNavigationBarHidden(true, animated: true)
     userName.delegate = self
        password.delegate = self
        //self.tabBarController?.hidesBottomBarWhenPushed = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //adds the ability to get rid of they keyboard for any text field on return.NJK
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
      
        if identifier == "login" {
           return auth
        }else if identifier == "createNew"{
            auth = true
        }
 
        return auth
    }

    func DisplayErrorAlert(var errorMessage: String)
    {
        if(errorMessage.isEmpty){
            errorMessage = "We weren't able to log you in. Did you forget your password? We recommend getting sleep to help with memory loss"
        }
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            //self.navigationController?.popToRootViewControllerAnimated(true)
        })
        alertController.addAction(tryAgainAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

}

