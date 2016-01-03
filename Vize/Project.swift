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
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        grade = snapshot.value["grade"] as! String
        title = snapshot.value["title"] as! String
        description = snapshot.value["description"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "grade": grade,
            "title": title,
            "description": description
        ]
    }
    
    init (grade: String, title: String, description: String, key: String = "") {
        self.grade = grade
        self.title = title
        self.description = description
        self.key = key
        self.ref = nil
    }
}

