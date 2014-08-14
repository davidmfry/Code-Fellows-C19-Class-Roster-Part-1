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
    var studentId: String
    var firstName: String
    var lastName: String
    var role: String
    var image: UIImage?
    
    
    init(studentId:String, firstName: String, lastName: String, role: String)
    {
        self.studentId = studentId
        self.firstName = firstName
        self.lastName = lastName
        self.role = role
    }
    
    func fullName (idOn: Bool) -> String
    {
        if idOn == false
        {
            return "\(self.firstName) \(self.lastName)"
        }
        else
        {
            return "id: \(self.studentId) Name: \(self.firstName) \(self.lastName)"
        }
    }
    
    func giveStudentID() -> String
    {
        return self.studentId
    }
    
   
    
}
