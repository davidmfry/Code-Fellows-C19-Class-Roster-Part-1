//
//  Person.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/5/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//


import UIKit
import Foundation

class Person: NSObject, NSCoding
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
    
    func encodeWithCoder(aCoder: NSCoder!)
    {
        aCoder.encodeObject(self.firstName, forKey:"firstName")
        aCoder.encodeObject(self.lastName, forKey:"lastName")
        aCoder.encodeObject(self.studentId, forKey:"studentId")
        aCoder.encodeObject(self.role, forKey:"role")
        aCoder.encodeObject(self.image, forKey:"image")
        
        
    }
    
    required init(coder aDecoder: NSCoder!)
    {
        self.studentId = aDecoder.decodeObjectForKey("studentId") as String
        self.firstName = aDecoder.decodeObjectForKey("firstName") as String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as String
        self.role = aDecoder.decodeObjectForKey("role") as String
        self.image = aDecoder.decodeObjectForKey("image") as? UIImage
    }
    
    
    
    
   
    
}
