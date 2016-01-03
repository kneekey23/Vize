//
//  ContentViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class ContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var button: UIButton?
    var projectTopic: String?
    var dbHead: String?
    var projectIndex: String?
    
    @IBAction func addTask(sender: AnyObject) {
        
        button = sender as? UIButton
        
        let addTaskField: UITextField = UITextField(frame: CGRect(x: button!.frame.minX, y: button!.frame.minY, width: button!.frame.width, height: button!.frame.height))
        addTaskField.placeholder = "Enter Task Description"
        addTaskField.delegate = self
        addTaskField.font = UIFont.systemFontOfSize(15)
        addTaskField.borderStyle = UITextBorderStyle.RoundedRect
        addTaskField.autocorrectionType = UITextAutocorrectionType.No
        addTaskField.keyboardType = UIKeyboardType.Default
        addTaskField.returnKeyType = UIReturnKeyType.Done
        addTaskField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        addTaskField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.view.addSubview(addTaskField)
        
        
    }
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //call to database to save task
        let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com/projects/" + projectTopic!)
        
        switch labelText{
            
        case "Project Preparation": dbHead = "prepTasks"
        case "Tasks in Progress" : dbHead = "progressTasks"
        case "Tasks To Complete": dbHead = "tasksLeftToComplete"
        case "Done": dbHead = "doneTasks"
        default: dbHead = ""
            
        }
        
        let task = ["title": textField.text!]
        
        ref.childByAppendingPath(projectTopic!).childByAppendingPath(projectIndex).childByAppendingPath(dbHead!).updateChildValues(task)
        
        //uitext field back to button
        button?.frame = CGRect(x: textField.frame.minX, y: textField.frame.minY, width: textField.frame.width, height: textField.frame.height)
        
        self.view.addSubview(button!)
        textField.hidden = true
        
        projectTaskTableView.reloadData()
        textField.resignFirstResponder();
        return true;
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
