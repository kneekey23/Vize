//
//  SurveyViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit

class SurveyViewController: UIViewController{
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let LVC = segue.destinationViewController as! MainViewController
        LVC.navigationItem.hidesBackButton = true
    }
}
