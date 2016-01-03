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
    var prepTasks: [Task] = []
    var progressTasks: [Task] = []
    var doneTasks : [Task] = []
    var tasksToComplete: [Task] = []
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        grade = snapshot.value["grade"] as! String
        title = snapshot.value["title"] as! String
        description = snapshot.value["description"] as! String
        ref = snapshot.ref
        prepTasks = snapshot.value["prepTasks"] as! [Task]
        progressTasks = snapshot.value["progressTasks"]as! [Task]
        doneTasks = snapshot.value["doneTasks"]as! [Task]
        tasksToComplete = snapshot.value["tasksLeftToComplete"]as! [Task]
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
    
    init (grade: String, title: String, description: String, key: String = "", prepTasks: [Task],progressTasks: [Task], tasksToComplete: [Task], doneTasks: [Task]) {
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

class Task{
    var title: String = ""
    var description: String = ""
    var points: String = ""
    var slot: String = ""
    var user: String = ""
    let ref: Firebase?
    let key: String!
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        title = snapshot.value["title"] as! String
        points = snapshot.value["points"] as! String
        slot = snapshot.value["slot"] as! String
        ref = snapshot.ref
        description = snapshot.value["description"] as! String
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "title": title,
            "description": description,
            "points" : points,
            "slot": slot,
            "user": user
        ]
    }
    
    init (title: String, description: String, key: String = "", points: String, slot: String, user: String, doneTasks: [String]) {
        self.title = title
        self.description = description
        self.key = key
        self.points = points
        self.slot = slot
        self.user = user
        self.ref = nil
    }
    
}

