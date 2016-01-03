//
//  TaskViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//
import Foundation
import UIKit
import Firebase


class TaskViewController: UIViewController, UITextViewDelegate {
      let ref = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com")

    @IBOutlet weak var doneTaskButton: UIButton!

    @IBOutlet weak var grabTaskButton: UIButton!
    @IBAction func markAsComplete(sender: AnyObject) {
        
    }

    @IBAction func editTask(sender: AnyObject) {
        
    }
    
    @IBAction func grabTask(sender: AnyObject) {
    
    }
    
    @IBOutlet weak var taskDescription: UITextView!
    
    @IBAction func closeTask(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var userRole: String?
    
    var taskDescriptionSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDescription.delegate = self
        taskDescription.text = taskDescriptionSelected
        
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                print(authData)
                
                let userUrl = Firebase(url: "https://brilliant-inferno-3353.firebaseio.com/userData/" + authData.uid)
                
                
                userUrl.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    if let role = snapshot.value["role"] as? String {
                        self.userRole = role
                        
                        switch self.userRole!
                        {
                        case "student": self.taskDescription.editable = false
                        case "teacher": self.taskDescription.editable = true
                        default: self.taskDescription.editable = false
                        }
                    }
                    
                })
                
            } else {
                // No user is signed in
            }
        })
    }

    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
