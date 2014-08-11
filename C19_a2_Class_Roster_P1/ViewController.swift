//
//  ViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/5/14.
//  Copyright (c) 2014 David Fry. All rights reserved.


// Canvas API to get all students in C19 https://canvas.instructure.com/api/v1/courses/868751/students
// Canvas API to get student object https://canvas.instructure.com/api/v1/users/3987826/profile (/users/:user_id/profile)
// API Key: 7~CKAvoX6pZT2oeBQOWFtKzI6f9et2XdunrLMYvO5IIWNyoVvBwLoZLkpV45MFNZaK


import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var personArray = [Person]()
    
    // Getting the path to the plist file. The plist contains an Array<Dictionary>
    let plistPath = NSBundle.mainBundle().pathForResource("studentRoster", ofType: "plist")
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // student roster is the plist variable wich can be opperated on.  It's an NSArray
        let studentRoster = NSArray(contentsOfFile: self.plistPath)
        
        makePersonsArray(studentRoster)
        
        
    }


    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return personArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "myCell")
            cell.textLabel.text = personArray[indexPath.row].fullName(false)
            cell.detailTextLabel.text = personArray[indexPath.row].studentId!
        
        
            return cell
    }
    
    func makePersonsArray(rosterArray: NSArray)
    {
        // This function takes in an Array<dictionary>.  The Creats an Array<Person> and each person object
        // is initalized with an Id number, First name and Last name.
        
        for name in rosterArray
        {
            var newPerson:Person = Person(studentId: name["id"] as String, firstName: name["firstName"] as String, lastName: name["lastName"] as String)
            personArray.append(newPerson)
        }
    
    }
    
    
}

