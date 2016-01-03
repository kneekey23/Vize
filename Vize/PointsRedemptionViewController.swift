//
//  PointsRedemptionViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit

class PointsRedemptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBAction func redeemPoints(sender: AnyObject) {
        //check number of points and add up points of things selected
        
        //display error if not enough points
        //redeem points by subtracting points from their amount in the db and emailing reward info
    }
    var prizeList: [String] = ["20 Mb of Data", "$10 to Chipotle", "$10 to Starbucks", "$10 to iTunes", "$10 to Subway", "$10 to Pizza Hut"]
    
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
}
