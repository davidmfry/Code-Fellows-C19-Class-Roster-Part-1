//
//  ViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/5/14.
//  Copyright (c) 2014 David Fry. All rights reserved.


// Canvas API to get all students in C19 https://canvas.instructure.com/api/v1/courses/868751/students
// Canvas API to get student object https://canvas.instructure.com/api/v1/users/3987826/profile (/users/:user_id/profile)



import UIKit
import Foundation
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var studentArray = [AnyObject]()                // An array to hold off the student objects after they are created by makePeopleArray
    var teacherArray = [AnyObject]()                // An array that holds teacher objects
    var numberOfSection = 2                         // Number of section for the table view
    
    var studentFilePath: String?                    // File path to store the acrhived file for the students array
    var teacherFilePath: String?                    // File path to store the acrhived file for the teachers array
    var studentFileName = "studentList.plist"       // Name for the students array file
    var teacherFileName = "teacherList.plist"       // Name for the teachers array file
    
    
    @IBOutlet var appTableView: UITableView!
    
    // Getting the path to the plist files. The plist contains an Array<Dictionary>
    let studentPlistPath = NSBundle.mainBundle().pathForResource("studentRoster", ofType: "plist")
    let teacherPlistPath = NSBundle.mainBundle().pathForResource("teacherRoster", ofType: "plist")
    
    // User Defaults
    let standardDefaults = NSUserDefaults.standardUserDefaults()
    
    // Entity Names
    let STUDENT_ENTITY = "Students"
    let TEACHER_ENTITY = "Teachers"
    
    // Entity Keys
    let FIRST_NAME_KEY = "firstName"
    let LAST_NAME_KEY = "lastName"
    let STUDENT_ID_KEY = "studentID"
    let GITHUB_NAME_KEY = "gitHubUserName"
    let ROLE_KEY = "role"
    let IMAGE_KEY = "image"
    
    
//MARK: #Life Cycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // used to creating the DB once from the plist
        var firstAppRun = self.standardDefaults.integerForKey("firstAppRun")
        

        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
    
        // student and teacher roster is the plist variable wich can be opperated on.  It's an NSArray
        let studentRoster = NSArray(contentsOfFile: self.studentPlistPath!)
        let teacherRoster = NSArray(contentsOfFile: self.teacherPlistPath!)
        
        if firstAppRun == 0
        {
            // Make people data model
            self.makePeople(studentRoster!, entityName: self.STUDENT_ENTITY)
            self.makePeople(teacherRoster!, entityName: self.TEACHER_ENTITY)
        }
        
     
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // Reloads the tabelView after it comes back from any other viewController
        
        //Sets the firstAppRun to 1 so it does not create the DB again after the app closes
        standardDefaults.setInteger(1, forKey: "firstAppRun")
        let getStudentList = NSFetchRequest(entityName: self.STUDENT_ENTITY)
        let getTeacherList = NSFetchRequest(entityName: self.TEACHER_ENTITY)
        
        self.studentArray = context.executeFetchRequest(getStudentList, error: nil)!
        self.teacherArray = context.executeFetchRequest(getTeacherList, error: nil)!
        
        self.appTableView.reloadData()
    }

//MARK: #TableView Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return numberOfSection
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Student section
        if section == 0
        {
            return studentArray.count
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellIdentifier = "myCell"                   // Name for the cell in the table view
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        
        // Makes the profile images rounded
        cell.imageView.layer.masksToBounds = true
        cell.imageView.layer.cornerRadius = 20.0
        
        // Student  Cell
        if indexPath.section == 0
        {
            // Managed object from CoreData Entity Students
            var data = self.studentArray[indexPath.row] as NSManagedObject
            // Student Imagefile in binary data format and needs to be changed to a UIImage for use
            var studentImage = data.valueForKey(self.IMAGE_KEY) as NSData
            
            // Cell Config
            cell.textLabel.text = "\(data.valueForKey(self.FIRST_NAME_KEY)!) \(data.valueForKey(self.LAST_NAME_KEY)!)"
            cell.detailTextLabel?.text = "Github Username: \(data.valueForKey(self.GITHUB_NAME_KEY)!)"
            cell.imageView.image = UIImage(data: studentImage)!
            
            return cell
        }
            
            // Teacher Cell
        else
        {
            // Managed object from CoreData Entity Teachers
            var data = self.teacherArray[indexPath.row] as NSManagedObject
            // Teacher Imagefile in binary data format and needs to be changed to a UIImage for use
            var teacherImage = data.valueForKey(self.IMAGE_KEY) as NSData
            
            // Cell Config
            cell.textLabel.text = "\(data.valueForKey(self.FIRST_NAME_KEY)) \(data.valueForKey(self.LAST_NAME_KEY))"
            cell.detailTextLabel?.text = "Github Username: \(data.valueForKey(self.GITHUB_NAME_KEY))"
            cell.imageView.image = UIImage(data: teacherImage)!
            return cell
        }
        
 
    }
    
    
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        // Allows editing for the table View cell
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // Checks to see if the cell style is set to delete
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            // Makes sure the tableView var is not empty
            if let tv = tableView
            {
                // Student Section
                if indexPath.section == 0
                {
                    // Gets the object to be deleted
                    context.deleteObject(self.studentArray[indexPath.row] as NSManagedObject)
                        
                    // Removes the item from the array at the index path
                    self.studentArray.removeAtIndex(indexPath.row)
                    
                    // Deletes the row
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
                else
                {
                    // Gets the object to be deleted
                    context.deleteObject(self.teacherArray[indexPath.row] as NSManagedObject)
                    
                    // Removes the item from the array at the index path
                    
                    self.teacherArray.removeAtIndex(indexPath.row)
                    
                    // Deletes the row
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
                
                var error: NSError?
                // Saves the Entity and if there is an error aborts the save
                if !context.save(&error)
                {
                    abort()
                }
            }
            
                
        }
    }
