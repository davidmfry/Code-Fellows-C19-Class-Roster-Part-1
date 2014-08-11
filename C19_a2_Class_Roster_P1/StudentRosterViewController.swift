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

class StudentRosterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CanvasAPIControllerProtocol
{
    
    @IBOutlet weak var appTableView: UITableView!
    
    var api = CanvasAPIController()
    
    var personArray = [Person]()
    var tableData = []
    
    let cellIdentifier = "studentCell"

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.api.delegate = self
        api.getStudentList()
    }


    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return personArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        let person = self.personArray[indexPath.row]
        cell.textLabel.text = person.name
        cell.detailTextLabel.text = person.studentId
        cell.imageView.image = UIImage(named: "blank-pic")
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var rowData = self.tableData[indexPath.row] as NSDictionary
        
        var name = rowData["name"] as String
        var studentId: Int = rowData["id"] as Int
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        var detailsViewCOntroller = segue.destinationViewController as DetailsViewController
        var personIndex = appTableView.indexPathForSelectedRow().row
        var selectedPerson = self.personArray[personIndex]
        detailsViewCOntroller.person = selectedPerson
    }
   
    
    func didReceiveAPIResults(results: NSArray)
    {
        // This is the protocol function from the Canvas API Controller
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = results
            self.makePersonsArray(results)
            self.appTableView!.reloadData()
        })
    }
    
        
    func makePersonsArray(rosterArray: NSArray)
    {
        // This function takes in an Array<dictionary>.  The Creats an Array<Person> and each person object
        // is initalized with an Id number, First name and Last name.
        
        for item in rosterArray
        {
            var blank_image = UIImage(named: "blank-pic")
            var id = item["id"] as Int
            
            var newPerson:Person = Person(studentId:"\(id)", name: item["name"] as String, image:blank_image as UIImage)
            personArray.append(newPerson)
        }
    
    }
    

    
    
    
}

