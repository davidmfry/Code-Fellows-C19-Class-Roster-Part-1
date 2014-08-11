//
//  Person.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/5/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//


import UIKit

class Person: NSObject
{
    var studentId: String?
    var firstName: String?
    var lastName: String?
    var image: UIImage?
    
    init(studentId:String, firstName: String, lastName: String)
    {
        self.studentId = studentId
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func fullName (idOn: Bool) -> String
    {
        // This prints out the full name of the object.  The idOn is a variable to give the option to display the student Id.

        if idOn == false
        {
            return "Name: \(self.firstName!) \(self.lastName!)"
        }
        else
        {
            return "id: \(self.studentId!) Name: \(self.firstName!) \(self.lastName!)"
        }
    }
    
    func giveStudentID() -> String
    {
        return self.studentId!
    }
    
   
    
}
