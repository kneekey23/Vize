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
import MessageUI
import AdSupport

class CreateAccountViewController: UIViewController, UITextFieldDelegate{
    
     let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com")
    let messageComposer = MessageComposer()
    let adId: String = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
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
                    self.DisplayRewardsAlert()
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
    
    func DisplayRewardsAlert()
    {
        let errorMessage = "Do you want to receive data rewards?"
        
        let alertController = UIAlertController(title: "Data Rewards", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            self.sendSMS()
            self.rewardOnUserRegistration()
            //self.navigationController?.popToRootViewControllerAnimated(true)
        })
        
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            //self.navigationController?.popToRootViewControllerAnimated(true)
        })
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func sendSMS() {
        
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(adId)
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if result == MessageComposeResultCancelled {
            NSLog("Message cancelled")
        }
        else if result == MessageComposeResultSent {
            NSLog("Message sent")
            rewardOnUserRegistration()
        }
        else {
            NSLog("Message failed")
        }
    }
    
    func rewardOnUserRegistration() {
        //        let adId: String = ASIdentifierManager.sharedManager().advertisingIdentifier().UUIDString()
        let bundleId: String = NSBundle.mainBundle().bundleIdentifier!
        let temp: String = "http://aus-api.cloudmi.datami.com/dev/goapi/action/registration/"
        let url: String = temp.stringByAppendingString(bundleId).stringByAppendingString("/")
        var urlWithAdId: String = url.stringByAppendingString(adId)
        NSLog("userRegistration url: %@", urlWithAdId)
        var session: NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithURL(NSURL(string: urlWithAdId)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // handle response
            NSLog("userRegistration resp: %@", data!)
        }).resume()
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
