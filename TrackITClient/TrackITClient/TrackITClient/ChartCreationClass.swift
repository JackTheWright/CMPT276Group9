//
// File         : ChartCreationClass.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jack Wright
// Created On   : 2018-07-02
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
//

import Foundation
import UIKit

class barChartView: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
//  Connect the basic chart to a variable chart.
    @IBOutlet weak var chart: BasicBarChart!

    //  When the view is about to appear, we will set the data entries variable to an array made by the userdefaults for the food servings. This array contains: height, the servings value, a count, and a title. It then creates the chart with these entries
    override func viewWillAppear(_ animated: Bool) {
        let dataEntries = generateDataEntries()
        
        chart.dataEntries = dataEntries
    
    }

//  The generateDataEntries creates the entries by getting the label value of the servings of food from userdefaults. The function then packages these up with the BarEntry struct and assigns a colour to them and returns the array.
    func generateDataEntries() -> [BarEntry] {
        let colors = [ #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
        var result: [BarEntry] = []
        
        let meatVal = Int(UserDefaults.standard.string(forKey: "meatTotal") ?? "0") ?? 0
        let vegVal = Int(UserDefaults.standard.string(forKey: "vegetableTotal") ?? "0") ?? 0
        let fruVal = Int(UserDefaults.standard.string(forKey: "fruitTotal") ?? "0") ?? 0
        let daiVal = Int(UserDefaults.standard.string(forKey: "dairyTotal") ?? "0") ?? 0
        let graVal = Int(UserDefaults.standard.string(forKey: "grainsTotal") ?? "0") ?? 0
        
        
        
        var mHeight: Float = Float(meatVal) / 3.0
        var meastring = String(format: "%.2f", mHeight * 100) + "%"
        if (mHeight > 1) {
            meastring = ">100%"
            mHeight = 1.1
        }
        
        var vHeight: Float = Float(vegVal) / 5.0
        var vegstring = String(format: "%.2f", vHeight * 100) + "%"
        if (vHeight > 1) {
            vegstring = ">100%"
            vHeight = 1.1
        }
        
        var fHeight: Float = Float(fruVal) / 5.0
        var frustring = String(format: "%.2f", fHeight * 100) + "%"
        if (fHeight > 1.0) {
            frustring = ">100%"
            fHeight = 1.1
        }
        
        var dHeight: Float = Float(daiVal) / 3.0
        var daistring = String(format: "%.2f", dHeight * 100) + "%"
        if (dHeight > 1) {
            daistring = ">100%"
            dHeight = 1.1
        }
        
        var gHeight: Float = Float(graVal) / 8.0
        var grastring = String(format: "%.2f", gHeight * 100) + "%"
        if (gHeight > 1) {
            grastring = ">100%"
            gHeight = 1.1
        }
        
        
        

    
        result.append(BarEntry(color: colors[0 % colors.count], height: mHeight, textValue: meastring, title: "Meats"))
        result.append(BarEntry(color: colors[1 % colors.count], height: vHeight, textValue: vegstring, title: "Vegetables"))
        result.append(BarEntry(color: colors[2 % colors.count], height: fHeight, textValue: frustring, title: "Fruits"))
        result.append(BarEntry(color: colors[3 % colors.count], height: dHeight, textValue: daistring, title: "Dairies"))
        result.append(BarEntry(color: colors[4 % colors.count], height: gHeight, textValue: grastring, title: "Grains"))
        
        return result
    }
}
