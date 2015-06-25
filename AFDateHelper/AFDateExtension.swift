//
//  AFDateExtension.swift
//
//  Version 2.0.0
//
//  Created by Melvin Rivera on 7/15/14.
//  Copyright (c) 2014. All rights reserved.
//

import Foundation

enum DateFormat {
    case ISO8601, DotNet, RSS, AltRSS
    case Custom(String)
}

extension NSDate {

    // MARK: Intervals In Seconds
    private class func minuteInSeconds() -> Double { return 60 }
    private class func hourInSeconds() -> Double { return 3600 }
    private class func dayInSeconds() -> Double { return 86400 }
    private class func weekInSeconds() -> Double { return 604800 }
    private class func yearInSeconds() -> Double { return 31556926 }
    
    // MARK: Components
    private class func componentFlags() -> NSCalendarUnit { return NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond  | NSCalendarUnit.CalendarUnitWeekday | NSCalendarUnit.CalendarUnitWeekdayOrdinal | NSCalendarUnit.CalendarUnitWeekOfYear }
    
    private class func components(#fromDate: NSDate) -> NSDateComponents! {
        return NSCalendar.currentCalendar().components(NSDate.componentFlags(), fromDate: fromDate)
    }
    
    private func components() -> NSDateComponents  {
        return NSDate.components(fromDate: self)!
    }
    
    // MARK: Date From String
    
    convenience init(fromString string: String, format:DateFormat)
    {
        if string.isEmpty {
            self.init()
            return
        }
        
        let string = string as NSString
        
        switch format {
            
            case .DotNet:
                
                // Expects "/Date(1268123281843)/"
                let startIndex = string.rangeOfString("(").location + 1
                let endIndex = string.rangeOfString(")").location
                let range = NSRange(location: startIndex, length: endIndex-startIndex)
                let milliseconds = (string.substringWithRange(range) as NSString).longLongValue
                let interval = NSTimeInterval(milliseconds / 1000)
                self.init(timeIntervalSince1970: interval)
            
            case .ISO8601:
                
                var s = string
                if string.hasSuffix(" 00:00") {
                    s = s.substringToIndex(s.length-6) + "GMT"
                } else if string.hasSuffix("Z") {
                    s = s.substringToIndex(s.length-1) + "GMT"
                }
                
                struct Static  {
                    static var formatter: NSDateFormatter? = nil
                    static var token: dispatch_once_t = 0;
                }
                dispatch_once(&Static.token) {
                    Static.formatter = NSDateFormatter();
                    Static.formatter?.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
                }
                if let date = Static.formatter!.dateFromString(string as String) {
                    self.init(timeInterval:0, sinceDate:date)
                } else {
                    self.init()
                }
                
            case .RSS:
                
                var s  = string
                if string.hasSuffix("Z") {
                    s = s.substringToIndex(s.length-1) + "GMT"
                }
                struct Static  {
                    static var formatter: NSDateFormatter? = nil
                    static var token: dispatch_once_t = 0;
                }
                dispatch_once(&Static.token) {
                    Static.formatter = NSDateFormatter();
                    Static.formatter?.dateFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
                }
                if let date = Static.formatter!.dateFromString(string as String) {
                    self.init(timeInterval:0, sinceDate:date)
                } else {
                    self.init()
                }
            
            case .AltRSS:
                
                var s  = string
                if string.hasSuffix("Z") {
                    s = s.substringToIndex(s.length-1) + "GMT"
                }
                struct Static  {
                    static var formatter: NSDateFormatter? = nil
                    static var token: dispatch_once_t = 0;
                }
                dispatch_once(&Static.token) {
                    Static.formatter = NSDateFormatter();
                    Static.formatter?.dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
                }
                if let date = Static.formatter!.dateFromString(string as String) {
                    self.init(timeInterval:0, sinceDate:date)
                } else {
                    self.init()
                }
            
            case .Custom(let dateFormat):
                
                struct Static  {
                    static var formatter: NSDateFormatter? = nil
                    static var token: dispatch_once_t = 0;
                }
                dispatch_once(&Static.token) {
                    Static.formatter = NSDateFormatter();
                    Static.formatter?.dateFormat = dateFormat
                }
                if let date = Static.formatter!.dateFromString(string as String) {
                    self.init(timeInterval:0, sinceDate:date)
                } else {
                    self.init()
                }
        }
    }
     
    
    
