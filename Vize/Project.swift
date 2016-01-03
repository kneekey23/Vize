//
//  Project.swift
//  Vize
//
//  Created by Melissa Hargis on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import Foundation
import Firebase

class Project {
    
    var grade: String = ""
    var title: String = ""
    var description: String = ""
    let ref: Firebase?
    let key: String!
    var prepTasks: [String] = []
    var progressTasks: [String] = []
    var doneTasks : [String] = []
    var tasksToComplete: [String] = []
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        grade = snapshot.value["grade"] as! String
        title = snapshot.value["title"] as! String
        description = snapshot.value["description"] as! String
        ref = snapshot.ref
        prepTasks = snapshot.value["prepTasks"] as! [String]
        progressTasks = snapshot.value["progressTasks"]as! [String]
        doneTasks = snapshot.value["doneTasks"]as! [String]
        tasksToComplete = snapshot.value["tasksLeftToComplete"]as! [String]
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "grade": grade,
            "title": title,
            "description": description,
            "prepTasks" : prepTasks,
            "progressTasks": progressTasks,
            "doneTasks": doneTasks,
            "tasksToComplete": tasksToComplete
        ]
    }
    
    init (grade: String, title: String, description: String, key: String = "", prepTasks: [String],progressTasks: [String], tasksToComplete: [String], doneTasks: [String]) {
        self.grade = grade
        self.title = title
        self.description = description
        self.key = key
        self.prepTasks = prepTasks
        self.progressTasks = progressTasks
        self.tasksToComplete = tasksToComplete
        self.doneTasks = doneTasks
        self.ref = nil
    }
}

