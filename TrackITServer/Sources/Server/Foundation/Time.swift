///
// File         : Time.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-07
//

import Foundation

/// Simple time object used when logging events.
struct Time {

    fileprivate static let months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]

    var year: Int
    var month: Int {
        didSet {
            // Enforce: 1 < month <= 12
            if month % 12 != 0 {
                month = month % 12
            } else {
                month = 1
            }
        }
    }
    var day: Int
    var hour: Int
    var minutes: Int
    var seconds: Int

    /// Initializes as the current time.
    init() {
        let date = Date()
        let calendar = Calendar.current
        print(calendar.timeZone)
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        hour = calendar.component(.hour, from: date)
        minutes = calendar.component(.minute, from: date)
        seconds = calendar.component(.second, from: date)
    }

    init(year: Int, month: Int, day: Int, hour: Int, minutes: Int, seconds: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minutes = minutes
        self.seconds = seconds
    }

}

// MARK: String Conversions

extension Time {

    /// Returns the date as a string in yyyy-mm-dd format without the time.
    var date: String {
        return String(format: "%04d-%02d-%02d", year, month, day)
    }

    /// Returns the time as a string in hh:mm:ss format.
    var time: String {
        return String(format: "%02d:%02d:%02d", hour, minutes, seconds)
    }

    /// Returns the time as a string in hh:mm format.
    var short: String {
        return String(format: "%02d:%02d", hour, minutes)
    }

    /// Returns the date and time as a string in yyyy-mm-dd hh:mm:ss format.
    var long: String {
        return String(
                format: "%04d-%02d-%02d %02d:%02d:%02d",
                year,
                month,
                day,
                hour,
                minutes,
                seconds
        )
    }

    /// Returns the date and time as a string with a textual representation for
    /// the month (e.g January 1, 2010; 00:00:00).
    var fancy: String {
        return "\(Time.months[month - 1]) \(day), \(year); \(time)"
    }

}

// MARK: Static Instances

extension Time {

    /// The current time.
    static var now: Time {
        return Time()
    }

    /// The current date at midnight (00:00:00).
    static var today: Time {
        var time = Time()
        time.hour = 0
        time.minutes = 0
        time.seconds = 0
        return time
    }

}

// MARK: Non-static Instances

extension Time {

    /// Returns the current time object with the time set to 00:00:00.
    var midnight: Time {
        return Time(
                year: year,
                month: month,
                day: day,
                hour: 0,
                minutes: 0,
                seconds: 0
        )
    }

    /// Returns the time object with the time set to 12:00:00
    var noon: Time {
        return Time(
                year: year,
                month: month,
                day: day,
                hour: 12,
                minutes: 0,
                seconds: 0
        )
    }

    /// Returns the time object rounded down to the nearest hour.
    var lowestHour: Time {
        return Time(
                year: year,
                month: month,
                day: day,
                hour: hour,
                minutes: 0,
                seconds: 0
        )
    }

    /// Returns the time object rounded down to the nearest minute.
    var lowestMinute: Time {
        return Time(
                year: year,
                month: month,
                day: day,
                hour: hour,
                minutes: minutes,
                seconds: 0
        )
    }

}
