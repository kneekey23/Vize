//
//  RewardsViewController.swift
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

class RewardsViewController: UIViewController{
    let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com")
    let messageComposer = MessageComposer()
    let adId: String = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
    
    @IBOutlet weak var pointCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData)
                
                let userUrl = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com/users/" + authData.uid)
                
                
                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    if let points = snapshot.value["points"] as? String {
                        self.pointCount.text = points
                    }
                    
                })
                
            } else {
                // No user is signed in
            }
        })
        
        DisplayRewardsAlert()
    }
    
    func DisplayRewardsAlert()
    {
        let errorMessage = "Do you want to receive data rewards?"
        
        let alertController = UIAlertController(title: "Data Rewards", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            self.sendSMS()
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
}
