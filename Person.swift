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
    var name: String
    var image: UIImage
    
    init(studentId:String, name:String, image:UIImage)
    {
        self.studentId = studentId
        self.name = name
        self.image = image
    }
    
//    func fullName (idOn: Bool) -> String
//    {
//        if !idOn
//        {
//            return "Name: \(self.firstName!) \(self.lastName!)"
//        }
//        else
//        {
//            return "id: \(self.studentId!) Name: \(self.firstName!) \(self.lastName!)"
//        }
//    }
    
    func giveStudentID() -> String
    {
        return self.studentId
    }
    
   
    
}