    // MARK: Comparing Dates
    
    func isEqualToDateIgnoringTime(date: NSDate) -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: date)
        return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
    }
    
    func isToday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate())
    }
    
    func isTomorrow() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate().dateByAddingDays(1))
    }
    
    func isYesterday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate().dateBySubtractingDays(1))
    }
    
    func isSameWeekAsDate(date: NSDate) -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: date)
        // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
        if comp1.weekOfYear != comp2.weekOfYear {
            return false
        }
        // Must have a time interval under 1 week
        return abs(self.timeIntervalSinceDate(date)) < NSDate.weekInSeconds()
    }
    
    func isThisWeek() -> Bool
    {
        return self.isSameWeekAsDate(NSDate())
    }
    
    func isNextWeek() -> Bool
    {
        let interval: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate + NSDate.weekInSeconds()
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return self.isSameWeekAsDate(date)
    }
    
    func isLastWeek() -> Bool
    {
        let interval: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate - NSDate.weekInSeconds()
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return self.isSameWeekAsDate(date)
    }
    
    func isSameYearAsDate(date: NSDate) -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: date)
        return (comp1.year == comp2.year)
    }
    
    func isThisYear() -> Bool
    {
        return self.isSameYearAsDate(NSDate())
    }
    
    func isNextYear() -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: NSDate())
        return (comp1.year == comp2.year + 1)
    }
    
    func isLastYear() -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: NSDate())
        return (comp1.year == comp2.year - 1)
    }
    
    func isEarlierThanDate(date: NSDate) -> Bool
    {
        return self.earlierDate(date) == self
    }
    
    func isLaterThanDate(date: NSDate) -> Bool
    {
        return self.laterDate(date) == self
    }
    
  
    // MARK: Adjusting Dates
    
    func dateByAddingDays(days: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate + NSDate.dayInSeconds() * Double(days)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func dateBySubtractingDays(days: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - NSDate.dayInSeconds() * Double(days)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func dateByAddingHours(hours: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate + NSDate.hourInSeconds() * Double(hours)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func dateBySubtractingHours(hours: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - NSDate.hourInSeconds() * Double(hours)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func dateByAddingMinutes(minutes: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate + NSDate.minuteInSeconds() * Double(minutes)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func dateBySubtractingMinutes(minutes: Int) -> NSDate
    {
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - NSDate.minuteInSeconds() * Double(minutes)
        return NSDate(timeIntervalSinceReferenceDate: interval)
    }
    
    func dateAtStartOfDay() -> NSDate
    {
        var components = self.components()
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    func dateAtEndOfDay() -> NSDate
    {
        var components = self.components()
        components.hour = 23
        components.minute = 59
        components.second = 59
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    func dateAtStartOfWeek() -> NSDate
    {
        let flags :NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitWeekday
        var components = NSCalendar.currentCalendar().components(flags, fromDate: self)
        components.weekday = NSCalendar.currentCalendar().firstWeekday
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    func dateAtEndOfWeek() -> NSDate
    {
        let flags :NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitWeekday
        var components = NSCalendar.currentCalendar().components(flags, fromDate: self)
        components.weekday = NSCalendar.currentCalendar().firstWeekday + 7
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    
    // MARK: Retrieving Intervals
    
    func minutesAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.minuteInSeconds())
    }
    
    func minutesBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.minuteInSeconds())
    }
    
    func hoursAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.hourInSeconds())
    }
    
    func hoursBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.hourInSeconds())
    }
    
    func daysAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.dayInSeconds())
    }
    
    func daysBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.dayInSeconds())
    }
    
    
    // MARK: Decomposing Dates
    
    func nearestHour () -> Int {
        let halfHour = NSDate.minuteInSeconds() * 30
        var interval = self.timeIntervalSinceReferenceDate
        if  self.seconds() < 30 {
            interval -= halfHour
        } else {
            interval += halfHour
        }
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return date.hour()
    }
    
    func year () -> Int { return self.components().year  }
    func month () -> Int { return self.components().month }
    func week () -> Int { return self.components().weekOfYear }
    func day () -> Int { return self.components().day }
    func hour () -> Int { return self.components().hour }
    func minute () -> Int { return self.components().minute }
    func seconds () -> Int { return self.components().second }
    func weekday () -> Int { return self.components().weekday }
    func nthWeekday () -> Int { return self.components().weekdayOrdinal } //// e.g. 2nd Tuesday of the month is 2
    func monthDays () -> Int { return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: self).length }

    func firstDayOfWeek () -> Int {
        let distanceToStartOfWeek = NSDate.dayInSeconds() * Double(self.components().weekday - 1)
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return NSDate(timeIntervalSinceReferenceDate: interval).day()
    }
    func lastDayOfWeek () -> Int {
        let distanceToStartOfWeek = NSDate.dayInSeconds() * Double(self.components().weekday - 1)
        let distanceToEndOfWeek = NSDate.dayInSeconds() * Double(7)
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return NSDate(timeIntervalSinceReferenceDate: interval).day()
    }
    func isWeekday() -> Bool {
        return !self.isWeekend()
    }
    func isWeekend() -> Bool {
        let range = NSCalendar.currentCalendar().maximumRangeOfUnit(NSCalendarUnit.CalendarUnitWeekday)
        return (self.weekday() == range.location || self.weekday() == range.length)
    }
    

    // MARK: To String
    
    func toString() -> String {
        return self.toString(dateStyle: .ShortStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
    }
    
    func toString(#format: DateFormat) -> String
    {
        var dateFormat: String
        switch format {
            case .DotNet:
                let offset = NSTimeZone.defaultTimeZone().secondsFromGMT / 3600
                let nowMillis = 1000 * self.timeIntervalSince1970
                return  "/Date(\(nowMillis)\(offset))/"
            case .ISO8601:
                dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            case .RSS:
                dateFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
            case .AltRSS:
                dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
            case .Custom(let string):
                dateFormat = string
        }
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.stringFromDate(self)
    }

    func toString(#dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle, doesRelativeDateFormatting: Bool = false) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
        return formatter.stringFromDate(self)
    }
    
    func relativeTimeToString() -> String
    {
        let time = self.timeIntervalSince1970
        let now = NSDate().timeIntervalSince1970
        
        let seconds = now - time
        let minutes = round(seconds/60)
        let hours = round(minutes/60)
        let days = round(hours/24)
        
        if seconds < 10 {
            return NSLocalizedString("just now", comment: "Show the relative time from a date")
        } else if seconds < 60 {
            let relativeTime = NSLocalizedString("%.f seconds ago", comment: "Show the relative time from a date")
            return String(format: relativeTime, seconds)
        }
        
        if minutes < 60 {
            if minutes == 1 {
                return NSLocalizedString("1 minute ago", comment: "Show the relative time from a date")
            } else {
                let relativeTime = NSLocalizedString("%.f minutes ago", comment: "Show the relative time from a date")
                return String(format: relativeTime, minutes)
            }
        }
        
        if hours < 24 {
            if hours == 1 {
                return NSLocalizedString("1 hour ago", comment: "Show the relative time from a date")
            } else {
                let relativeTime = NSLocalizedString("%.f hours ago", comment: "Show the relative time from a date")
                return String(format: relativeTime, hours)
            }
        }
        
        if days < 7 {
            if days == 1 {
                return NSLocalizedString("1 day ago", comment: "Show the relative time from a date")
            } else {
                let relativeTime = NSLocalizedString("%.f days ago", comment: "Show the relative time from a date")
                return String(format: relativeTime, days)
            }
        }
        
        return self.toString()
    }
    
       
    func weekdayToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.weekdaySymbols[self.weekday()-1] as! String
    }
    
    func shortWeekdayToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.shortWeekdaySymbols[self.weekday()-1] as! String
    }
    
    func veryShortWeekdayToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.veryShortWeekdaySymbols[self.weekday()-1] as! String
    }
    
    func monthToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.monthSymbols[self.month()-1] as! String
    }
    
    func shortMonthToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.shortMonthSymbols[self.month()-1] as! String
    }
    
    func veryShortMonthToString() -> String {
        let formatter = NSDateFormatter()
        return formatter.veryShortMonthSymbols[self.month()-1] as! String
    }
    
    
   
}
