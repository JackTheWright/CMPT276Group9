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
        
        
        meatStepper.value = Double(GlobalStates.meaties)!
        vegetableStepper.value = Double(GlobalStates.veggies)!
        fruitStepper.value = Double(GlobalStates.fruities)!
        dairyStepper.value = Double(GlobalStates.dairies)!
        grainsStepper.value = Double(GlobalStates.grainies)!
        
        
        let quickAddRefresh = UserDefaults.standard.bool(forKey: "checkToSeeIfLastAccessWasYesterday")
        
        
        if quickAddRefresh == false {
            //let yesterday = time.getYesterdaysDate()
            print("yeet")
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
        
        
                meatStepper.wraps = false
                meatStepper.autorepeat = true
                meatStepper.maximumValue = 15
                meatCount.text = GlobalStates.meaties

                vegetableStepper.wraps = false
                vegetableStepper.autorepeat = true
                vegetableStepper.maximumValue = 15
                vegetableCount.text = GlobalStates.veggies

                fruitStepper.wraps = false
                fruitStepper.autorepeat = true
                fruitStepper.maximumValue = 15
                fruitCount.text = GlobalStates.fruities

                dairyStepper.wraps = false
                dairyStepper.autorepeat = true
                dairyStepper.maximumValue = 15
                dairyCount.text = GlobalStates.dairies

                grainsStepper.wraps = false
                grainsStepper.autorepeat = true
                grainsStepper.maximumValue = 15
                grainsCount.text = GlobalStates.grainies
        
        
        
        let quickAddRefresh = UserDefaults.standard.bool(forKey: "checkToSeeIfLastAccessWasYesterday")
        var dayDic = Dictionary<String,[String]>()
        if quickAddRefresh == false {
             let yesterday = time.getYesterdaysDate()
            dayDic = package.packageItemsWithDate(date: yesterday, meat: meatCount.text!, vegetable: vegetableCount.text!, fruit: fruitCount.text!, dairy: dairyCount.text!, grains: grainsCount.text!)
            UserDefaults.standard.set(dayDic, forKey: yesterday)
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
                GlobalStates.meaties = meatCount.text!
               UserDefaults.standard.set(meatCount.text, forKey: "meatTotal")
            }

            @IBAction func vegetableStepperChanged(_ sender: UIStepper) {
                vegetableCount.text = Int(sender.value).description
                GlobalStates.veggies = vegetableCount.text!
                UserDefaults.standard.set(vegetableCount.text, forKey: "vegetableTotal")
            }

            @IBAction func dairyStepperChanged(_ sender: UIStepper) {
                dairyCount.text = Int(sender.value).description
                GlobalStates.dairies = dairyCount.text!
                UserDefaults.standard.set(dairyCount.text, forKey: "dairyTotal")
            }

            @IBAction func fruitStepperChanged(_ sender: UIStepper) {
                fruitCount.text = Int(sender.value).description
                GlobalStates.fruities = fruitCount.text!
                UserDefaults.standard.set(fruitCount.text, forKey: "fruitTotal")
            }

            @IBAction func grainsStepperChanged(_ sender: UIStepper) {
                grainsCount.text = Int(sender.value).description
                GlobalStates.grainies = grainsCount.text!
                UserDefaults.standard.set(grainsCount, forKey: "grainsTotal")
            }

}
