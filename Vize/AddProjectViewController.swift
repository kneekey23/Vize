//
//  AddProjectViewController.swift
//  Vize
//
//  Created by Nicki on 1/3/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit
import Firebase

class AddProjectViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    var projectTopic: String?
    var projectCount: String?
    @IBOutlet weak var projectTitle: UITextField!
    @IBOutlet weak var descriptionOfTask: UITextView!
    @IBOutlet weak var grade: UITextField!
    @IBAction func closeModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addProject(sender: AnyObject) {
        
        let saveRef = Firebase(url:"https://brilliant-inferno-3353.firebaseio.com/projects")
        let newProject = ["title": self.projectTitle.text!, "description": self.descriptionOfTask.text!, "grade": self.grade.text!, "prepTasks": [""], "doneTasks": [""], "progressTasks": [""], "tasksLeftToComplete": [""]]

        
        let projRef = saveRef.childByAppendingPath(projectTopic!).childByAppendingPath(projectCount!)
        
        projRef.setValue(newProject)

        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectTitle.delegate = self
        descriptionOfTask.delegate = self
        grade.delegate = self
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //adds the ability to get rid of they keyboard for any text field on return.NJK
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }

}
