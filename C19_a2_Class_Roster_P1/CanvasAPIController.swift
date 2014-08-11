//
//  CanvasAPIController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/11/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import Foundation

protocol CanvasAPIControllerProtocol
{
    func didReceiveAPIResults(results: NSArray)
}

class CanvasAPIController
{
   
    var delegate: CanvasAPIControllerProtocol?
    
    init()
    {
       
    }
            
    
    
    func getStudentList()
    {
        let apiKey = "7~CKAvoX6pZT2oeBQOWFtKzI6f9et2XdunrLMYvO5IIWNyoVvBwLoZLkpV45MFNZaK"
        let authUrlPath = "https://canvas.instructure.com/api/v1/courses/868751/students?access_token=\(apiKey)"
        
        let url = NSURL(string: authUrlPath)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            println("Task Completed")
            if((error) != nil)
            {
                println(error.localizedDescription)
            }
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            
            if (err != nil)
            {
                println("JSON Error \(err!.localizedDescription)")
            }
            let results = jsonResult
            self.delegate?.didReceiveAPIResults(results)
        })
        task.resume()
        
        
        
    }

}