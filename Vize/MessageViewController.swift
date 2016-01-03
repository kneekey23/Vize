//
//  MessageViewController.swift
//  Vize
//
//  Created by Nicki on 1/3/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var chats: [String] = ["Nicki", "Melissa", "Marv"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath)
        
        let person = chats[indexPath.row]
        cell.detailTextLabel?.text = person
        
        return cell
    }

}
