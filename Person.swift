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
    var firstName = ""
    var lastName = ""
    var image: UIImage?
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func fullName () -> String
    {
        return "\(self.firstName) \(self.lastName)"
    }
    
   
    
}
