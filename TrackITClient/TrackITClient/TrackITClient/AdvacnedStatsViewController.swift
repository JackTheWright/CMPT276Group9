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

func makeInterface(foodID: Int) -> [Double] {
    let interface = NetworkInterface()!
    interface.setTimeout(5)
    var response = JSON()
    interface.connect(to: "app.trackitdiet.com", on: 60011) { host in
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

func foodToCount(food: [FoodNutrition]) -> Int {
    return food.count
}

//static var foodfortable = [(foodName: String , foodID: Int , multiplier: Int)]()
func foodToFoodDic( food: [FoodNutrition]) -> [Int : (String , Int)] {
    var dic = [Int : (String , Int) ]()
    for elem in food {
        dic[elem.foodID] = (elem.foodname , elem.Multiplier)
    }
    return dic
}

func foodToMultiplier( food:[FoodNutrition] )-> [Int] {
    var multiplierArray = [Int]()
    for elem in food {
        multiplierArray.append(elem.Multiplier)
    }
    return multiplierArray
}

func foodToName( food:[FoodNutrition]) -> [String] {
    var nameArray = [String]()
    for elem in food {
        nameArray.append(elem.foodname)
    }
    return nameArray
}

func foodToFoodID( food: [FoodNutrition]) -> [Int] {
    var foodIDArray = [Int]()
    for elem in food {
        foodIDArray.append(elem.foodID)
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
        
        func appendUnits(label: UILabel, unit: String) {
            var text = label.text
            text = text! + " " + unit
            label.text = text
        }
        
        let food: [FoodNutrition]?
        
        if let foodData = UserDefaults.standard.data(forKey: "foodForTable") {
            food = try? PropertyListDecoder().decode([FoodNutrition].self, from: foodData)
        } else {
            food = nil
        }
        
        if food == nil {


            proteinAmt.text = String(0)
            appendUnits(label: proteinAmt, unit: "grams")
            
            fatAmt.text = String(0)
            appendUnits(label: fatAmt, unit: "grams")
            
            carbAmt.text = String(0)
            appendUnits(label: carbAmt, unit: "grams")
            
            mgAmt.text = String(0)
            appendUnits(label: mgAmt, unit: "milligrams")
            
            vitB9Amt.text = String(0)
            appendUnits(label: vitB9Amt, unit: "milligrams")
            
            vitDAmt.text = String(0)
            appendUnits(label: vitDAmt, unit: "micrograms")
            
            ironAmt.text = String(0)
            appendUnits(label: ironAmt, unit: "milligrams")
            
            potassiumAmt.text = String(0)
            appendUnits(label: potassiumAmt, unit: "milligrams")
            
            sodiumAmt.text = String(0)
            appendUnits(label: sodiumAmt, unit: "milligrams")
        }
        else {
        //   var foodDic = foodToFoodDic(food: food)
        let foodname = foodToName(food: food!)
        if !foodname.isEmpty {
            var i = 0
            var foodIDA = foodToFoodID(food: food!)
            for _ in foodname {
                tableViewData.append(cellData(opened: false, title: foodname[i], data: makeInterface(foodID: foodIDA[i])))
                i = i + 1
            }
        }
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        var nutrients = [Double]()
        var servings = foodToMultiplier(food: food!)
        var foodID = foodToFoodID(food: food!)
        
        func totalNutritents(foodID: [Int], servings: [Int]) -> [Double] {
            let count = foodID.count
            if count != 0 {
                var totNutri = [Double]()
                var sum: Double = 0
                for i in 0...(count-1) {
                    sum = 0
                    let multiplier = servings[i]
                    let nutrients = makeInterface(foodID: foodID[i])
                    for n in nutrients {
                        sum = sum + (n * Double(multiplier))
                    }
                    totNutri.append(sum)
                }
                return totNutri
            }
            else {
                return [0,0,0,0,0,0,0,0,0]
            }
        }
        
        
        
        nutrients = totalNutritents(foodID: foodID, servings: servings)
        UserDefaults.standard.set(nutrients, forKey: "totalNutrients")
        
        proteinAmt.text = String(nutrients[0])
        appendUnits(label: proteinAmt, unit: "grams")
        
        fatAmt.text = String(nutrients[1])
        appendUnits(label: fatAmt, unit: "grams")
        
        carbAmt.text = String(nutrients[2])
        appendUnits(label: carbAmt, unit: "grams")
        
        mgAmt.text = String(nutrients[4])
        appendUnits(label: mgAmt, unit: "milligrams")
        
        vitB9Amt.text = String(nutrients[7])
        appendUnits(label: vitB9Amt, unit: "milligrams")
        
        vitDAmt.text = String(nutrients[8])
        appendUnits(label: vitDAmt, unit: "micrograms")
        
        ironAmt.text = String(nutrients[3])
        appendUnits(label: ironAmt, unit: "milligrams")
        
        potassiumAmt.text = String(nutrients[5])
        appendUnits(label: potassiumAmt, unit: "milligrams")
        
        sodiumAmt.text = String(nutrients[6])
        appendUnits(label: sodiumAmt, unit: "milligrams")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createAlert(title: "Alert", message: "There is no data currently stored. This is a bug")
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
