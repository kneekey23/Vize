//
//  PointsRedemptionViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import CoreTelephony
import MessageUI
import AdSupport

class PointsRedemptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBAction func redeemPoints(sender: AnyObject) {
        //check number of points and add up points of things selected
        rewardOnUserTransaction()
        
        //display error if not enough points
        //redeem points by subtracting points from their amount in the db and emailing reward info
        
    }
    
    let messageComposer = MessageComposer()
    var prizeList: [String] = ["30 Mb of Data", "$10 to Chipotle", "$10 to Starbucks", "$10 to iTunes", "$10 to Subway", "$10 to Pizza Hut"]
    
    var checked: [Bool] = [false, false, false, false, false, false]
    
    @IBAction func closeModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return prizeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("redemptionCell", forIndexPath: indexPath)
        
        // Configure the cell...
 
            let item = prizeList[indexPath.row]
            cell.textLabel?.text = item
            
            if let myDetailTextLabel = cell.detailTextLabel {
                myDetailTextLabel.text = "10 Points"
            }
        
        if checked[indexPath.row] == false {
            
            cell.accessoryType = .None
        }
        else if checked[indexPath.row] == true {
            
            cell.accessoryType = .Checkmark
        }

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark
            {
                cell.accessoryType = .None
                checked[indexPath.row] = false
            }
            else
            {
                cell.accessoryType = .Checkmark
                checked[indexPath.row] = true
            }
        }
    }
    
    func sendSMS(adId: String) {
        
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
        NSLog(String(result.rawValue))
//        if result == Cancelled {
//        }
//            else if result == .Sent {
//                NSLog("Message sent")
//            }
//            else {
//                NSLog("Message failed")
//            }
        
    }
    
    func rewardOnUserRegistration() {
        let adId: String = "myAdId" //ASIdentifierManager.sharedManager().advertisingIdentifier().UUIDString()
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
    
    func rewardOnUserTransaction() {
        print("in rewardOnUserTransaction")
        let adId: String = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        print(adId)
        let bundleId: String = NSBundle.mainBundle().bundleIdentifier!
        print(bundleId)
        let temp: String = "http://aus-api.cloudmi.datami.com/dev/goapi/action/callToAction/"
        let url: String = temp.stringByAppendingString(bundleId).stringByAppendingString("/")
        let urlWithAdId: String = url.stringByAppendingString(adId)
        print(urlWithAdId)
        NSLog("callToAction url: %@", urlWithAdId)
        let session: NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithURL(NSURL(string: urlWithAdId)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // handle response
            NSLog("callToAction resp: %@", data!)
            self.sendSMS(adId)
        }).resume()
    }

}
