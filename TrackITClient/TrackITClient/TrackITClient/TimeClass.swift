//
// File         : TimeClass.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jack Wright
// Created On   : 2018-06-27
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
//  - Fixed Formatting
//

import Foundation

class DateAttributes {
    
    
    public var enterForegroundDate = String()
    public var enterBackgroundDate = String()
    
    
// This function converts the current date to a string in the form year-month-day, this is the main function used to convert the date to a usable string.
    
    func currentDateToString()->String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func currentDateToFANCYString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
//  This function is for the creation of the week dictionaries in the packaging class. It takes the current date and subtracts 7 days from it and then finally converts it to a string of the form year-month-day.
    
    func getFirstDayOfWeek() -> String{
        let toDate = Date()
        let weekStartDate = Calendar.current.date(byAdding: .day, value: -7, to: toDate)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormat.string(from: weekStartDate!)
        return dateString
    }
    
//  This functions subtracts 1 from the current day, getting yesterdays date and converting it to a string in the form year-month-day.
    
    func getYesterdaysDate() -> String{
        let toDate = Date()
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: toDate)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormat.string(from: yesterdayDate!)
        return dateString
    }
    
    
    
//  This function compares 2 dates and returns true if they are the same. If not the function returns false. Since it inputs the dates as a string, we can disect it into days (index 5-7) and month (index 8-10) and compare the strings.
    
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

//  This string extension allows us to get the month and day out of the string of the form year-month-day using indexing.

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
