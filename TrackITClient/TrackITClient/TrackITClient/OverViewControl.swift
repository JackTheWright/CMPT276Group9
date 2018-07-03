//
//  OverViewControl.swift
//  TrackITClient
//
//  Created by Jack Wright on 2018-06-30.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

// Set the DateAttributes class to a variable so we can access the the date to string function for the graph label.
let time = DateAttributes()

class UIOverviewControl: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dateLabel.text = time.currentDateToString()
        
    }
    
    // Initialize Notification Button, FoodAdd Button and the Barchart label
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var foodAddButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    
}
