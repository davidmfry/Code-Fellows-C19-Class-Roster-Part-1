//
//  DetailViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/12/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit
import MobileCoreServices

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet var personImageView: UIImageView!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!

    var selectedPerson = Person?()

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.firstNameTextField.text = self.selectedPerson?.firstName
        self.lastNameTextField.text = self.selectedPerson?.lastName
        self.personImageView.image = displayImage(self.selectedPerson!)
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
    
    func displayImage(person:Person) -> UIImage
    {
        if person.role == "teacher"
        {
            return UIImage(named: "blank-darth-vader")
        }
        else
        {
            return UIImage(named: "blank-storm-trooper")
        }
    }
    
  
    

    


}
