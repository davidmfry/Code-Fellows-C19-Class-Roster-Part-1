//
//  DetailViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/12/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit
import MobileCoreServices

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet var personImageView:      UIImageView!
    @IBOutlet var firstNameTextField:   UITextField!
    @IBOutlet var lastNameTextField:    UITextField!

    var selectedPerson = Person?()

    var savedPic : UIImage?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.firstNameTextField.delegate    = self
        self.lastNameTextField.delegate     = self
        
        self.firstNameTextField.text        = self.selectedPerson?.firstName
        self.lastNameTextField.text         = self.selectedPerson?.lastName
        self.personImageView.image          = self.selectedPerson?.image
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if self.savedPic != nil
        {
            self.personImageView.image = self.savedPic
            self.selectedPerson?.image = self.savedPic
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
    
    func textFieldDidEndEditing(textField: UITextField!) {
        self.selectedPerson?.firstName = self.firstNameTextField.text
        self.selectedPerson?.lastName = self.lastNameTextField.text
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
        self.savedPic = imageToSave
        // Dismisss the camera View Controller
        self.dismissViewControllerAnimated(true, nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    

    


}
