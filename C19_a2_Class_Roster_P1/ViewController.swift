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
    
    var personArray = [Person]()                    // An array to hold off the student objects after they are created by makePeopleArray
    var teacherArray = [Person]()                   // An array that holds teacher objects
    var cellIdentifier = "myCell"                   // Name for the cell in the table view
    var numberOfSection = 2                         // Number of section for the table view
    
    var studentFilePath: String?                    // File path to store the acrhived file for the students array
    var teacherFilePath: String?                    // File path to store the acrhived file for the teachers array
    var studentFileName = "studentList.plist"       // Name for the students array file
    var teacherFileName = "teacherList.plist"       // Name for the teachers array file
    
    
    @IBOutlet var appTableView: UITableView!
    // Getting the path to the plist files. The plist contains an Array<Dictionary>
    let studentPlistPath = NSBundle.mainBundle().pathForResource("studentRoster", ofType: "plist")
    let teacherPlistPath = NSBundle.mainBundle().pathForResource("teacherRoster", ofType: "plist")
    
    
//MARK: #Life Cycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Get the file paths for archiving and unarchiving
        self.studentFilePath = self.findPaths(studentFileName)
        self.teacherFilePath = self.findPaths(teacherFileName)
        
        // student and teacher roster is the plist variable wich can be opperated on.  It's an NSArray
        let studentRoster = NSArray(contentsOfFile: self.studentPlistPath)
        let teacherRoster = NSArray(contentsOfFile: self.teacherPlistPath)
        
        // Creates the student and teacher array, but also Unarchives the objects if they are saved
        self.personArray = makePeopleArray(studentRoster, filePath:self.studentFilePath!)
        self.teacherArray = makePeopleArray(teacherRoster, filePath:self.teacherFilePath!)
        
        //self.findPaths()
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        // Reloads the tabelView after it comes back from the DetailViewController
        self.saveFile(self.personArray, fileName: self.studentFilePath!)
        self.saveFile(self.teacherArray, fileName: self.teacherFilePath!)
        self.appTableView.reloadData()
    }

//MARK: #TableView Methods
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
        
        // Makes the profile images rounded
        cell.imageView.layer.masksToBounds = true
        cell.imageView.layer.cornerRadius = 20.0
        
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
//MARK:  #Navagation Methods
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
    
//MARK: #Custom Methods
    func makePeopleArray(rosterArray: NSArray, filePath:String) -> Array<Person>
    {
        // This function takes in an Array<dictionary>.  The Creats an Array<Person> and each person object
        // is initalized with an Id number, First name and Last name.
        
        var people = [Person]()
        
        if self.checkForFile(filePath) == true
        {
            println("USING Unarchived Object")
            return NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as [Person]
        }
            
        else
        {
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
            println("Creating list")
            println(people)
            self.saveFile(people, fileName: filePath)

            return people
        }
        
        
    
    }
//Mark: #File Methods
    func findPaths(fileName: String) -> String
    {
        // an array of paths
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        // gets the first item at index 0
        let documentDirectory = paths[0] as String
        // appends the file name on to the end of the path
        let myFilePath = documentDirectory.stringByAppendingPathComponent(fileName)
        
        println("MY FILE PATH: \(myFilePath)")
        
        return myFilePath
        
    }
    
    func checkForFile(path:String) -> Bool
    {
        // This methods checks the file system to see if the give filname and path exisits
        
        // Allows you examine the contents of the file system and make changes to it.
        let manager = NSFileManager.defaultManager()
        
        // Check to see if the file name is in that path or not
        if(manager.fileExistsAtPath(path))
        {
            println("YOUR FILE IS HERE!!!!")
            return true
        }
        else
        {
            println("YOUR FILE IS NOT HERE!!!!")
            return false
        }
    }
    
    func saveFile(objectToSave:AnyObject,  fileName:String)
    {
        // Saves the give object in the directory with the name of the file
        
        if NSKeyedArchiver.archiveRootObject(objectToSave, toFile: fileName)
        {
            println("File has been save.")
        }
        else
        {
            println("File has not been saved!")
        }
    }
    

    
    
}

