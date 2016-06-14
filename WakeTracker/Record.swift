//
//  Record.swift
//  WakeTracker
//
//  Created by CJ Willis on 6/14/16.
//  Copyright © 2016 CJ Willis. All rights reserved.
//

import Foundation

class Record {
    
    // MARK: Variables
    var month: Int
    var day: Int
    var year: Int
    var hour: Int
    var minute: Int
    var displayHour: Int
    
    // MARK: Initialization
    init(month: Int, day: Int, year: Int, hour: Int, minute: Int) {
        self.month = month
        self.day = day
        self.year = year
        self.hour = hour
        self.minute = minute
        self.displayHour = hour
    }
    
    // MARK: Methods
    func validateHour() {
        let hourMap: [Int: Int] = [13: 1, 14:2, 15:3, 16:4, 17:5, 18:6, 19:7, 20:8, 21:9, 22:10, 23:11, 0:12]
        if hour < 1 || hour > 12 {
            displayHour = hourMap[hour]!
        }
    }
    
    func setTimeOfDay() -> String {
        if hour < 12 {
            return "AM"
        } else {
            return "PM"
        }
    }
    
    //    func formatMonth(month: Int) -> String {
    //        switch month {
    //        case 1:
    //            return "January"
    //        case 2:
    //            return "February"
    //        case 3:
    //            return "March"
    //        case 4:
    //            return "April"
    //        case 5:
    //            return "May"
    //        case 6:
    //            return "June"
    //        case 7:
    //            return "July"
    //        case 8:
    //            return "August"
    //        case 9:
    //            return "September"
    //        case 10:
    //            return "October"
    //        case 11:
    //            return "November"
    //        case 12:
    //            return "December"
    //        default:
    //            return ""
    //        }
    //    }
}