//MARK:  #Navagation Methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "segueToDetailView"
        {
            var detailViewController = segue.destinationViewController as DetailViewController
            var personIndex = self.appTableView.indexPathForSelectedRow()?.row
            var selectedPerson: NSManagedObject
            
            // Checks to see what type of person objects is going to passed in the segue.  Its
            // Either a student or teacher person object
            
            if self.appTableView.indexPathForSelectedRow()?.row == 0
            {
                selectedPerson = self.studentArray[personIndex!] as NSManagedObject
                // Passes the person managed object by referance to the detailViewController
                detailViewController.firstName = selectedPerson.valueForKey(self.FIRST_NAME_KEY) as String
                detailViewController.lastName = selectedPerson.valueForKey(self.LAST_NAME_KEY) as String
                detailViewController.role = selectedPerson.valueForKey(self.ROLE_KEY) as String
                detailViewController.gitHubUserName = selectedPerson.valueForKey(self.GITHUB_NAME_KEY) as? String
                println("Github USER NAME \(selectedPerson.valueForKey(self.GITHUB_NAME_KEY) as String)")
                detailViewController.image = selectedPerson.valueForKey(self.IMAGE_KEY) as? NSData
                detailViewController.selectedPerson = selectedPerson
            }
            
            else
            {
                selectedPerson = self.teacherArray[personIndex!] as NSManagedObject
                // Passes the person managed object by referance to the detailViewController
                detailViewController.firstName = selectedPerson.valueForKey(self.FIRST_NAME_KEY) as String
                detailViewController.lastName = selectedPerson.valueForKey(self.LAST_NAME_KEY) as String
                detailViewController.role = selectedPerson.valueForKey(self.ROLE_KEY) as String
                detailViewController.image = selectedPerson.valueForKey(self.IMAGE_KEY) as? NSData
                detailViewController.selectedPerson = selectedPerson
            }
        }
    }
    
//MARK: #Custom Methods
    func makePeople(rosterArray: NSArray, entityName:String)
    {
        // This function takes in an Array<dictionary>.  The Creats an Array<Person> and each person object
        // is initalized with an Id number, First name and Last name.
        
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Reference managed object context
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // Name of the entity in the Core Data db and tells the app to use the entity created in the DB
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        
        // Data for the default profile pictures
        var blankStudentImageData = UIImagePNGRepresentation(UIImage(named: "blank-storm-trooper"))
        var blankTeacherImageData = UIImagePNGRepresentation(UIImage(named: "blank-darth-vader"))
        
       
        for name in rosterArray
        {
            // Create instance of CoreDBModelPerson data model and initialize
            var newPerson = CoreDBModelPerson(entity: entity!, insertIntoManagedObjectContext: context)
            
            // Mapping the properties from the plist
            newPerson.studentID = name["id"] as String
            newPerson.firstName = name["firstName"] as String
            newPerson.lastName = name["lastName"] as String
            newPerson.gitHubUserName = "" as String
            newPerson.role = name["role"] as String
            
            // Adding the proper image to the student or teacher
            if newPerson.role == "teacher"
            {
                newPerson.image = blankTeacherImageData
            }
            
            else
            {
                newPerson.image = blankStudentImageData
            }
            
            context.save(nil)
        }

    
    }
    

    
    
}

