//
//  DetailViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/12/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
//MARK: Entity Names
    let STUDENT_ENTITY = "Students"
    let TEACHER_ENTITY = "Teachers"
    
//MARK: Entity Keys
    let FIRST_NAME_KEY = "firstName"
    let LAST_NAME_KEY = "lastName"
    let STUDENT_ID_KEY = "studentID"
    let GITHUB_NAME_KEY = "gitHubUserName"
    let ROLE_KEY = "role"
    let IMAGE_KEY = "image"

//MARK: IBOutles
    @IBOutlet var personImageView:      UIImageView!
    @IBOutlet var firstNameTextField:   UITextField!
    @IBOutlet var lastNameTextField:    UITextField!
    @IBOutlet var gitHubUserNameTextField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

//MARK: Variables from segue
    var firstName = ""
    var lastName = ""
    var role = ""
    var gitHubUserName: String?
    var jsonData : NSDictionary?
    var image : NSData?
    var selectedPerson: NSManagedObject?

//MARK: Picture variable
    var savedPic : NSData?

//MARK: GitHub API variables
    var gitHubApiUrl = "https://api.github.com/users/"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        println(self.role)
        //Load the delegates
        self.firstNameTextField.delegate        = self
        self.lastNameTextField.delegate         = self
        self.gitHubUserNameTextField.delegate   = self
        self.firstNameTextField.text            = self.firstName
        self.lastNameTextField.text             = self.lastName
        
        // Checking for a github user so the view can render the right picture
        self.personImageView.image = UIImage(data: self.image) as UIImage
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        // Refreshing the text field fro git hub username
        self.gitHubUserNameTextField.text = self.selectedPerson!.valueForKey(self.GITHUB_NAME_KEY) as String
        
        // Saving the new picture in the CoreData database
        if self.savedPic != nil
        {
            if self.role == "student"
            {
                self.editItem(self.STUDENT_ENTITY, existingItem: self.selectedPerson!, keyForValueToChange: self.IMAGE_KEY, value: self.savedPic!)
            }
            else
            {
                self.editItem(self.TEACHER_ENTITY, existingItem: self.selectedPerson!, keyForValueToChange: self.IMAGE_KEY, value: self.savedPic!)
            }
        }
        
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        // Saving the new picture in the CoreData database
        if self.savedPic != nil
        {
            println(self.role)
            if self.role == "student"
            {
                self.editItem(self.STUDENT_ENTITY, existingItem: self.selectedPerson!, keyForValueToChange: self.IMAGE_KEY, value: self.savedPic!)
            }
            else
            {
                self.editItem(self.TEACHER_ENTITY, existingItem: self.selectedPerson!, keyForValueToChange: self.IMAGE_KEY, value: self.savedPic!)
            }
        }
    }
    

    
//MARK: #IBActions
    @IBAction func tapedTheProfileImage(sender: AnyObject)
    {
        // Launches an alert view then the profile image is tapped
        self.addAlertView("Giting Picture", message: "Please add your gitHub username", alertStyle: UIAlertControllerStyle.Alert)
        
    }
    
    @IBAction func pushedTakeAPicture(sender: AnyObject)
    {
        // Launches the camera view
        self.presentCamera()
    }
    
