//
//  OverViewControl.swift
//  TrackITClient
//
//  Created by Jack Wright on 2018-06-30.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

let time = DateAttributes()

class UIOverviewControl: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dateLabel.text = time.currentDateToString()
        
    }
    
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var foodAddButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    
}
