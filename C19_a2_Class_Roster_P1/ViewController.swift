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
    
    var personArray = [Person]()            // An array to hold off the student objects after they are created by makePeopleArray
    var teacherArray = [Person]()           // An array that holds teacher objects
    var cellIdentifier = "myCell"           // Name for the cell in the table view
    var numberOfSection = 2
    
    
    @IBOutlet var appTableView: UITableView!
    // Getting the path to the plist files. The plist contains an Array<Dictionary>
    let studentPlistPath = NSBundle.mainBundle().pathForResource("studentRoster", ofType: "plist")
    let teacherPlistPath = NSBundle.mainBundle().pathForResource("teacherRoster", ofType: "plist")
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // student and teacher roster is the plist variable wich can be opperated on.  It's an NSArray
        let studentRoster = NSArray(contentsOfFile: self.studentPlistPath)
        let teacherRoster = NSArray(contentsOfFile: self.teacherPlistPath)
        
        self.personArray = makePeopleArray(studentRoster)
        self.teacherArray = makePeopleArray(teacherRoster)
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        // Reloads the tabelView after it comes back from the DetailViewController
        //println(newPerson?.firstName)
        //println(self.testNum)
        self.appTableView.reloadData()
    }

    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return numberOfSection
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        // Student section
        if section == 0
        {
            return personArray.count
        }
        // Teacher section
        else
        {
            return teacherArray.count
        }
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String!
    {
        // Adds the titles for the section header
        if section == 0
        {
            return "Students"
        }
        else
        {
            return "Teachers"
        }
    }
    
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        
        // Student cell information
        if indexPath.section == 0
        {
        
            cell.textLabel.text = personArray[indexPath.row].fullName(false)
            cell.detailTextLabel.text = personArray[indexPath.row].studentId
            cell.imageView.image = personArray[indexPath.row].image
            return cell
        }
        // Teacher cell infromation
        else
        {
            cell.textLabel.text = teacherArray[indexPath.row].fullName(false)
            cell.detailTextLabel.text = teacherArray[indexPath.row].studentId
            cell.imageView.image = teacherArray[indexPath.row].image
            return cell
        }
    
    

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        if segue.identifier == "segueToDetailView"
        {
            var detailViewController = segue.destinationViewController as DetailViewController
            var personIndex = appTableView.indexPathForSelectedRow().row
            var selectedPerson: Person?
            
            // Checks to see what type of person objects is going to passed in the segue.  Its
            // Either a student or teacher person object
            
            if appTableView.indexPathForSelectedRow().section == 0
            {
                selectedPerson = self.personArray[personIndex]
            }
            
            else
            {
                selectedPerson = self.teacherArray[personIndex]
            }
            // Passes the person object by referance to the detailViewController
            detailViewController.selectedPerson = selectedPerson
        }
        
    
        
    }
    
    @IBAction func exitToRootViewController(segue: UIStoryboardSegue)
    {
        var sourceViewController = segue.sourceViewController as AddPersonViewController
        
        var newPerson = Person(studentId: sourceViewController.idNumberTextField.text, firstName: sourceViewController.firstNameTextField.text, lastName: sourceViewController.lastNameTextField.text, role: sourceViewController.roleTextField.text)
        newPerson.image = sourceViewController.profileImage.image
        
        if newPerson.role == "teacher"
        {
            self.teacherArray.append(newPerson)
        }
        else if newPerson.role == "student"
        {
            self.personArray.append(newPerson)
        }
        
        
    }
    
    
    func makePeopleArray(rosterArray: NSArray) -> Array<Person>
    {
        // This function takes in an Array<dictionary>.  The Creats an Array<Person> and each person object
        // is initalized with an Id number, First name and Last name.
        
        var people = [Person]()

        for name in rosterArray
        {
            var newPerson:Person = Person(studentId: name["id"] as String, firstName: name["firstName"] as String, lastName: name["lastName"] as String, role: name["role"] as String)
            if newPerson.role == "teacher"
            {
                newPerson.image = UIImage(named: "blank-darth-vader")
            }
            else
            {
                newPerson.image = UIImage(named: "blank-storm-trooper")
            }
            people.append(newPerson)
        }
        
        return people
    
    }
    

    
    
}

