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
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    
    let rec = recommend()
    
    
    @IBAction func anyStepped(_ sender: UIStepper) {
        anyCount.text = Int(sender.value).description
    }
    
    @IBAction func submitIt(_ sender: UIButton) {
        let transferFrom = Int(anyCount.text!)
        var transferTo = Int()
        let checkforAdd = UserDefaults.standard.bool(forKey: "FromAdd")
        
        if checkforAdd == true {
            
            if anyLabel.text == "Meat" {
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
            
            else if anyLabel.text == "Vegetables" {
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
            
            else if anyLabel.text == "Fruit" {
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
            
            else if anyLabel.text == "Dairy" {
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
            
            else {
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
            
            UserDefaults.standard.set(false, forKey: "FromAdd")
            
        }
        else {
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
        
            let foodID = autoCompletionPossibilities.first{ $0.foodname.lowercased() == foodText.lowercased()}?.foodid ?? 0
            //assign foodfortable to the array entry that is being accessed for the food being added
            GlobalStates.foodForTable[String(foodID)] = Int(anyCount.text!) ?? 0
            print(GlobalStates.foodForTable)
            //getting whats in user defaults out so that we can append to the array
            if let current = UserDefaults.standard.dictionary(forKey: "foodForTable") {
                GlobalStates.foodForTable.update(other: current as! Dictionary<String, Int>)
            }
            //set the foodForTable to the newly appended array
            UserDefaults.standard.set(GlobalStates.foodForTable, forKey: "foodForTable")
        }
        anyCount.text = "0"
        anyStepper.value = 0
        advancedTextField.text = ""
        anyLabel.text = "Food Group"
        
    }
    
    @IBAction func Add1(_ sender: UIButton){
        advancedTextField.text = label1.text
        anyLabel.text = GlobalStates.foodGroupyBoy1
        UserDefaults.standard.set(true, forKey: "FromAdd")
    }
    @IBAction func Add2(_ sender: UIButton){
        advancedTextField.text = label2.text
        anyLabel.text = GlobalStates.foodGroupyBoy2
        UserDefaults.standard.set(true, forKey: "FromAdd")

    }
    @IBAction func Add3(_ sender: UIButton){
        advancedTextField.text = label3.text
        anyLabel.text = GlobalStates.foodGroupyBoy3
        UserDefaults.standard.set(true, forKey: "FromAdd")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advancedTextField.delegate = self
        advancedSuggestions.delegate = self
        anyStepper.wraps = false
        anyStepper.autorepeat = true
        anyStepper.maximumValue = 10
        label1.text = ""
        label2.text = ""
        label3.text = ""
        
        button1.setTitle("", for: .normal)
        button2.setTitle("", for: .normal)
        button3.setTitle("", for: .normal)
        
        let recommendationArray = rec.recommendIt()
        let firstRec = recommendationArray[0]
        let secondRec = recommendationArray[1]
        var pick1: Array<String> = ["",""]
        var pick2: Array<String> = ["",""]
        
        
        
        switch firstRec {
        case "Meat":
            pick1 = rec.randomPickFrom(foodGroup: "Meat", otherindex: "192837")
            pick2 = rec.randomPickFrom(foodGroup: "Meat", otherindex: pick1[1])
            label1.text = pick1[0]
            label2.text = pick2[0]
            button1.setTitle("Add", for: .normal)
            button2.setTitle("Add", for: .normal)
            button1.backgroundColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            button2.backgroundColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            image1.image = #imageLiteral(resourceName: "2-0_meat")
            image2.image = #imageLiteral(resourceName: "2-0_meat")
            GlobalStates.foodGroupyBoy1 = "Meat"
            GlobalStates.foodGroupyBoy2 = "Meat"
        case "Vegetable":
            pick1 = rec.randomPickFrom(foodGroup: "Vegetable", otherindex: "192837")
            pick2 = rec.randomPickFrom(foodGroup: "Vegetable", otherindex: pick1[1])
            label1.text = pick1[0]
            label2.text = pick2[0]
            image1.image = #imageLiteral(resourceName: "2-0_veget")
            image2.image = #imageLiteral(resourceName: "2-0_veget")
            button1.setTitle("Add", for: .normal)
            button2.setTitle("Add", for: .normal)
            button1.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            button2.backgroundColor =  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            GlobalStates.foodGroupyBoy1 = "Vegetables"
            GlobalStates.foodGroupyBoy2 = "Vegetables"
        case "Fruit":
            pick1 = rec.randomPickFrom(foodGroup: "Fruit", otherindex: "192837")
            pick2 = rec.randomPickFrom(foodGroup: "Fruit", otherindex: pick1[1])
            label1.text = pick1[0]
            label2.text = pick2[0]
            image1.image = #imageLiteral(resourceName: "fruit")
            image2.image = #imageLiteral(resourceName: "fruit")
            button1.setTitle("Add", for: .normal)
            button2.setTitle("Add", for: .normal)
            button1.backgroundColor =  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            button2.backgroundColor =  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            GlobalStates.foodGroupyBoy1 = "Fruit"
            GlobalStates.foodGroupyBoy2 = "Fruit"
        case "Dairy":
            pick1 = rec.randomPickFrom(foodGroup: "Dairy", otherindex: "192837")
            pick2 = rec.randomPickFrom(foodGroup: "Dairy", otherindex: pick1[1])
            label1.text = pick1[0]
            label2.text = pick2[0]
            image1.image = #imageLiteral(resourceName: "2-0_milk-eng")
            image2.image = #imageLiteral(resourceName: "2-0_milk-eng")
            button1.setTitle("Add", for: .normal)
            button2.setTitle("Add", for: .normal)
            button1.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            button2.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            GlobalStates.foodGroupyBoy1 = "Dairy"
            GlobalStates.foodGroupyBoy2 = "Dairy"
        case "Grain":
            pick1 = rec.randomPickFrom(foodGroup: "Grain", otherindex: "192837")
            pick2 = rec.randomPickFrom(foodGroup: "Grain", otherindex: pick1[1])
            label1.text = pick1[0]
            label2.text = pick2[0]
            image1.image = #imageLiteral(resourceName: "2-0_grains")
            image2.image = #imageLiteral(resourceName: "2-0_grains")
            button1.setTitle("Add", for: .normal)
            button2.setTitle("Add", for: .normal)
            button1.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            button2.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            GlobalStates.foodGroupyBoy1 = "Grains"
            GlobalStates.foodGroupyBoy2 = "Grains"
        default:
            pick1 = rec.randomPickFrom(foodGroup: "Equal", otherindex: "192837")
            pick2 = rec.randomPickFrom(foodGroup: "Equal", otherindex: pick1[1])
            label1.text = pick1[0]
            label2.text = pick2[0]
            button1.setTitle("Add", for: .normal)
            button2.setTitle("Add", for: .normal)
            GlobalStates.foodGroupyBoy1 = pick1[2]
            GlobalStates.foodGroupyBoy2 = pick2[2]
            if GlobalStates.foodGroupyBoy1 == "Meat"{
                image1.image = #imageLiteral(resourceName: "2-0_meat")
                button1.backgroundColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

            }
            else if GlobalStates.foodGroupyBoy1 == "Vegetables" {
                image1.image = #imageLiteral(resourceName: "2-0_veget")
                button1.backgroundColor =  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)

            }
            else if GlobalStates.foodGroupyBoy1 == "Fruit" {
                image1.image = #imageLiteral(resourceName: "fruit")
                button1.backgroundColor =  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)

            }
            else if GlobalStates.foodGroupyBoy1 == "Dairy" {
                image1.image = #imageLiteral(resourceName: "2-0_milk-eng")
                button1.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

            }
            else {
                image1.image = #imageLiteral(resourceName: "2-0_grains")
                button1.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)

            }
            
            if GlobalStates.foodGroupyBoy2 == "Meat"{
                image2.image = #imageLiteral(resourceName: "2-0_meat")
                button2.backgroundColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            else if GlobalStates.foodGroupyBoy2 == "Vegetables" {
                image2.image = #imageLiteral(resourceName: "2-0_veget")
                button2.backgroundColor =  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                
            }
            else if GlobalStates.foodGroupyBoy2 == "Fruit" {
                image2.image = #imageLiteral(resourceName: "fruit")
                button2.backgroundColor =  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                
            }
            else if GlobalStates.foodGroupyBoy2 == "Dairy" {
                image2.image = #imageLiteral(resourceName: "2-0_milk-eng")
                button2.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

                
            }
            else {
                image2.image = #imageLiteral(resourceName: "2-0_grains")
                button2.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                
            }
        }
        switch secondRec {
        case "Meat":
            pick1 = rec.randomPickFrom(foodGroup: "Meat", otherindex: "192837")
            label3.text = pick1[0]
            image3.image = #imageLiteral(resourceName: "2-0_meat")
            button3.backgroundColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            button3.setTitle("Add", for: .normal)
            GlobalStates.foodGroupyBoy3 = "Meat"
        case "Vegetable":
            pick1 = rec.randomPickFrom(foodGroup: "Vegetable", otherindex: "192837")
            label3.text = pick1[0]
            image3.image = #imageLiteral(resourceName: "2-0_veget")
            button3.backgroundColor =  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            button3.setTitle("Add", for: .normal)
            GlobalStates.foodGroupyBoy3 = "Vegetables"
        case "Fruit":
            pick1 = rec.randomPickFrom(foodGroup: "Fruit", otherindex: "192837")
            label3.text = pick1[0]
            image3.image = #imageLiteral(resourceName: "fruit")
            button3.backgroundColor =  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            button3.setTitle("Add", for: .normal)
            GlobalStates.foodGroupyBoy3 = "Fruit"
        case "Dairy":
            pick1 = rec.randomPickFrom(foodGroup: "Dairy", otherindex: "192837")
            label3.text = pick1[0]
            image3.image = #imageLiteral(resourceName: "2-0_milk-eng")
            button3.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            button3.setTitle("Add", for: .normal)
            GlobalStates.foodGroupyBoy3 = "Dairy"
        case "Grain":
            pick1 = rec.randomPickFrom(foodGroup: "Grain", otherindex: "192837")
            label3.text = pick1[0]
            image3.image = #imageLiteral(resourceName: "2-0_grains")
            button3.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            button3.setTitle("Add", for: .normal)
            GlobalStates.foodGroupyBoy3 = "Grains"
        default:
            pick1 = rec.randomPickFrom(foodGroup: "Equal", otherindex: "192837")
            label3.text = pick1[0]
            button3.setTitle("Add", for: .normal)
            GlobalStates.foodGroupyBoy3 = pick1[2]
            if GlobalStates.foodGroupyBoy3 == "Meat"{
                image3.image = #imageLiteral(resourceName: "2-0_meat")
                button3.backgroundColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            else if GlobalStates.foodGroupyBoy3 == "Vegetable" {
                image3.image = #imageLiteral(resourceName: "2-0_veget")
                button3.backgroundColor =  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)

            }
            else if GlobalStates.foodGroupyBoy3 == "Fruit" {
                image3.image = #imageLiteral(resourceName: "fruit")
                button3.backgroundColor =  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            }
            else if GlobalStates.foodGroupyBoy3 == "Dairy" {
                image3.image = #imageLiteral(resourceName: "2-0_milk-eng")
                button3.backgroundColor =  #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                
            }
            else {
                image3.image = #imageLiteral(resourceName: "2-0_grains")
                button3.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                
            }
        }
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
        
        
        autoComplete.removeAll(keepingCapacity: false)
        let mappy = autoCompletionPossibilities.map { $0.foodname.lowercased() }
        
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

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
