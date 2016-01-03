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

class RewardsViewController: UIViewController{
      let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com")
    @IBOutlet weak var pointCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData)
                
                let userUrl = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com/userData/" + authData.uid)
                
                
                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    if let points = snapshot.value["points"] as? String {
                        self.pointCount.text = points
                    }
                    
                })
                
            } else {
                // No user is signed in
            }
        })
    }
    
}
