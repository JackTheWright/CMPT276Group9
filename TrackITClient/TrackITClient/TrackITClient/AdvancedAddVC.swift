//
//  AdvancedAddVC.swift
//  TrackITClient
//
//  Created by Jack Wright on 2018-07-05.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

class AdvancedAddVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBOutlet weak var advancedTextField: UITextField!
    
    var autoCompletionPossibilities = ["Apple", "Pineapple", "Orange"]
    var autoCompleteCharacterCount = 0
    var timer = Timer()
    
    
    
    
    
}
