//
//  ViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/5/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var personArray = [Person]()
    var dave = Person(firstName: "David", lastName: "Fry")
    
    var newArray = [
            [
                "lastName": "Birkholz",
                "firstName": "Nate"
            ],
        
            [
                "lastName": "Brightbill",
                "firstName": "Matthew"
            ],
        
            [
                "lastName": "Chavez",
                "firstName": "Jeff"
            ],
        
            [
                "lastName": "Clem",
                "firstName": "John"
            ],
            [
                "lastName": "Doi",
                "firstName": "Yuto"
            ],
            [
            "lastName": "Ferderer",
            "firstName": "Chrstie"
            ],
            [
            "lastName": "Fry",
            "firstName": "David"
            ],
            [
            "lastName": "Petrica Gherle",
            "firstName": "Adrian"
            ],
            [
            "lastName": "Hawken",
            "firstName": "Jake"
            ],
            [
            "lastName": "Huang",
            "firstName": "Tony"
            ],
            [
            "lastName": "Johnson",
            "firstName": "Brad"
            ],
            [
            "lastName": "Kazi",
            "firstName": "Shams"
            ],
            [
            "lastName": "Klein",
            "firstName": "Cameron"
            ],
            [
            "lastName": "Kolodziejczak",
            "firstName": "Kori"
            ],
            [
            "lastName": "Lewis",
            "firstName": "Parker"
            ],
            [
            "lastName": "none",
            "firstName": "lindy@codefellows.com"
            ],
            [
            "lastName": "Ma",
            "firstName": "Nathan"
            ],
            [
            "lastName": "MacPhee",
            "firstName": "Casey"
            ],
            [
            "lastName": "McAleer",
            "firstName": "Brendan"
            ],
            [
            "lastName": "Mendez",
            "firstName": "Brian"
            ],
            [
            "lastName": "Morris",
            "firstName": "Mark"
            ],
            [
            "lastName": "North",
            "firstName": "Rowan"
            ],
            [
            "lastName": "Park",
            "firstName": "Lance"
            ],
            [
            "lastName": "Pham",
            "firstName": "Kevin"
            ],
            [
            "lastName": "Richman",
            "firstName": "Will"
            ],
            [
            "lastName": "Thueringer",
            "firstName": "Heather"
            ],
            [
            "lastName": "Vu",
            "firstName": "Tuan"
            ],
            [
            "lastName": "Walkingstick",
            "firstName": "Zack"
            ],
            [
            "lastName": "Wong",
            "firstName": "Sara"
            ],
            [
            "lastName": "Zhang",
            "firstName": "Hongyao"
            ]
        ]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        makePersonsArray()
        for person in self.personArray
        {
            println("\(person.fullName())")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func makeJSONData()
    {
        
    }
    
    func makePersonsArray()
    {
        
        for name in newArray
        {
            var newPerson = Person(firstName: name["firstName"], lastName: name["lastName"])
            personArray.append(newPerson)
        }
    
    }
    
    
    
    
    
    
}

