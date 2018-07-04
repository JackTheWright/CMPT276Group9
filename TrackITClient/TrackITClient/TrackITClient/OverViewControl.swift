//
// File         : OverViewControl.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jack Wright
// Created On   : 2018-06-20
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
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
