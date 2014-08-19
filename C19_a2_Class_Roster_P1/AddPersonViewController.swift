//
//  AddPersonViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/14/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {

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
    
    func createPerson() -> Person
    {
        return Person(studentId: self.idNumberTextField.text, firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, role: self.roleTextField.text)
    }
    


}
