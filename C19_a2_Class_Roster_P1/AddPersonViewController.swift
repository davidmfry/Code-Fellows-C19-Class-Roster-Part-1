//
//  AddPersonViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/14/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var newPerson = Person(studentId: "", firstName: "", lastName: "", role: "")
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var idNumberTextField: UITextField!
    @IBOutlet var roleTextField: UITextField!
    @IBOutlet var profileImage: UIImageView!
    
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
        // Dismisss the camera View Controller
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
    
    @IBAction func firstNameTextFieldChanged(sender: AnyObject)
    {
        //self.newPerson.firstName = self.firstNameTextField.text
    }
    @IBAction func lastNameTextFieldChanged(sender: AnyObject)
    {
        //self.newPerson.lastName = self.lastNameTextField.text
    }

    @IBAction func idTextFieldChanged(sender: AnyObject)
    {
        //self.newPerson.studentId = self.idNumberTextField.text
    }

    @IBAction func roleTextFieldChanged(sender: AnyObject)
    {
        //self.newPerson.role = self.roleTextField.text
    }
    
    @IBAction func imageViewPressed(sender: AnyObject)
    {
        self.presentCamera()
    }
    func createPerson() -> Person
    {
        return Person(studentId: self.idNumberTextField.text, firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, role: self.roleTextField.text)
    }
    


}
