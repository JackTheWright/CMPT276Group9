//
//  RadarViewController.swift
//  TrackITClient
//
//  Created by user143897 on 7/30/18.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit
import Charts

class RadarViewController: UIViewController {
    
    @IBOutlet weak var todayLbl: UILabel!
    
    @IBOutlet weak var radarChart: RadarChartView!
    
    var grp1Data = RadarChartDataEntry(value: 0)
    var grp2DaTa = RadarChartDataEntry(value: 0)
    var grp3Data = RadarChartDataEntry(value: 0)
    var grp4Data = RadarChartDataEntry(value: 0)
    var grp5Data = RadarChartDataEntry(value: 0)
    
    var dailyMealsEntry = [RadarChartDataEntry]()
    var todaysValues = [String]()
    var valuesDic = [String : [String]]()
    var currentDate = String()
    var dailyVals = UserDefaults.standard.dictionary(forKey: "dailyEntries") as? [String : [String : [String]]] ?? ["" : ["" : ["0","0","0","0","0"]]]
    
    func currDateFormatter() -> String {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-mm-yyyy"
        return dateformatter.string(from: date)
    }
    
    
    func getCurrentDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let str = formatter.string(from: Date())
        todayLbl.text?.append(str)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set chart description
        radarChart.chartDescription?.text = "Servings of different food groups consumed today :"
        radarChart.chartDescription?.textColor = .white
        radarChart.legend.textColor = .white
        
        
        
        // checking if dailyVals has default value (no foods) or has foods
        if dailyVals !=  ["" : ["" : ["0","0","0","0","0"]]] {
            // extract the dictionaries
            for each in dailyVals {
                valuesDic.update(other: each.value)
            }
            
            // get current date in appropiate string format
            currentDate = currDateFormatter()
            
            // check which entry is for current date
            for each in valuesDic {
                if each.key == currentDate {
                    // assign the values for servings of each foodgroup
                    todaysValues = each.value
                    break
                }
            }
        }
            
        else {
            todaysValues = ["1","2","2","3","4"]
        }
        
        
        grp1Data.value = Double(Int(todaysValues[0])!)

        
        grp2DaTa.value = Double(Int(todaysValues[1])!)
   //     grp2DaTa.label = "Vegetables"
        
        grp3Data.value = Double(Int(todaysValues[2])!)
    //    grp3Data.label = "Fruits"
        
        grp4Data.value = Double(Int(todaysValues[3])!)
    //    grp4Data.label = "Dairy"
        
        grp5Data.value = Double(Int(todaysValues[4])!)
     //   grp5Data.label = "Grains"
        
        dailyMealsEntry = [grp1Data, grp2DaTa, grp3Data, grp4Data, grp5Data]
        updateChart()
        radarChart.legend.textColor = .white
    }
    
    func updateChart() {
        let chartDataSet = RadarChartDataSet(values: dailyMealsEntry, label: nil)
        let chartData = RadarChartData(dataSet: chartDataSet)
        
        let color = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.yellow, UIColor.blue]
        chartDataSet.colors = color
        
        radarChart.data = chartData
        
    }

    

    override func viewDidAppear(_ animated: Bool) {
        getCurrentDate()
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
