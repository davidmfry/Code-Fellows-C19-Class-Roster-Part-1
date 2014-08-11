//
//  DetailsViewController.swift
//  C19_a2_Class_Roster_P1
//
//  Created by David Fry on 8/11/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController
{
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var studentNameLabel: UILabel!
    @IBOutlet var studentIdLabel: UILabel!
    
    var person: Person?
    
    required init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.studentNameLabel.text = person?.name
        self.studentIdLabel.text = person?.studentId
        self.profileImage.image = person?.image
        
    }
    
    
}