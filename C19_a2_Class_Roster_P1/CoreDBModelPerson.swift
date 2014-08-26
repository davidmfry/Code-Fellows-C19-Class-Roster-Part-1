//
//  CoreDBModelPerson.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/22/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit
import CoreData

@objc(CoreDBModelPerson)
class CoreDBModelPerson: NSManagedObject
{
    // properties feedding the atributes in our entity
    // must match the entity atributes
    
    @NSManaged var studentID: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var gitHubUserName: String
    @NSManaged var role: String
    @NSManaged var image: NSData
    
}
