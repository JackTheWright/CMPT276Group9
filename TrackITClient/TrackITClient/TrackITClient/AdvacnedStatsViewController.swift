//
//  AdvacnedStatsViewController.swift
//  TrackITClient
//
//  Created by Manan Pahwa on 2018-07-14.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit
import NetConnect
import SwiftyJSON
import Foundation


struct cellData {
    var opened = Bool()
    var title = String()
    //   var id = Int()
    var data = [Double]()
    //  mutating func setData(ID: Int) {
    //      data = makeInterface(foodID: ID)!
    //  }
}

// get Nutrients
func getNutrients(foodID: Int) -> [Double] {
    let interface = NetworkInterface()!
    interface.setTimeout(5)
    var response = JSON()
    interface.connect(to: "app.trackitdiet.com", on: GlobalStates.port) { host in
        var flag = Message.Flags()
        flag.set(MessageFlags.SpecialRequest)
        try host.send(SpecialRequests.getNutrients(for: foodID), flags: flag)
        let reply = try host.receiveJSON()
        response = reply
    }
    if let array = response.dictionary?["NUTRIENTVALUE"]?.array?.compactMap ({ $0.double }) {
        return array
    }
    else {
        return [Double]()
    }
}
// Getting food name
public func getFoodDescription(foodID: Int) -> String? {
    let interface = NetworkInterface()!
    interface.setTimeout(5)
    var response = JSON()
    interface.connect(to: "app.trackitdiet.com", on: GlobalStates.port) {host in
        var flag = Message.Flags()
        flag.set(MessageFlags.DBQuery)
        try host.send("select foodDescription from 'food name' where foodid = \(foodID);", flags: flag)
        let reply = try host.receiveJSON()
        // print(reply)
        response = reply
        }
    if let array = response.array {
        return array.first?.dictionary?["FOODDESCRIPTION"]?.string
    } else {
        return nil
    }
}

//static var foodForTable = [String: Int]()

// count of foods in fooddata from advanced add
func foodToCount(food: [String: Int]) -> Int {
    return food.count
}

// residue code (RC)
//func foodToFoodDic( food: [FoodNutrition]) -> [Int : (String , Int)] {
//    var dic = [Int : (String , Int) ]()
//    for elem in food {
//        dic[elem.foodID] = (elem.foodname , elem.Multiplier)
//    }
//    return dic
//}

// getting dictionary and extracting servings
func foodToServings( food: [String : Int] )-> [Int] {
    var multiplierArray = [Int]()
    for elem in food {
        multiplierArray.append(elem.value)
    }
    return multiplierArray
}

func stringToInt(str: String?) -> Int {
    if str == nil {
        return 0
    }
    else {
        let integer = Int(str!)
        return integer!
    }
   
}

// getting dictionary and then getting corresponding food names in array
func foodIDToName(food:[String: Int]) -> [String] {
    var nameArray = [String]()
    for elem in food {
            nameArray.append(getFoodDescription(foodID: stringToInt(str: elem.key))!)
    }
    return nameArray
}

// getting dictionary and getting foodId in array
func foodToFoodID( food: [String: Int]) -> [Int] {
   var foodIDArray = [Int]()
   for elem in food {
    foodIDArray.append(Int(elem.key)!)
   }
   return foodIDArray
}


//let foodData = UserDefaults.standard.data(forKey: "foodForTable")!
//let food = try? PropertyListDecoder().decode([FoodNutrition].self, from: foodData)

class AdvacnedStatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var proteinAmt: UILabel!
    @IBOutlet weak var carbAmt: UILabel!
    @IBOutlet weak var fatAmt: UILabel!
    @IBOutlet weak var mgAmt: UILabel!
    @IBOutlet weak var vitB9Amt: UILabel!
    @IBOutlet weak var vitDAmt: UILabel!
    @IBOutlet weak var ironAmt: UILabel!
    @IBOutlet weak var potassiumAmt: UILabel!
    @IBOutlet weak var sodiumAmt: UILabel!
    
    var tableViewData = [cellData]()
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData.count > 0 && tableViewData[section].opened == true {
            return tableViewData[section].data.count + 7
        }
        else {
            return 1
        }
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if food != nil {
//            return food!.count
//        }
//        else {
//            return 0
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard tableViewData.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.backgroundColor = UIColor.white
            return cell
        }
        else if indexPath.row == 1 {
            guard tableViewData.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Protein: \(tableViewData[indexPath.section].data[0] ) grams"
            cell.backgroundColor = UIColor.yellow
            return cell
        }
        else if indexPath.row == 2 {
            guard tableViewData.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Carbohydrates: \(tableViewData[indexPath.section].data[2] ) grams"
            cell.backgroundColor = UIColor.yellow
            return cell
        }
        else if indexPath.row == 3 {
            guard tableViewData.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Fats: \(tableViewData[indexPath.section].data[1]) grams"
            cell.backgroundColor = UIColor.yellow
            return cell
        }
        else if indexPath.row == 4 {
            guard tableViewData.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Magnesium: \(tableViewData[indexPath.section].data[4]) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else if tableViewData.count > 0, indexPath.row == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Vitamin B9: \(tableViewData[indexPath.section].data[7]) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else if tableViewData.count > 0, indexPath.row == 6 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Vitamin D: \((tableViewData[indexPath.section].data[8])*0.025) micrograms"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else if tableViewData.count > 0, indexPath.row == 7 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Iron: \(tableViewData[indexPath.section].data[3]) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else if tableViewData.count > 0, indexPath.row == 8 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Potassium: \(tableViewData[indexPath.section].data[5]) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else {
            guard tableViewData.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Sodium: \(tableViewData[indexPath.section].data[6]) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
    func createAlert (title : String, message:String){
        let alert = UIAlertController (title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in }))
        self.present(alert, animated:true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // createAlert(title: "Alert", message: "There is no data currently stored. This is a bug")
        
        func appendUnits(label: UILabel, unit: String) {
            if var text = label.text {
                text = text + " " + unit
                label.text = text
            }
            else {
                label.text = String(0) + " " + unit
            }
        }
        
        var food = [String: Int]()
        
        if UserDefaults.standard.dictionary(forKey: "foodForTable") != nil {
            food = UserDefaults.standard.dictionary(forKey: "foodForTable") as! [String : Int]
            let foodname = foodIDToName(food: food)
            if !foodname.isEmpty {
                //set table cells
                var foodIDArray = foodToFoodID(food: food)
                for i in 0...(foodname.count - 1) {
                    tableViewData.append(cellData(opened: false, title: foodname[i], data: getNutrients(foodID: foodIDArray[i])))
                }
            }
            
            var nutrients = [Double]()
            let servings = foodToServings(food: food)
            var totalNutrientsCount = [Double]()
            let foodIDArray = foodToFoodID(food: food)
            totalNutrientsCount = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            
            for i in 0...(foodIDArray.count - 1) {
                nutrients = getNutrients(foodID: foodIDArray[i])
                let multiplier = Double(servings[i])
                for j in 0...8 {
                    totalNutrientsCount[j] = totalNutrientsCount[j] + (multiplier * nutrients[j])
                }
            }
            
            proteinAmt.text = String(totalNutrientsCount[0])
            appendUnits(label: proteinAmt, unit: "grams")
            
            fatAmt.text = String(totalNutrientsCount[1])
            appendUnits(label: fatAmt, unit: "grams")
            
            carbAmt.text = String(totalNutrientsCount[2])
            appendUnits(label: carbAmt, unit: "grams")
            
            mgAmt.text = String(totalNutrientsCount[4])
            appendUnits(label: mgAmt, unit: "milligrams")
            
            vitB9Amt.text = String(totalNutrientsCount[7])
            appendUnits(label: vitB9Amt, unit: "milligrams")
            
            vitDAmt.text = String(totalNutrientsCount[8])
            appendUnits(label: vitDAmt, unit: "micrograms")
            
            ironAmt.text = String(totalNutrientsCount[3])
            appendUnits(label: ironAmt, unit: "milligrams")
            
            potassiumAmt.text = String(totalNutrientsCount[5])
            appendUnits(label: potassiumAmt, unit: "milligrams")
            
            sodiumAmt.text = String(totalNutrientsCount[6])
            appendUnits(label: sodiumAmt, unit: "milligrams")
        }
        else {
           
            proteinAmt.text = String(0.0)
            appendUnits(label: proteinAmt, unit: "grams")
            
            carbAmt.text = String(0.0)
            appendUnits(label: carbAmt, unit: "grams")
            
            fatAmt.text = String(0.0)
            appendUnits(label: carbAmt, unit: "grams")
            
            mgAmt.text = String(0.0)
            appendUnits(label: mgAmt, unit: "milligrams")
            
            vitB9Amt.text = String(0.0)
            appendUnits(label: vitB9Amt, unit: "miligrams")
            
            vitDAmt.text = String(0.0)
            appendUnits(label: vitDAmt, unit: "micrograms")
            
            ironAmt.text = String(0.0)
            appendUnits(label: ironAmt, unit: "milligrams")
            
            potassiumAmt.text = String(0.0)
            appendUnits(label: ironAmt, unit: "milligrams")
            
            sodiumAmt.text = String(0.0)
            appendUnits(label: sodiumAmt, unit: "milligrams")
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