//MARK: #Keyboard Dismiss
    func textFieldShouldReturn(textField:UITextField!) -> Bool
    {
        // Dissmiss the keyboard when the return button is pressed
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)
    {
        // Dissmiss the keyboard when the view is touched
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(textField: UITextField!)
    {
        // Reference to our app delegate
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        
        // Reference managed object context
        
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // Name of the entity in the Core Data db and tells the app to use the entity created in the DB
        let entity = NSEntityDescription.entityForName(self.STUDENT_ENTITY, inManagedObjectContext: context)
        
        if textField == self.firstNameTextField
        {
            self.selectedPerson!.setValue(self.firstNameTextField.text, forKey: self.FIRST_NAME_KEY)
            
        }
        
        if textField == self.lastNameTextField
        {

            self.selectedPerson!.setValue(self.lastNameTextField.text, forKey: self.LAST_NAME_KEY)
        }
        
        if textField == self.gitHubUserNameTextField
        {
            // Checks and downloads an image if there github username is valid
            var url = NSURL(string: "\(self.gitHubApiUrl)\(self.gitHubUserNameTextField.text)")
            self.getJsonDataFromGitHub(self.gitHubUserNameTextField.text)
            
            // Saves the text from the textfield into the CoreData Database
            self.selectedPerson!.setValue(self.gitHubUserNameTextField.text, forKey: self.GITHUB_NAME_KEY)

        }
        context.save(nil)
    }
//MARK: #Camera Methods
    func presentCamera()
    {
        // Check for the camera device
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {
            println("YES")
            var cameraUI = UIImagePickerController()
            cameraUI.delegate = self
            cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            // If true you can pinch and zoom to make a diffrent image
            cameraUI.allowsEditing = true
            // Pops the camera UI on screen
            self.presentViewController(cameraUI, animated: true, completion: nil)
        }
        else
        {
            var alert = UIAlertView()
            alert.title = "No Device"
            alert.message = "Your device does not have the proper camera"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!)
    {
        // Image var to save the user taken image
        var imageToSave:UIImage?
        
        
        imageToSave = info[UIImagePickerControllerEditedImage] as? UIImage
        
        // Saves the image
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        
        // Shows new image on the UIImage view
        self.personImageView.image = imageToSave
        
        self.savedPic = UIImageJPEGRepresentation(imageToSave, 1.0)
        
        // Dismisss the camera View Controller
        self.dismissViewControllerAnimated(true, nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
//MARK: CRUD Function
    func editItem(entityName: String, existingItem: NSManagedObject, keyForValueToChange:String, value:AnyObject)
    {
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Reference managed object context
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // Name of the entity in the Core Data db and tells the app to use the entity created in the DB
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        existingItem.setValue(value, forKey: keyForValueToChange)

        var error: NSError?
        
        context.save(&error)
        
    }

//MARK: API functions

    func getJsonDataFromGitHub(username:String)
    {
        // This function gets Json data from the gitHub api using the given username
        
        // This holds the gitHub api url
        let URL = NSURL(string: "https://api.github.com/users/\(username)")
//TODO: Figure out how to get a response code before the task is created
        
        // Gets a session which give a convient way to download data from HTTP
        let session = NSURLSession.sharedSession()
        
        
        self.activityIndicator.startAnimating()
        
        // Creats the GET request from the give URL
        let task = session.dataTaskWithURL(URL, completionHandler: { (data, response, error) -> Void in
            
            
            if response == nil
            {
                self.activityIndicator.stopAnimating()
                // Launches an Alert box for the user to try again
                self.addAlertView("Page Not Found:", message: "Check your username and try again.", alertStyle: UIAlertControllerStyle.Alert)
            }
            else
            {
            
                
                let httpResponse = response as NSHTTPURLResponse
                
                // The server code 200 is good anything else is bad
                let statusCode = httpResponse.statusCode as Int
                println(statusCode)
                
                if error != nil
                {
                    println(error.localizedDescription)
                }
                
                var err: NSError?
                
                if statusCode == 200
                {
                    // Puts the json data from the url into a variable
                    var jsonResults = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                    var url = NSURL(string: jsonResults["avatar_url"] as String)
                    var imageData = NSData(contentsOfURL: url)
                    var image = UIImage(data: imageData)
                    
                    // When finisehd with getting the data puts anything that needs to be updated into the main queue
                    dispatch_async(dispatch_get_main_queue(), {
                        self.jsonData = jsonResults
                        self.personImageView.image = image
                        self.savedPic = imageData
                        self.activityIndicator.stopAnimating()
                        
                    })
                }
                
                else
                {
                    self.activityIndicator.stopAnimating()
                    // Launches an Alert box for the user to try again
                    self.addAlertView("Page Not Found:", message: "Check your username and try again.", alertStyle: UIAlertControllerStyle.Alert)
                    
                }
            }
        })
        // Resumes the Task if its suspened
        task.resume()
        
    }
    
    
//MARK: Alerts

    func addTextField(textField: UITextField)
    {
        // Adds a text field to the alert box
        textField.placeholder = "GitHub Username:"
//        self.gitHubUserNameTextField = textField
        
    }
    
    
    
    
    func addAlertView(title: String, message: String, alertStyle: UIAlertControllerStyle)
    {
       // Creates a UIAlertController
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        
        // Adds the text field to the alert
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            self.addTextField(textField)
        }
        
        // Adds cancele button
        alert.addAction(UIAlertAction(title: "Cancele", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            self.activityIndicator.stopAnimating()
        }))
        
        // Add an ok button
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            
            var alertTextField = alert.textFields[0] as UITextField

            // Reference to our app delegate
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            
            // Reference managed object context
            let context: NSManagedObjectContext = appDel.managedObjectContext!
            
            // Name of the entity in the Core Data db and tells the app to use the entity created in the DB
            let entity = NSEntityDescription.entityForName(self.STUDENT_ENTITY, inManagedObjectContext: context)
            
            // Gets the correct Json data from the given username
            self.getJsonDataFromGitHub(alertTextField.text)
            
            // Check for student or teacher roles to save in the appropriate CoreData enties
            if self.role == "student"
            {

                self.editItem(self.STUDENT_ENTITY, existingItem: self.selectedPerson!, keyForValueToChange: self.GITHUB_NAME_KEY, value: alertTextField.text)
                self.gitHubUserName = alertTextField.text
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.gitHubUserNameTextField.text = self.gitHubUserName
                    self.gitHubUserNameTextField.setNeedsLayout()
                })


            }
            
            else
            {
                self.editItem(self.STUDENT_ENTITY, existingItem: self.selectedPerson!, keyForValueToChange: self.GITHUB_NAME_KEY, value: alertTextField.text)
                self.gitHubUserName = alertTextField.text
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.gitHubUserNameTextField.text = alertTextField.text
                    self.gitHubUserNameTextField.setNeedsDisplay()
                })
            }
            
            context.save(nil)
       
            
            
        }))
        presentViewController(alert, animated: true, completion: nil)
        
    }

}
