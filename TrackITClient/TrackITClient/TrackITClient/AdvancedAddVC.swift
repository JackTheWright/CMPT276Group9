//
//  AdvancedAddVC.swift
//  TrackITClient
//
//  Created by Jack Wright on 2018-07-05.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

var foodGroup = Int()
var foodText = String()
class AdvancedAddVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    static weak var viewController: viewControl!
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

        if foodGroup == 5 || foodGroup == 7 || foodGroup == 10 || foodGroup == 12 || foodGroup == 13 || foodGroup == 15 || foodGroup == 17{
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
        else if foodGroup == 16 || foodGroup == 11 {
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
        else if foodGroup == 9 {
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
        else if foodGroup == 1 {
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
        else if foodGroup == 8 || foodGroup == 18 || foodGroup == 20 {
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
        
        //set the foodID var to the foodID from the database array entry
        let foodID = autoCompletionPossibilities.first{ $0.foodname == foodText}?.foodid ?? 0
        //assign foodfortable to the array entry that is being accessed for the food being added
        GlobalStates.foodForTable = [FoodNutrition(foodname: foodText, foodIF: foodID, Multiplier: Int(anyCount.text!) ?? 0)]
        //getting whats in user defaults out so that we can append to the array
        if let current = UserDefaults.standard.data(forKey: "foodForTable") {
            GlobalStates.arr = current
        }
        //append the encoded struct to the already made array
        GlobalStates.arr += try! PropertyListEncoder().encode(GlobalStates.foodForTable)
        print(GlobalStates.arr)
        //set the foodForTable to the newly appended array
        UserDefaults.standard.set(GlobalStates.arr, forKey: "foodForTable")
        anyCount.text = "0"
        anyStepper.value = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advancedTextField.delegate = self
        advancedSuggestions.delegate = self
        
        anyStepper.wraps = false
        anyStepper.autorepeat = true
        anyStepper.maximumValue = 10
        
        
    }
    
    var autoComplete = [String]()
    var autoCompletionPossibilities = GlobalStates.foodnames

    var autoCompleteCharacterCount = 0
    var timer = Timer()
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        searchAutoCompleteEntriesWithSubstring(substring: substring.lowercased())
        
        return true
    }
    
    func searchAutoCompleteEntriesWithSubstring (substring: String) {
        
        print(autoCompletionPossibilities)
        autoComplete.removeAll(keepingCapacity: false)
        let mappy = autoCompletionPossibilities.map { $0.foodname.lowercased() }
        print(mappy)
        
        for keys in mappy {
            
            
            let myString:NSString! = keys as NSString
            let substringRange: NSRange! = myString.range(of: substring)
            
            if (substringRange.location == 0)
            {
                autoComplete.append(keys)
            }
            
        }
        advancedSuggestions.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let index = indexPath.row as Int
        cell.textLabel!.text = autoComplete[index]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = advancedSuggestions.cellForRow(at: indexPath)!
        let Label = selectedCell.textLabel
        advancedTextField.text = Label?.text
        foodText = advancedTextField.text!
        foodGroup = autoCompletionPossibilities.first{ $0.foodname.lowercased() == foodText.lowercased()}?.foodgroup ?? 0
        
        if foodGroup == 5 || foodGroup == 7 || foodGroup == 10 || foodGroup == 12 || foodGroup == 13 || foodGroup == 15 || foodGroup == 17{
            anyLabel.text = "Meat"
        }
        else if foodGroup == 16 || foodGroup == 11 {
            anyLabel.text = "Vegetables"
        }
        else if foodGroup == 9 {
            anyLabel.text = "Fruit"
        }
        else if foodGroup == 1 {
            anyLabel.text = "Dairy"
        }
        else if foodGroup == 8 || foodGroup == 18 || foodGroup == 20 {
            anyLabel.text = "Grains"
        }
        else {
            anyLabel.text = "Not available"
        }
        
        
    }
}
