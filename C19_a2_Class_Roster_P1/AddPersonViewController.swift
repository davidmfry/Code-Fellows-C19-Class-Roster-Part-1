//
//  AddPersonViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/14/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit
import CoreData

class AddPersonViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

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
    
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var idNumberTextField: UITextField!
    @IBOutlet var roleTextField: UITextField!
    @IBOutlet var profileImage: UIImageView!
    
    var savedPic: NSData?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.idNumberTextField.delegate = self
        self.roleTextField.delegate = self
        self.profileImage.image = UIImage(named: "blank-carbon-han")
       
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    
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
    
//MARK: #Camera Methods
    func presentCamera()
    {
        // Check for the camera device
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            println("YES")
            var cameraUI = UIImagePickerController()
            cameraUI.delegate = self
            cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
            
            // If true you can pinch and zoom to make a diffrent image
            cameraUI.allowsEditing = true
            // Pops the camera UI on screen
            self.presentViewController(cameraUI, animated: true, completion: nil)
        }
        else
        {
            // Alert show if there device does not have the device
            var alert = UIAlertView()
            alert.title = "No Device"
            alert.message = "Your device does not have the proper camera"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!)
    {
        // Image var to save the user taken image
        var imageToSave:UIImage?
        
        
        imageToSave = info.objectForKey(UIImagePickerControllerEditedImage) as? UIImage
        
        // Saves the image
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        self.profileImage.image = imageToSave
        
        // Data from the saved imaged
        self.savedPic = UIImageJPEGRepresentation(imageToSave, 1.0)
        
        // Dismisss the camera View Controller
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
    
//MARK: IBActions
    @IBAction func imageViewPressed(sender: AnyObject)
    {
        self.presentCamera()
    }
    
    @IBAction func finishedButtonPressed(sender: AnyObject)
    {
       
        // Saves the User Data into the CoreData DB
        if self.roleTextField.text == "teacher"
        {
            self.createPerson(self.TEACHER_ENTITY)
        }
        if self.roleTextField.text == "student"
        {
            self.createPerson(self.STUDENT_ENTITY)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
//MARK: Adding a new Person
    func createPerson(entityName: String)
    {
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Reference managed object context
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // Name of the entity in the Core Data db and tells the app to use the entity created in the DB
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        
        // Creates new Person object to insert into the Core Data DB
        var newPerson = CoreDBModelPerson(entity: entity, insertIntoManagedObjectContext: context)
        newPerson.firstName         = firstNameTextField.text
        newPerson.lastName          = lastNameTextField.text
        newPerson.studentID         = idNumberTextField.text
        newPerson.role              = roleTextField.text
        newPerson.gitHubUserName    = ""
        newPerson.image             = UIImagePNGRepresentation(self.profileImage.image)
        
        context.save(nil)
    }
    
//MARK: Edit Entity Item
    func editItem(entityName: String, existingItem: NSManagedObject, keyForValueToChange:String, value:AnyObject)
    {
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Reference managed object context
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // Name of the entity in the Core Data db and tells the app to use the entity created in the DB
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        
        // Allows editing on the existing item in the Entoty
        existingItem.setValue(value, forKey: keyForValueToChange)
        
        var error: NSError?
        
        context.save(&error)
        
    }
    


}
