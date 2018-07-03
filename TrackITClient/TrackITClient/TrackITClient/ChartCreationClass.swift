//
//  ChartCreationClass.swift
//  TrackITClient
//
//  Created by Jack Wright on 2018-07-02.
//  Copyright © 2018 Group 9. All rights reserved.
//

import Foundation
import UIKit

class barChartView: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var Nadabsd: BasicBarChart!
    
    
    override func viewWillAppear(_ animated: Bool) {
        let dataEntries = generateDataEntries()
        print(dataEntries)
        
        Nadabsd.dataEntries = dataEntries
    
    }
    
    func generateDataEntries() -> [BarEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [BarEntry] = []
        
        let meatVal = Int(UserDefaults.standard.string(forKey: "meatTotal") ?? "0") ?? 0
        let vegVal = Int(UserDefaults.standard.string(forKey: "vegetableTotal") ?? "0") ?? 0
        let fruVal = Int(UserDefaults.standard.string(forKey: "fruitTotal") ?? "0") ?? 0
        let daiVal = Int(UserDefaults.standard.string(forKey: "dairyTotal") ?? "0") ?? 0
        let graVal = Int(UserDefaults.standard.string(forKey: "grainsTotal") ?? "0") ?? 0
        
        let meastring = UserDefaults.standard.string(forKey: "meatTotal") ?? "0"
        let vegstring = UserDefaults.standard.string(forKey: "vegetableTotal") ?? "0"
        let frustring = UserDefaults.standard.string(forKey: "fruitTotal") ?? "0"
        let daistring = UserDefaults.standard.string(forKey: "dairyTotal") ?? "0"
        let grastring = UserDefaults.standard.string(forKey: "grainsTotal") ?? "0"
        
        let Mheight: Float = Float(meatVal) / 15.0
        let Vheight: Float = Float(vegVal) / 15.0
        let Fheight: Float = Float(fruVal) / 15.0
        let Dheight: Float = Float(daiVal) / 15.0
        let Gheight: Float = Float(graVal) / 15.0

    
        result.append(BarEntry(color: colors[0 % colors.count], height: Mheight, textValue: meastring, title: "Meats"))
        result.append(BarEntry(color: colors[1 % colors.count], height: Vheight, textValue: vegstring, title: "Vegetables"))
        result.append(BarEntry(color: colors[2 % colors.count], height: Fheight, textValue: frustring, title: "Fruits"))
        result.append(BarEntry(color: colors[3 % colors.count], height: Dheight, textValue: daistring, title: "Dairies"))
        result.append(BarEntry(color: colors[4 % colors.count], height: Gheight, textValue: grastring, title: "Grains"))
        
        return result
    }
}
