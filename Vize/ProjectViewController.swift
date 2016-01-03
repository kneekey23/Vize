//
//  ProjectViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    @IBOutlet weak var projectTableView: UITableView!
    //var featuredRouteList:Array<DDBTableRow>?
    var lastEvaluatedKey:[NSObject : AnyObject]!
    var  doneLoading = false
    
    var needsToRefresh = true

    var projectList: [Project]!
    //var featuredRouteList: [String] = ["Tourist Route", "Lazy Sunday Route"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if projectList == nil {
            projectList = []
        }
        projectTableView.reloadData()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        projectTableView.reloadData()
        if self.needsToRefresh {
           // self.refreshList(true)
            self.needsToRefresh = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("in tableView")
        let cell = tableView.dequeueReusableCellWithIdentifier("projectCell", forIndexPath: indexPath)
        
        // Configure the cell...
            let item = projectList[indexPath.row]
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = "Grade" + item.grade
        
        
        return cell
}

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return false
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("ToProjectBoard", sender: projectTableView.cellForRowAtIndexPath(indexPath))
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
//        if segue.identifier == "ThemedRouteDetailViewController" {
//            let detailViewController = segue.destinationViewController as! ThemedRouteDetailViewController
//            if sender != nil {
//                if (sender!.isKindOfClass(UITableViewCell)) {
//                    let cell = sender as! UITableViewCell
//                    
//                    
//                    let indexPath = self.featuredRouteTable.indexPathForCell(cell)
//                    let tableRow = self.featuredRouteList?[indexPath!.row]
//                    detailViewController.tableRow = tableRow
//                    
//                }
//                
//            }
//        }
        
        
        
    }
}

