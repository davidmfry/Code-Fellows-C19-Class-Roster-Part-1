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
    
    var newArray = []
    var personArray = [Person]()
    let studentPlist = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("studentRoster", ofType: "plist"))
    //let mypath = NSBundle.mainBundle().pathForResource("studentRoster", ofType: "plist")
    //let dict = NSDictionary(contentsOfFile:self.mypath)
    var dict = self.studentPlist as Array<Dictionary<String, String>>
    override func viewDidLoad()
    {
        super.viewDidLoad()
//      makePersonsArray()
//        for person in self.personArray
//        {
//            println("\(person.fullName())")
//        }
        println(self.dict[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    func makePersonsArray()
//    {
//        
//        for name in newArray
//        {
//            var newPerson = Person(firstName: name["firstName"]!, lastName: name["lastName"]!)
//            personArray.append(newPerson)
//        }
//    
//    }
    
    
    
    
    
    
}

