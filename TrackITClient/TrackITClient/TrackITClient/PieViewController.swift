//
//  DailyViewController.swift
//  TrackITClient
//
//  Created by user143897 on 7/28/18.
//  Copyright © 2018 Group 9. All rights reserved.
//

import UIKit
import Charts

class PieViewController: UIViewController {

    @IBOutlet weak var pieChart: PieChartView!
    
    @IBOutlet weak var todayLbl: UILabel!
    
    var grp1Data = PieChartDataEntry(value: 0)
    var grp2DaTa = PieChartDataEntry(value: 0)
    var grp3Data = PieChartDataEntry(value: 0)
    var grp4Data = PieChartDataEntry(value: 0)
    var grp5Data = PieChartDataEntry(value: 0)
    
    var dailyMealsEntry = [PieChartDataEntry]()
    var todaysValues = [String]()
    var currentDate = String()
    
    func currDateFormatter() -> String {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy"
        return dateformatter.string(from: date)
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        
        // set chart description
        pieChart.chartDescription?.text = "Servings of food groups consumed today"
        pieChart.chartDescription?.font = .systemFont(ofSize: 16)
        pieChart.legend.font = .systemFont(ofSize: 20)
        pieChart.legend.textColor = .black
        pieChart.holeColor = .white
    
        
        todaysValues.append(UserDefaults.standard.string(forKey: "meatTotal") ?? "0")
        todaysValues.append(UserDefaults.standard.string(forKey: "vegetableTotal") ?? "0")
        todaysValues.append(UserDefaults.standard.string(forKey: "fruitTotal") ?? "0")
        todaysValues.append(UserDefaults.standard.string(forKey: "dairyTotal") ?? "0")
        todaysValues.append(UserDefaults.standard.string(forKey: "grainsTotal") ?? "0")
        // checking if dailyVals has default value (no foods) or has foods
        
        
        
        grp1Data.value = Double(Int(todaysValues[0])!)
        grp1Data.label = "Meats"
        
        grp2DaTa.value = Double(Int(todaysValues[1])!)
        grp2DaTa.label = "Vegetables"
        
        grp3Data.value = Double(Int(todaysValues[2])!)
        grp3Data.label = "Fruits"
        
        grp4Data.value = Double(Int(todaysValues[3])!)
        grp4Data.label = "Dairy"
        
        grp5Data.value = Double(Int(todaysValues[4])!)
        grp5Data.label = "Grains"
       
        dailyMealsEntry = [grp1Data, grp2DaTa, grp3Data, grp4Data, grp5Data]
        updateChart()
    }
    
    func updateChart() {
        let chartDataSet = PieChartDataSet(values: dailyMealsEntry, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let color = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
        chartDataSet.colors = color
        
        pieChart.data = chartData
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCurrentDate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let str = formatter.string(from: Date())
        todayLbl.text? = str
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
