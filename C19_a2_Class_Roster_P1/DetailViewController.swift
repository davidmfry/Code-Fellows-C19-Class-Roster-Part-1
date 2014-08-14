//
//  DetailViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/12/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit
import MobileCoreServices

class DetailViewController: UIViewController, UITextFieldDelegate
{

    @IBOutlet var personImageView:      UIImageView!
    @IBOutlet var firstNameTextField:   UITextField!
    @IBOutlet var lastNameTextField:    UITextField!

    var selectedPerson = Person?()

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.firstNameTextField.delegate    = self
        self.lastNameTextField.delegate     = self
        
        self.firstNameTextField.text        = self.selectedPerson?.firstName
        self.lastNameTextField.text         = self.selectedPerson?.lastName
        self.personImageView.image          = self.selectedPerson?.image
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func firstNameTextFieldChange(sender: AnyObject)
    {
        self.selectedPerson?.firstName = self.firstNameTextField.text
    }
    
    @IBAction func lastNameTextFieldChanged(sender: AnyObject)
    {
        self.selectedPerson?.lastName = self.lastNameTextField.text
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

    
  
    

    


}
