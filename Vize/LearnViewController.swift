//
//  LearnViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LearnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func chooseList(sender: AnyObject) {
        
       
        let segmentedControl: UISegmentedControl = sender as! UISegmentedControl
        if segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex) == "Subjects"{
            selectedList = subjects
            listTableView.reloadData()
        }
        else{
            selectedList = careers
            listTableView.reloadData()
        }
    }
    var subjects: [String] = ["Math", "Science", "History", "Computer Science", "Politics", "Art History"]
    
    var careers: [String] = ["Programmer", "Doctor", "Lawyer", "Publicist", "Film/Productions", "Accountant"]
    
    var selectedList: [String]?
    
    override func viewDidLoad() {
         self.tabBarController?.navigationItem.setHidesBackButton(true, animated:true)
        self.tabBarController?.navigationItem.setLeftBarButtonItems(nil, animated: true)
        
        if segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex) == "Subjects"{
           selectedList = subjects
        }
        else{
            selectedList = careers
        }
       
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return (selectedList?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LearnCell", forIndexPath: indexPath)
        
        // Configure the cell...
        if let myTableRows = self.selectedList{
            let item = myTableRows[indexPath.row]
            cell.textLabel?.text = item
        }

        return cell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("ProjectViewControllerSegue", sender: listTableView.cellForRowAtIndexPath(indexPath))
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "ProjectViewControllerSegue" {
            let projectViewController = segue.destinationViewController as! ProjectViewController
            
            //make call to db to load list of projects and populate a project array based off what they selected
            //to figure out what they selected user below code with sender to grab if they selected "math" or "lawyer" and send to db to get all projects under that category or subject
            if sender != nil {
                if (sender!.isKindOfClass(UITableViewCell)) {
                   let cell = sender as! UITableViewCell
                    
                    let indexPath = self.listTableView.indexPathForCell(cell)
                   let selectedSubjectOrCategory = self.selectedList?[indexPath!.row]
                    
                //send selectedSubjectOrCategory to db to get correct project list and popuale. then set it equal to a variable on next view controller.
//                    projectViewController.projectList = //projects that came back from db here.
//                    
               }
                
            }
        }
        
        if segue.identifier == "logOut"{
            let loginVC = segue.destinationViewController as! LoginController
            loginVC.hidesBottomBarWhenPushed = true
        }
        
        
        
    }
    
}
