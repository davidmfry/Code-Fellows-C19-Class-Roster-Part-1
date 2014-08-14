//
//  AddPersonViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/14/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {

    var newPerson = Person?()
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var idNumberTextField: UITextField!
    @IBOutlet var roleTextField: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.idNumberTextField.delegate = self
        self.roleTextField.delegate = self

       
    }

    override func viewDidDisappear(animated: Bool)
    {
        self.newPerson?.firstName = self.firstNameTextField.text
        self.newPerson?.lastName = self.lastNameTextField.text
        self.newPerson?.studentId = self.idNumberTextField.text
        self.newPerson?.role = self.roleTextField.text
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
