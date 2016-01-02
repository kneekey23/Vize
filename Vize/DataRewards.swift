//
//  DataRewards.swift
//  Vize
//
//  Created by Melissa Hargis on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import SystemConfiguration
import CoreTelephony

// MyViewController.m

func sendSMS() {
    var controller: MFMessageComposeViewController = MFMessageComposeViewController()
    if MFMessageComposeViewController.canSendText() {
        var recipients: [AnyObject] = ["+17023816992"]
        var adId: String = ASIdentifierManager.sharedManager().advertisingIdentifier().UUIDString()
        controller.body = adId
        controller.recipients = recipients
        controller.messageComposeDelegate = self
        self.presentModalViewController(controller, animated: true)
    }
}

func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
    self.dismissModalViewControllerAnimated(true)
    if result == .Cancelled {
        NSLog("Message cancelled")
    }
    else if result == .Sent {
        NSLog("Message sent")
    }
    else {
        NSLog("Message failed")
    }
    
}

func rewardOnUserRegistration() {
    var adId: String = ASIdentifierManager.sharedManager().advertisingIdentifier().UUIDString()
    var bundleId: String = NSBundle.mainBundle().bundleIdentifier()
    var temp: String = "http://aus-api.cloudmi.datami.com/dev/goapi/action/registration/"
    var url: String = temp.stringByAppendingString(bundleId).stringByAppendingString("/")
    var urlWithAdId: String = url.stringByAppendingString(adId)
    NSLog("userRegistration url: %@", urlWithAdId)
    var session: NSURLSession = NSURLSession.sharedSession()
    session.dataTaskWithURL(NSURL(string: urlWithAdId)!, completionHandler: {(data: NSData, response: NSURLResponse, error: NSError) -> Void in
        // handle response
        NSLog("userRegistration resp: %@", data)
    }).resume()
}

func rewardOnUserTransaction() {
    var adId: String = ASIdentifierManager.sharedManager().advertisingIdentifier().UUIDString()
    var bundleId: String = NSBundle.mainBundle().bundleIdentifier()
    var temp: String = "http://aus-api.cloudmi.datami.com/dev/goapi/action/callToAction/"
    var url: String = temp.stringByAppendingString(bundleId).stringByAppendingString("/")
    var urlWithAdId: String = url.stringByAppendingString(adId)
    NSLog("callToAction url: %@", urlWithAdId)
    var session: NSURLSession = NSURLSession.sharedSession()
    session.dataTaskWithURL(NSURL(string: urlWithAdId)!, completionHandler: {(data: NSData, response: NSURLResponse, error: NSError) -> Void in
        // handle response
        NSLog("callToAction resp: %@", data)
    }).resume()
}