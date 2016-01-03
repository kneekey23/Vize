//
//  TaskViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//
import Foundation
import UIKit


class TaskViewController: UIViewController, UITextViewDelegate {


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
    
    var taskDescriptionSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDescription.delegate = self
        taskDescription.text = taskDescriptionSelected
    }

    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
