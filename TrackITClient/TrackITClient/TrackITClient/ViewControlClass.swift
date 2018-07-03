//
//  ViewControlClass.swift
//  FoodMenu
//
//  Created by Jack Wright on 2018-06-27.
//  Copyright © 2018 Jack Wright. All rights reserved.
//

import UIKit

class viewControl: UIViewController {
    
    let package = ServingPackage()
    let time = DateAttributes()
    

    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
        let quickAddRefresh = UserDefaults.standard.bool(forKey: "checkToSeeIfLastAccessWasYesterday")
        
        
        if quickAddRefresh == false {
            //let yesterday = time.getYesterdaysDate()
            meatCount.text = "0"
            vegetableCount.text = "0"
            fruitCount.text = "0"
            dairyCount.text = "0"
            grainsCount.text = "0"
            meatStepper.value = 0
            vegetableStepper.value = 0
            fruitStepper.value = 0
            dairyStepper.value = 0
            grainsStepper.value = 0
            
            UserDefaults.standard.set(true, forKey: "checkToSeeIfLastAccessWasYesterday")
        }
        
    }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//  When the view loads, we setup the steppers default setting and make sure their values are exactly the same as when the app closed using the userdefaults. We make sure the stepper doesnt wrap and autorepeats and that the user can't press it more than 15 times.
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
            dayDic = package.packageItemsWithDate(date: yesterday, meat: meatCount.text!, vegetable: vegetableCount.text!, fruit: fruitCount.text!, dairy: dairyCount.text!, grains: grainsCount.text!)
            UserDefaults.standard.set(dayDic, forKey: yesterday)
          
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
