//
//  LearnViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit

class LearnViewController: UIViewController{
    
    override func viewDidLoad() {
         self.tabBarController?.navigationItem.setHidesBackButton(true, animated:true)
        self.tabBarController?.navigationItem.setLeftBarButtonItems(nil, animated: true)
       
    }
    
}
