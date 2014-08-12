//
//  DetailViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/12/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var personImageView: UIImageView!
    @IBOutlet var personNameLabel: UILabel!
    
    var person = Person?()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.personNameLabel.text = "\(person?.firstName)" + " " + "\(person?.lastName)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
