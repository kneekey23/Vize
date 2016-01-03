//
//  ProjectViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    @IBOutlet weak var projectTableView: UITableView!
    var projectTopic: String?
    var lastEvaluatedKey:[NSObject : AnyObject]!
    var  doneLoading = false
    
    var needsToRefresh = true

    var projectList: [Project]!
    
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
        
        if projectList == nil {
            projectList = []
        }
        //projectTableView.reloadData()
        refreshData()
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
    
    func refreshData(){
        
        if projectTopic != nil {
        
        let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com/projects/" + projectTopic!)
        
        // Attach a closure to read the data
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            var projects = [Project]()
            
            for item in snapshot.children {
                let project = Project(snapshot: item as! FDataSnapshot)
                projects.append(project)
            }
            
            for proj in projects {
                print(proj.title)
                print(proj.grade)
                print(proj.description)
            }
            
            //send selectedSubjectOrCategory to db to get correct project list and popuale. then set it equal to a variable on next view controller.
            self.projectList = projects
            
            
        self.projectTableView.reloadData()
            
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("in tableView")
        let cell = tableView.dequeueReusableCellWithIdentifier("projectCell", forIndexPath: indexPath)
        
        // Configure the cell...
            let item = projectList[indexPath.row]
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = "Grade " + item.grade
        
        
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
        if segue.identifier == "ToProjectBoard" {
            let bpvViewController = segue.destinationViewController as! ProjectBoardViewController
            if sender != nil {
                if (sender!.isKindOfClass(UITableViewCell)) {
                    let cell = sender as! UITableViewCell
                    
                    
                    let indexPath = self.projectTableView.indexPathForCell(cell)
                    let tableRow = self.projectList[indexPath!.row]
                    bpvViewController.projectTopic = projectTopic!
                    bpvViewController.progressTasks = tableRow.progressTasks
                    bpvViewController.tasksToComplete = tableRow.tasksToComplete
                    bpvViewController.doneTasks = tableRow.doneTasks
                    bpvViewController.prepTasks = tableRow.prepTasks
                    
                }
                
            }
        }
        
        if segue.identifier == "addProjectSegue"{
              let apViewController = segue.destinationViewController as! AddProjectViewController
            if(projectList != nil){
                apViewController.projectCount = String(projectList.count + 1)
            }
            
                apViewController.projectTopic = projectTopic!
        }
        
        
        
    }
}

