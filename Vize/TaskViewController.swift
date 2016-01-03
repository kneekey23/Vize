//
//  TaskViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//
import Foundation
import UIKit


class TaskViewController: UIViewController {


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
        
        taskDescription.text = taskDescriptionSelected
    }
    
    //adds the ability to get rid of they keyboard for any text field on return.NJK
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
}
