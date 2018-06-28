//
//  ViewControlClass.swift
//  FoodMenu
//
//  Created by Jack Wright on 2018-06-27.
//  Copyright © 2018 Jack Wright. All rights reserved.
//

import UIKit

class viewControl: UIViewController {
    
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
            }

            @IBAction func vegetableStepperChanged(_ sender: UIStepper) {
                vegetableCount.text = Int(sender.value).description
            }

            @IBAction func dairyStepperChanged(_ sender: UIStepper) {
                dairyCount.text = Int(sender.value).description
            }

            @IBAction func fruitStepperChanged(_ sender: UIStepper) {
                fruitCount.text = Int(sender.value).description
            }

            @IBAction func grainsStepperChanged(_ sender: UIStepper) {
                grainsCount.text = Int(sender.value).description
            }

}
