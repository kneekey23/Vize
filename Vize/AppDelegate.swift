//
//  AppDelegate.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
//import BridgeHeader.h

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedStateChage:", name: SDSTATE_CHANGE_NOTIF, object: nil);
        SmiSdk.getAppSDAuth("dmi-att-hack-68fcfe5e708bfaa3806c4888912ea6f2ecb446fd", userId: "vizeapp", showSDMessage : true)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func receivedStateChage(notif: NSNotification) {
        let sr: SmiResult = notif.object as! SmiResult;
        NSLog("receivedStateChage, sdState: %ld", sr.sdState.rawValue);
        if (sr.sdState == SdState.SD_AVAILABLE) {
            // use sponsored logo to display sponsored message
        }
        else if sr.sdState == SdState.SD_NOT_AVAILABLE {
            // non sponsored connection
            NSLog("receivedStateChage, sdReason %ld", sr.sdReason.rawValue);
        }
        else if sr.sdState == SdState.SD_WIFI {
            // wifi connection
        }
        
    }


}

