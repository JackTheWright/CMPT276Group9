//
//  TimeClass.swift
//  FoodMenu
//
//  Created by Jack Wright on 2018-06-27.
//  Copyright © 2018 Jack Wright. All rights reserved.
//

import Foundation

class DateAttributes {
    
    func currentDateToString()->String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func getFirstDayOfWeek() -> String{
        
        let toDate = Date()
        
        let weekStartDate = Calendar.current.date(byAdding: .day, value: -7, to: toDate)
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormat.string(from: weekStartDate!)
        
        return dateString
        
        
    }
    
    
    
}
