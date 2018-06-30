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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                meatStepper.wraps = false
                meatStepper.autorepeat = true
                meatStepper.maximumValue = 15

                vegetableStepper.wraps = false
                vegetableStepper.autorepeat = true
                vegetableStepper.maximumValue = 15

                fruitStepper.wraps = false
                fruitStepper.autorepeat = true
                fruitStepper.maximumValue = 15

                dairyStepper.wraps = false
                dairyStepper.autorepeat = true
                dairyStepper.maximumValue = 15

                grainsStepper.wraps = false
                grainsStepper.autorepeat = true
                grainsStepper.maximumValue = 15
        
        

//        let daydict:[String:[String]]
//        UserDefaults.standard.set(daydict, forKey: "daydict")
//        if GlobalStates.quickAddRefresh == false {
//             let yesterday = time.getYesterdaysDate()
//            daydict = package.packageItemsWithDate(date: yesterday, meat: meatCount.text!, vegetable: vegetableCount.text!, fruit: fruitCount.text!, dairy: dairyCount.text!, grains: grainsCount.text!)
//        }
        
        meatCount.text = UserDefaults.standard.string(forKey: "meatTotal")
        vegetableCount.text = UserDefaults.standard.string(forKey: "vegetableTotal")
        fruitCount.text = UserDefaults.standard.string(forKey: "fruitTotal")
        dairyCount.text = UserDefaults.standard.string(forKey: "dairyTotal")
        grainsCount.text = UserDefaults.standard.string(forKey: "grainsTotal")
        
        if GlobalStates.quickAddRefresh == false {
            //let yesterday = time.getYesterdaysDate()
       
            meatCount.text = "0"
            vegetableCount.text = "0"
            fruitCount.text = "0"
            dairyCount.text = "0"
            grainsCount.text = "0"
            GlobalStates.quickAddRefresh = true
            
            
        }
            
    }

    
    
    

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


            @IBAction func meatStepperChanged(_ sender: UIStepper) {
                meatCount.text = Int(sender.value).description
                UserDefaults.standard.set(meatCount.text, forKey: "meatTotal")
            }

            @IBAction func vegetableStepperChanged(_ sender: UIStepper) {
                vegetableCount.text = Int(sender.value).description
                UserDefaults.standard.set(vegetableCount.text, forKey: "vegetableTotal")
            }

            @IBAction func dairyStepperChanged(_ sender: UIStepper) {
                dairyCount.text = Int(sender.value).description
                UserDefaults.standard.set(dairyCount.text, forKey: "dairyTotal")
            }

            @IBAction func fruitStepperChanged(_ sender: UIStepper) {
                fruitCount.text = Int(sender.value).description
                UserDefaults.standard.set(fruitCount.text, forKey: "fruitTotal")
            }

            @IBAction func grainsStepperChanged(_ sender: UIStepper) {
                grainsCount.text = Int(sender.value).description
                UserDefaults.standard.set(grainsCount, forKey: "grainsTotal")
            }

}
