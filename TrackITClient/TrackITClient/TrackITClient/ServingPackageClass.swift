//
//  ServingPackageClass.swift
//  FoodMenu
//
//  Created by Jack Wright on 2018-06-26.
//  Copyright © 2018 Jack Wright. All rights reserved.
//

import Foundation

class ServingPackage {
    
    
    //MARK: Add to Dictionary Function
    //This Function creates a Dictionary first of the day that contains all the number of food servings the user has eaten throughout the day. Then it combines 7 of those daily dictionaries into a weekly dictionary.
    
    var dateFuncs = DateAttributes()
    
    var currentDayDictionary = [String: [String]]()
    var weeklyDictionary = [String: [String: [String]]]()
    
    func packageItemsWithDate(date: String, meat: String, vegetable: String, fruit: String, dairy: String, grains: String ) -> Dictionary<String, [String]> {
        
        var servingsPacked = [String]()
        
        servingsPacked = [meat,vegetable,fruit,dairy,grains]
        
        currentDayDictionary[date] = servingsPacked
        
        if currentDayDictionary.count == 7 {
            
            let startofWeek = dateFuncs.getFirstDayOfWeek()
            
            
            weeklyDictionary[startofWeek] = currentDayDictionary
            currentDayDictionary.removeAll()
            
            
        }
        
        return currentDayDictionary
    }
    
    
    //MARK: Set Time for Dictionary Key Functions
    //THis Function will allow us to have the first day of each week be the key for the Dictionary containing 7 days.
    
    
}
