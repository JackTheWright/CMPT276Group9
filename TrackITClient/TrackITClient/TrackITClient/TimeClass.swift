//
//  TimeClass.swift
//  FoodMenu
//
//  Created by Jack Wright on 2018-06-27.
//  Copyright © 2018 Jack Wright. All rights reserved.
//

import Foundation

class DateAttributes {
    
    
    public var enterForegroundDate = String()
    public var enterBackgroundDate = String()
    
    
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
    
    func getYesterdaysDate() -> String{
        
        let toDate = Date()
        
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: toDate)
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormat.string(from: yesterdayDate!)
        
        return dateString
        
        
    }
    
    
    
    
    
    func isSameDates(date1:String, date2:String) -> Bool {
        
        var boolDate = Bool()
        boolDate = false
        
        let month1 = date1[5..<7]
        let day1 = date1[8..<date1.count]
        
        let month2 = date2[5..<7]
        let day2 = date2[8..<date2.count]

        if (day1 == day2) && (month1 == month2) {
            
            boolDate = true
            
        }
        
        return boolDate
        
        }
    
    
    
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
