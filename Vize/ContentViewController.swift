//
//  ContentViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var projectTaskLabel: UILabel!
    @IBOutlet weak var projectTaskTableView: UITableView!
    var pageIndex: Int!
    var labelText: String!
    
    
    var selectedList: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.projectTaskLabel.text = labelText!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return (selectedList?.count)!
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView()
        headerView.backgroundColor = UIColor(hexString: "800000")
        return headerView;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectBoardCell", forIndexPath: indexPath)
        
        // Configure the cell...
        if let myTableRows = self.selectedList{
            let item = myTableRows[indexPath.section]
            cell.textLabel?.text = item
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("showTaskDetails", sender: projectTaskTableView.cellForRowAtIndexPath(indexPath))
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetails" {
            let taskViewController = segue.destinationViewController as! TaskViewController
            if sender != nil {
                if (sender!.isKindOfClass(UITableViewCell)) {
                    let cell = sender as! UITableViewCell
                    
                    
                    let indexPath = self.projectTaskTableView.indexPathForCell(cell)
                    let tableRow = self.selectedList?[indexPath!.row]
                    taskViewController.taskDescriptionSelected = tableRow
                    
                }
                
            }
        }
    }
    

}
