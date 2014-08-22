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
    // Entity Names
    let STUDENT_ENTITY = "Students"
    let TEACHER_ENTITY = "Teachers"
    
    // Entity Keys
    let FIRST_NAME_KEY = "firstName"
    let LAST_NAME_KEY = "lastName"
    let STUDENT_ID_KEY = "studentID"
    let ROLE_KEY = "role"
    let IMAGE_KEY = "image"
    
    @IBOutlet var personImageView:      UIImageView!
    @IBOutlet var firstNameTextField:   UITextField!
    @IBOutlet var lastNameTextField:    UITextField!
    
    var firstName = ""
    var lastName = ""
    var image: NSData?

    var selectedPerson: NSManagedObject?

    var savedPic : NSData?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.firstNameTextField.delegate    = self
        self.lastNameTextField.delegate     = self
        
        self.firstNameTextField.text        = self.firstName
        self.lastNameTextField.text         = self.lastName
        self.personImageView.image          = UIImage(data: self.image) as UIImage
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
            
        if self.savedPic != nil
        {
            self.editItem(self.STUDENT_ENTITY, existingItem: self.selectedPerson!, keyForValueToChange: self.IMAGE_KEY, value: self.savedPic!)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: #IBActions
    @IBAction func tapedTheProfileImage(sender: AnyObject)
    {
        self.presentCamera()
    }
    
    @IBAction func pushedTakeAPicture(sender: AnyObject)
    {
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
        
        self.selectedPerson!.setValue(self.firstNameTextField.text, forKey: self.FIRST_NAME_KEY)
        self.selectedPerson!.setValue(self.lastNameTextField.text, forKey: self.LAST_NAME_KEY)
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
    

    


}
