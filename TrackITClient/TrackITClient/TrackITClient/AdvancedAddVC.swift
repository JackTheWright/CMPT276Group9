//
//  AdvancedAddVC.swift
//  TrackITClient
//
//  Created by Jack Wright on 2018-07-05.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit
import NetConnect

var foodGroup = Int()

class AdvancedAddVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    static weak var viewController: viewControl!
    let netinterface = NetworkInterface()!
    @IBOutlet weak var advancedTextField: UITextField!
    @IBOutlet weak var advancedSuggestions: UITableView!
    @IBOutlet weak var anyStepper: UIStepper!
    @IBOutlet weak var anyLabel: UILabel!
    @IBOutlet weak var anyCount: UILabel!
    @IBOutlet weak var submit: UIButton!
    
    
    @IBAction func anyStepped(_ sender: UIStepper) {
        anyCount.text = Int(sender.value).description
    }
    
    @IBAction func submitIt(_ sender: UIButton) {
        let transferFrom = Int(anyCount.text!)
        var transferTo = Int()
        netinterface.connect(to: "app.trackitdiet.com", on: 60011) { host in
            try host.send("yeet")
            let reply = try host.receiveString()
            print(reply)
        }
        if foodGroup == 1 {
            transferTo = Int(UserDefaults.standard.string(forKey: "meatTotal")!)!
            let meat = transferFrom! + UserDefaults.standard.integer(forKey: "meatStepped")
            UserDefaults.standard.set(meat, forKey: "meatStepped")
            transferTo += transferFrom!
            if transferTo > 15 {
                transferTo = 15
            }
            UserDefaults.standard.set(transferTo, forKey: "meatTotal")
            AdvancedAddVC.viewController.meatCount.text = UserDefaults.standard.string(forKey: "meatTotal")
            AdvancedAddVC.viewController.meatStepper.value = UserDefaults.standard.double(forKey: "meatStepped")

        }
        else if foodGroup == 2 {
            transferTo = Int(UserDefaults.standard.string(forKey: "vegetableTotal")!)!
            let veg = transferFrom! + UserDefaults.standard.integer(forKey: "vegetableStepped")
            UserDefaults.standard.set(veg, forKey: "vegetableStepped")
            transferTo += transferFrom!
            if transferTo > 15 {
                transferTo = 15
            }
            UserDefaults.standard.set(transferTo, forKey: "vegetableTotal")
            AdvancedAddVC.viewController.vegetableCount.text = UserDefaults.standard.string(forKey: "vegetableTotal")
            AdvancedAddVC.viewController.vegetableStepper.value = UserDefaults.standard.double(forKey: "vegetableStepped")
            

        }
        else if foodGroup == 3 {
            transferTo = Int(UserDefaults.standard.string(forKey: "fruitTotal")!)!
            let fruit = transferFrom! + UserDefaults.standard.integer(forKey: "fruitStepped")
            UserDefaults.standard.set(fruit, forKey: "fruitStepped")
            transferTo += transferFrom!
            if transferTo > 15 {
                transferTo = 15
            }
            UserDefaults.standard.set(transferTo, forKey: "fruitTotal")
            AdvancedAddVC.viewController.fruitCount.text = UserDefaults.standard.string(forKey: "fruitTotal")
            AdvancedAddVC.viewController.fruitStepper.value = UserDefaults.standard.double(forKey: "fruitStepped")
        }
        else if foodGroup == 4 {
            transferTo = Int(UserDefaults.standard.string(forKey: "dairyTotal")!)!
            let dairy = transferFrom! + UserDefaults.standard.integer(forKey: "dairyStepped")
            UserDefaults.standard.set(dairy, forKey: "dairyStepped")
            transferTo += transferFrom!
            if transferTo > 15 {
                transferTo = 15
            }
            UserDefaults.standard.set(transferTo, forKey: "dairyTotal")
            AdvancedAddVC.viewController.dairyCount.text = UserDefaults.standard.string(forKey: "dairyTotal")
            AdvancedAddVC.viewController.dairyStepper.value = UserDefaults.standard.double(forKey: "dairyStepped")

        }
        else if foodGroup == 5 {
            transferTo = Int(UserDefaults.standard.string(forKey: "grainsTotal")!)!
            let grains = transferFrom! + UserDefaults.standard.integer(forKey: "grainsStepped")
            UserDefaults.standard.set(grains, forKey: "grainsStepped")
            transferTo += transferFrom!
            if transferTo > 15 {
                transferTo = 15
            }
            UserDefaults.standard.set(transferTo, forKey: "grainsTotal")
            AdvancedAddVC.viewController.grainsCount.text = UserDefaults.standard.string(forKey: "grainsTotal")
            AdvancedAddVC.viewController.grainsStepper.value = UserDefaults.standard.double(forKey: "grainsStepped")
        }

        anyCount.text = "0"
        anyStepper.value = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
   
    
    var autoCompletionPossibilities = ["Apple", "Pineapple", "Orange"]
    var autoCompleteCharacterCount = 0
    var timer = Timer()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = advancedSuggestions.cellForRow(at: indexPath)!
        let Label = selectedCell.textLabel
        advancedTextField.text = Label?.text
        let Teext = advancedTextField.text
        foodGroup = autoCompletionPossibilities[Teext!]!
        if foodGroup == 1 {
            anyLabel.text = "Meat"
        }
        if foodGroup == 2 {
            anyLabel.text = "Vegetables"
        }
        if foodGroup == 3 {
            anyLabel.text = "Fruit"
        }
        if foodGroup == 4 {
            anyLabel.text = "Dairy"
        }
        if foodGroup == 5 {
            anyLabel.text = "Grains"
        }
        
        
    }
}
