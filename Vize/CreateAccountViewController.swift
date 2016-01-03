//
//  CreateAccountViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountViewController: UIViewController{
    
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         if segue.identifier == "ToSurveySegue"{
            
            //create account in db
            
         }
         else{
            let LVC = segue.destinationViewController as! MainViewController
            LVC.navigationItem.hidesBackButton = true
        }
        
     
    }
}
