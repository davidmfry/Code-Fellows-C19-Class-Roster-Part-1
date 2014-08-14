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
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.firstNameTextField.text = selectedPerson!.firstName
        self.lastNameTextField.text = selectedPerson!.lastName
        //self.person?.image = UIImage(named: "blank-storm-trooper")
        personImageView.image = UIImage(named: "blank-storm-trooper")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func firstNameTextFieldChange(sender: AnyObject)
    {
        self.selectedPerson!.firstName = self.firstNameTextField.text
    }
    
    @IBAction func lastNameTextFieldChanged(sender: AnyObject)
    {
        self.selectedPerson!.lastName = self.lastNameTextField.text
    }
    


}
