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
let package = ServingPackage()
let vc = viewControl()

class UIOverviewControl: UIViewController {
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        dateLabel.text = time.currentDateToFANCYString()
        
        let quickAddRefresh = UserDefaults.standard.bool(forKey: "checkToSeeIfLastAccessWasYesterday")
        var dayDic = Dictionary<String,[String]>()
        if (quickAddRefresh == false) {
            let yesterday = time.getYesterdaysDate()
            
            let meat = UserDefaults.standard.string(forKey: "meatTotal")
            let vegetable = UserDefaults.standard.string(forKey: "vegetableTotal")
            let fruit = UserDefaults.standard.string(forKey: "fruitTotal")
            let dairy = UserDefaults.standard.string(forKey: "dairyTotal")
            let grains = UserDefaults.standard.string(forKey: "grainsTotal")

            
            
            dayDic = package.packageItemsWithDate(date: yesterday, meat: meat!, vegetable: vegetable!, fruit: fruit!, dairy: dairy!, grains: grains!)
            
            UserDefaults.standard.set(dayDic, forKey: yesterday)
            
            UserDefaults.standard.set(0, forKey: "meatStepped")
            UserDefaults.standard.set("0", forKey: "meatTotal")
            
            UserDefaults.standard.set(0, forKey: "vegetableStepped")
            UserDefaults.standard.set("0", forKey: "vegetableTotal")
            
            UserDefaults.standard.set(0, forKey: "fruitStepped")
            UserDefaults.standard.set("0", forKey: "fruitTotal")
            
            UserDefaults.standard.set(0, forKey: "dairyStepped")
            UserDefaults.standard.set("0", forKey: "dairyTotal")
            
            UserDefaults.standard.set(0, forKey: "grainsStepped")
            UserDefaults.standard.set("0", forKey: "grainsTotal")
        }
    }
    
    // Initialize Notification Button, FoodAdd Button and the Barchart label
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var foodAddButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var advancedStatsButton: UIButton!
    
}
