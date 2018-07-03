//
//  ServingPackageClass.swift
//  FoodMenu
//
//  Created by Jack Wright on 2018-06-26.
//  Copyright © 2018 Jack Wright. All rights reserved.
//

import Foundation

class ServingPackage {
    
    
    //This Function creates a Dictionary first of the day that contains all the number of food servings the user has eaten throughout the day. Then it combines 7 of those daily dictionaries into a weekly dictionary. The dictionary entries are tagged by the date, where the weeks are keyed by the first day of the week. This will be used in v2 of the app when we archive old weeks on the server.
    
    var dateFuncs = DateAttributes()
    
    
    var weeklyDictionary = [String: [String: [String]]]()
    
    func packageItemsWithDate(date: String, meat: String, vegetable: String, fruit: String, dairy: String, grains: String ) -> Dictionary<String, [String]> {
        
        var servingsPacked = [String]()
        
        servingsPacked = [meat,vegetable,fruit,dairy,grains]
        
        GlobalStates.currentDayDictionary[date] = servingsPacked
        
        if GlobalStates.currentDayDictionary.count == 7 {
            
            let startofWeek = dateFuncs.getFirstDayOfWeek()
            
            
            weeklyDictionary[startofWeek] = GlobalStates.currentDayDictionary
        GlobalStates.currentDayDictionary.removeAll()
            
            
        }
        
        return GlobalStates.currentDayDictionary
    }

    
}
