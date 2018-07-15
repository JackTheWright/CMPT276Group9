//
//  AdvacnedStatsViewController.swift
//  TrackITClient
//
//  Created by Manan Pahwa on 2018-07-14.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var data = [String : Double]()
}


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
    
    var nutrients : [String : [String : Double]] = [ "Apple" : ["protein" : 1 , "carbs" : 2 , "fats" : 3] , "Banana" : ["protein" : 1 , "carbs" : 2 , "fats" : 3]]
    
   var tableViewData = [cellData]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].data.count + 7
        }
        else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return(nutrients.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.backgroundColor = UIColor.white
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Protein: \(tableViewData[indexPath.section].data["protein"] ?? 0) grams"
            cell.backgroundColor = UIColor.yellow
            return cell
        }
        else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Carbohydrates: \(tableViewData[indexPath.section].data["carbs"] ?? 0) grams"
            cell.backgroundColor = UIColor.yellow
            return cell
        }
        else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Fats: \(tableViewData[indexPath.section].data["fats"] ?? 0) grams"
            cell.backgroundColor = UIColor.yellow
            return cell
        }
        else if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Magnesium: \(tableViewData[indexPath.section].data["magnesium"] ?? 0) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else if indexPath.row == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Vitamin B9: \(tableViewData[indexPath.section].data["vitB9"] ?? 0) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else if indexPath.row == 6 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Vitamin D: \((tableViewData[indexPath.section].data["vitD"] ?? 0)*0.025) micrograms"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else if indexPath.row == 7 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Iron: \(tableViewData[indexPath.section].data["iron"] ?? 0) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else if indexPath.row == 8 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Potassium: \(tableViewData[indexPath.section].data["potassium"] ?? 0) milligrams"
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = "Sodium: \(tableViewData[indexPath.section].data["sodium"] ?? 0) milligrams"
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
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let nutrientdata = nutrients["Apple"]
        {
            tableViewData.append(cellData(opened: false, title: "Apple", data: nutrientdata))
        }
        
        if let nutrientdata = nutrients["Banana"] {
            tableViewData.append(cellData(opened: false, title: "Banana", data: nutrientdata))
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
