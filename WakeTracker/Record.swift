//
//  Record.swift
//  WakeTracker
//
//  Created by CJ Willis on 6/14/16.
//  Copyright © 2016 CJ Willis. All rights reserved.
//

import Foundation

class Record: NSObject, NSCoding {
    
    // MARK: Variables
    var month: Int
    var day: Int
    var year: Int
    var hour: Int
    var minute: Int
    var displayHour: Int
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("records")
    
    // MARK: Initialization
    init(month: Int, day: Int, year: Int, hour: Int, minute: Int) {
        self.month = month
        self.day = day
        self.year = year
        self.hour = hour
        self.minute = minute
        self.displayHour = hour
        
        super.init()
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
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(month, forKey: RecordKey.monthKey)
        aCoder.encodeInteger(day, forKey: RecordKey.dayKey)
        aCoder.encodeInteger(year, forKey: RecordKey.yearKey)
        aCoder.encodeInteger(hour, forKey: RecordKey.hourKey)
        aCoder.encodeInteger(minute, forKey: RecordKey.minuteKey)
        aCoder.encodeInteger(displayHour, forKey: RecordKey.displayHourKey)
    }
    
    required convenience init?(coder aDecorder: NSCoder) {
        let month = aDecorder.decodeIntegerForKey(RecordKey.monthKey)
        let day = aDecorder.decodeIntegerForKey(RecordKey.dayKey)
        let year = aDecorder.decodeIntegerForKey(RecordKey.yearKey)
        let hour = aDecorder.decodeIntegerForKey(RecordKey.hourKey)
        let minute = aDecorder.decodeIntegerForKey(RecordKey.minuteKey)
//        let displayHour = aDecorder.decodeIntegerForKey(RecordKey.displayHourKey)
        
        self.init(month: month, day: day, year: year, hour: hour, minute: minute)
    }
    
    // MARK: Keys
    struct RecordKey {
        static let monthKey = "month"
        static let dayKey = "day"
        static let yearKey = "year"
        static let hourKey = "hour"
        static let minuteKey = "minute"
        static let displayHourKey = "displayHour"
    }
}
