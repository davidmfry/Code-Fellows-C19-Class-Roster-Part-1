//
//  ViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/5/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

// Canvas API to get all students in C19 https://canvas.instructure.com/api/v1/courses/868751/students
// Canvas API to get student object https://canvas.instructure.com/api/v1/users/3987826/profile (/users/:user_id/profile)
// API Key: 7~CKAvoX6pZT2oeBQOWFtKzI6f9et2XdunrLMYvO5IIWNyoVvBwLoZLkpV45MFNZaK


import UIKit
import Foundation

class ViewController: UIViewController {
    
    var newArray = []
    var personArray = [Person]()
    let studentPlist = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("studentRoster", ofType: "plsit"))
    let plistPath = NSBundle.mainBundle().pathForResource("studentRoster", ofType: "plist")
    
    
    //let dict = NSDictionary(contentsOfFile:self.mypath)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let studentRoster = NSArray(contentsOfFile: self.plistPath)
        //var studentList = self.studentPlist as Array<Dictionary<String, String>>
//      makePersonsArray()
//        for person in self.personArray
//        {
//            println("\(person.fullName())")
//        }
        println(studentRoster[0]["firstName"])
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
    
// Canvas API Stuff:
// I dont understand how to get the auth to work and let me pull the data I need
//    let studentListURLPath = "https://canvas.instructure.com/api/v1/courses/868751/students"
//    let apiKey = "7~CKAvoX6pZT2oeBQOWFtKzI6f9et2XdunrLMYvO5IIWNyoVvBwLoZLkpV45MFNZaK"
//    var url = NSURL(string:studentListURLPath)
//    var request = NSURLRequest(URL: url)
//    let queue:NSOperationQueue = NSOperationQueue()
//    
//    
//    let authURL = NSURL(string: "https://canvas.instructure.com/api/v1/courses?access_token=" + self.apiKey)
//    let task = NSURLSession.sharedSession().dataTaskWithURL(authURL){(data, response, error)
//        in
//    }
//    task.resume()
//    
//    NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//   
//    
//    
//    var err: NSError
//    var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//    println("AsyncsynchonousRequest\(jsonResult)")
//    
//    
//    })
    
    
    
    
}

