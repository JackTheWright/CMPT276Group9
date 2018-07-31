//
// File         : ViewControlClass.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jack Wright
// Created On   : 2018-06-27
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
//  - Fixed Formatting
//

import UIKit

class viewControl: UIViewController {
    
    let package = ServingPackage()
    let time = DateAttributes()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//  When the view loads, we setup the steppers default setting and make sure their values are exactly the same as when the app closed using the userdefaults. We make sure the stepper doesnt wrap and autorepeats and that the user can't press it more than 15 times.
        
        AdvancedAddVC.viewController = self
        meatStepper.wraps = false
        meatStepper.autorepeat = true
        meatStepper.maximumValue = 15
        meatCount.text = UserDefaults.standard.string(forKey: "meatTotal")
        meatStepper.value = UserDefaults.standard.double(forKey: "meatStepped")

        vegetableStepper.wraps = false
        vegetableStepper.autorepeat = true
        vegetableStepper.maximumValue = 15
        vegetableCount.text = UserDefaults.standard.string(forKey: "vegetableTotal")
        vegetableStepper.value = UserDefaults.standard.double(forKey: "vegetableStepped")

        fruitStepper.wraps = false
        fruitStepper.autorepeat = true
        fruitStepper.maximumValue = 15
        fruitCount.text = UserDefaults.standard.string(forKey: "fruitTotal")
        fruitStepper.value = UserDefaults.standard.double(forKey: "fruitStepped")

        dairyStepper.wraps = false
        dairyStepper.autorepeat = true
        dairyStepper.maximumValue = 15
        dairyCount.text = UserDefaults.standard.string(forKey: "dairyTotal")
        dairyStepper.value = UserDefaults.standard.double(forKey: "dairyStepped")

        grainsStepper.wraps = false
        grainsStepper.autorepeat = true
        grainsStepper.maximumValue = 15
        grainsCount.text = UserDefaults.standard.string(forKey: "grainsTotal")
        grainsStepper.value = UserDefaults.standard.double(forKey: "grainsStepped")
        
//  When the view appears we set the variable quickAddRefresh to the User Default checking if the app was last opened a different day. If the app was last opened on an earlier day, the values for the labels and steppers are reset. The day will then be packaged up into a dictionary and it will be labeled with yesterdays date.
        
        let quickAddRefresh = UserDefaults.standard.bool(forKey: "checkToSeeIfLastAccessWasYesterday")
        var dayDic = Dictionary<String,[String]>()
        if quickAddRefresh == false {
             let yesterday = time.getYesterdaysDate()
            dayDic[yesterday] =  [meatCount.text!, vegetableCount.text!, fruitCount.text!, dairyCount.text!, grainsCount.text!]
            if let current = UserDefaults.standard.object([String:[String]].self, with: "DailyPackage") {
                
                dayDic.update(other: current)
                
            }
            print(dayDic)
            UserDefaults.standard.set(object: dayDic, forKey: "DailyPackage")
            
            print("hit this bad boy")
            UserDefaults.standard.set(0, forKey: "meatStepped")
            UserDefaults.standard.set("0", forKey: "meatTotal")
            meatCount.text = UserDefaults.standard.string(forKey: "meatTotal")
            meatStepper.value = UserDefaults.standard.double(forKey: "meatStepped")
            
            UserDefaults.standard.set(0, forKey: "vegetableStepped")
            UserDefaults.standard.set("0", forKey: "vegetableTotal")
            vegetableCount.text = UserDefaults.standard.string(forKey: "vegetableTotal")
            vegetableStepper.value = UserDefaults.standard.double(forKey: "vegetableStepped")
            
            UserDefaults.standard.set(0, forKey: "fruitStepped")
            UserDefaults.standard.set("0", forKey: "fruitTotal")
            fruitCount.text = UserDefaults.standard.string(forKey: "fruitTotal")
            fruitStepper.value = UserDefaults.standard.double(forKey: "fruitStepped")
            
            UserDefaults.standard.set(0, forKey: "dairyStepped")
            UserDefaults.standard.set("0", forKey: "dairyTotal")
            dairyCount.text = UserDefaults.standard.string(forKey: "dairyTotal")
            dairyStepper.value = UserDefaults.standard.double(forKey: "dairyStepped")
            
            UserDefaults.standard.set(0, forKey: "grainsStepped")
            UserDefaults.standard.set("0", forKey: "grainsTotal")
            grainsCount.text = UserDefaults.standard.string(forKey: "grainsTotal")
            grainsStepper.value = UserDefaults.standard.double(forKey: "grainsStepped")
            
        }
    }
    
//  Initialize the Steppers and the labels and attach them to the objects on the storyboard.
    @IBOutlet weak var meatCount: UILabel!
    @IBOutlet weak var meatStepper: UIStepper!

    @IBOutlet weak var vegetableCount: UILabel!
    @IBOutlet weak var vegetableStepper: UIStepper!

    @IBOutlet weak var fruitCount: UILabel!
    @IBOutlet weak var fruitStepper: UIStepper!

    @IBOutlet weak var dairyCount: UILabel!
    @IBOutlet weak var dairyStepper: UIStepper!

    @IBOutlet weak var grainsCount: UILabel!
    @IBOutlet weak var grainsStepper: UIStepper!

//  These are the functions that connect the steppers to the label and save the states of the 2 so they persist no matter if the view changes or the app is terminated.
    @IBAction func meatStepperChanged(_ sender: UIStepper) {
        meatCount.text = Int(sender.value).description
        GlobalStates.meaties = meatCount.text!
        UserDefaults.standard.set(meatCount.text, forKey: "meatTotal")
        UserDefaults.standard.set(meatStepper.value, forKey: "meatStepped")
    }

    @IBAction func vegetableStepperChanged(_ sender: UIStepper) {
        vegetableCount.text = Int(sender.value).description
        GlobalStates.veggies = vegetableCount.text!
        UserDefaults.standard.set(vegetableCount.text, forKey: "vegetableTotal")
        UserDefaults.standard.set(vegetableStepper.value, forKey: "vegetableStepped")
    }

    @IBAction func dairyStepperChanged(_ sender: UIStepper) {
        dairyCount.text = Int(sender.value).description
        GlobalStates.dairies = dairyCount.text!
        UserDefaults.standard.set(dairyCount.text, forKey: "dairyTotal")
        UserDefaults.standard.set(dairyStepper.value, forKey: "dairyStepped")
    }

    @IBAction func fruitStepperChanged(_ sender: UIStepper) {
        fruitCount.text = Int(sender.value).description
        GlobalStates.fruities = fruitCount.text!
        UserDefaults.standard.set(fruitCount.text, forKey: "fruitTotal")
        UserDefaults.standard.set(fruitStepper.value, forKey: "fruitStepped")
    }

    @IBAction func grainsStepperChanged(_ sender: UIStepper) {
        grainsCount.text = Int(sender.value).description
        GlobalStates.grainies = grainsCount.text!
        UserDefaults.standard.set(grainsCount.text, forKey: "grainsTotal")
        UserDefaults.standard.set(grainsStepper.value, forKey: "grainsStepped")
    }

}

extension UserDefaults {
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}
