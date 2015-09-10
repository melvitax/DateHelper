//
//  AFDateExtension.swift
//
//  Version 3.1.0
//
//  Created by Melvin Rivera on 7/15/14.
//  Copyright (c) 2014. All rights reserved.
//

import Foundation

// DotNet: "/Date(1268123281843)/"
let DefaultFormat = "EEE MMM dd HH:mm:ss Z yyyy"
let RSSFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ" // "Fri, 09 Sep 2011 15:26:08 +0200"
let AltRSSFormat = "d MMM yyyy HH:mm:ss ZZZ" // "09 Sep 2011 15:26:08 +0200"

public enum ISO8601Format: String {
    
    case Year = "yyyy" // 1997
    case YearMonth = "yyyy-MM" // 1997-07
    case Date = "yyyy-MM-dd" // 1997-07-16
    case DateTime = "yyyy-MM-dd'T'HH:mmZ" // 1997-07-16T19:20+01:00
    case DateTimeSec = "yyyy-MM-dd'T'HH:mm:ssZ" // 1997-07-16T19:20:30+01:00
    case DateTimeMilliSec = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 1997-07-16T19:20:30.45+01:00
    
    init(dateString:String) {
        switch dateString.characters.count {
        case 4:
            self = ISO8601Format(rawValue: ISO8601Format.Year.rawValue)!
        case 7:
            self = ISO8601Format(rawValue: ISO8601Format.YearMonth.rawValue)!
        case 10:
            self = ISO8601Format(rawValue: ISO8601Format.Date.rawValue)!
        case 22:
            self = ISO8601Format(rawValue: ISO8601Format.DateTime.rawValue)!
        case 25:
            self = ISO8601Format(rawValue: ISO8601Format.DateTimeSec.rawValue)!
        default:// 28:
            self = ISO8601Format(rawValue: ISO8601Format.DateTimeMilliSec.rawValue)!
        }
    }
}

public enum DateFormat {
    case ISO8601(ISO8601Format?), DotNet, RSS, AltRSS, Custom(String)
}

public extension NSDate {
    
    // MARK: Intervals In Seconds
    private class func minuteInSeconds() -> Double { return 60 }
    private class func hourInSeconds() -> Double { return 3600 }
    private class func dayInSeconds() -> Double { return 86400 }
    private class func weekInSeconds() -> Double { return 604800 }
    private class func yearInSeconds() -> Double { return 31556926 }
    
    // MARK: Components
    private class func componentFlags() -> NSCalendarUnit { return [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday, NSCalendarUnit.WeekdayOrdinal, NSCalendarUnit.WeekOfYear] }
    
    private class func components(fromDate fromDate: NSDate) -> NSDateComponents! {
        return NSCalendar.currentCalendar().components(NSDate.componentFlags(), fromDate: fromDate)
    }
    
    private func components() -> NSDateComponents  {
        return NSDate.components(fromDate: self)!
    }
    
    // MARK: Date From String
    
    /**
    Returns a new NSDate object based on a date string and a formatter type.
    
    :param: fromString :String Date string i.e. "16 July 1972 6:12:00".
    :param: format :DateFormat Formatter type can be .ISO8601(ISO8601Format?), .DotNet, .RSS, .AltRSS or Custom(String).
    
    :returns: NSDate
    :discussion: Use .ISO8601(nil) to generate an automatic ISO8601Format based on the date string.
    */
    
    convenience init(fromString string: String, format:DateFormat)
    {
        if string.isEmpty {
            self.init()
            return
        }
        
        let string = string as NSString
        
        switch format {
            
        case .DotNet:
            
            let startIndex = string.rangeOfString("(").location + 1
            let endIndex = string.rangeOfString(")").location
            let range = NSRange(location: startIndex, length: endIndex-startIndex)
            let milliseconds = (string.substringWithRange(range) as NSString).longLongValue
            let interval = NSTimeInterval(milliseconds / 1000)
            self.init(timeIntervalSince1970: interval)
            
        case .ISO8601(let isoFormat):
            
            let dateFormat = (isoFormat != nil) ? isoFormat! : ISO8601Format(dateString: string as String)
            let formatter = NSDate.formatter(format: dateFormat.rawValue)
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.timeZone = NSTimeZone.localTimeZone()
            formatter.dateFormat = dateFormat.rawValue
            if let date = formatter.dateFromString(string as String) {
                self.init(timeInterval:0, sinceDate:date)
            } else {
                self.init()
            }
            
        case .RSS:
            
            var s  = string
            if string.hasSuffix("Z") {
                s = s.substringToIndex(s.length-1) + "GMT"
            }
            let formatter = NSDate.formatter(format: RSSFormat)
            if let date = formatter.dateFromString(string as String) {
                self.init(timeInterval:0, sinceDate:date)
            } else {
                self.init()
            }
            
        case .AltRSS:
            
            var s  = string
            if string.hasSuffix("Z") {
                s = s.substringToIndex(s.length-1) + "GMT"
            }
            let formatter = NSDate.formatter(format: AltRSSFormat)
            if let date = formatter.dateFromString(string as String) {
                self.init(timeInterval:0, sinceDate:date)
            } else {
                self.init()
            }
            
        case .Custom(let dateFormat):
            
            let formatter = NSDate.formatter(format: dateFormat)
            if let date = formatter.dateFromString(string as String) {
                self.init(timeInterval:0, sinceDate:date)
            } else {
                self.init()
            }
        }
    }
    
    
    
    // MARK: Comparing Dates
    
    /**
    Compares dates without while ignoring time.
    
    :param: date :NSDate Date to compare.
    
    :returns: :Bool Returns true if dates are equal.
    */
    func isEqualToDateIgnoringTime(date: NSDate) -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: date)
        return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
    }
    
    /**
    Checks if date is today.
    
    :returns: :Bool Returns true if date is today.
    */
    func isToday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate())
    }
    
    /**
    Checks if date is tomorrow.
    
    :returns: :Bool Returns true if date is tomorrow.
    */
    func isTomorrow() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate().dateByAddingDays(1))
    }
    
    /**
    Checks if date is yesterday.
    
    :returns: :Bool Returns true if date is yesterday.
    */
    func isYesterday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate().dateBySubtractingDays(1))
    }
    
    /**
    Compares dates to see if they are in the same week.
    
    :param: date :NSDate Date to compare.
    :returns: :Bool Returns true if date is tomorrow.
    */
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
    
    /**
    Checks if date is this week.
    
    :returns: :Bool Returns true if date is this week.
    */
    func isThisWeek() -> Bool
    {
        return self.isSameWeekAsDate(NSDate())
    }
    
    /**
    Checks if date is next week.
    
    :returns: :Bool Returns true if date is next week.
    */
    func isNextWeek() -> Bool
    {
        let interval: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate + NSDate.weekInSeconds()
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return self.isSameWeekAsDate(date)
    }
    
    /**
    Checks if date is last week.
    
    :returns: :Bool Returns true if date is last week.
    */
    func isLastWeek() -> Bool
    {
        let interval: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate - NSDate.weekInSeconds()
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return self.isSameWeekAsDate(date)
    }
    
    /**
    Compares dates to see if they are in the same year.
    
    :param: date :NSDate Date to compare.
    :returns: :Bool Returns true if date is this week.
    */
    func isSameYearAsDate(date: NSDate) -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: date)
        return (comp1.year == comp2.year)
    }
    
    /**
    Checks if date is this year.
    
    :returns: :Bool Returns true if date is this year.
    */
    func isThisYear() -> Bool
    {
        return self.isSameYearAsDate(NSDate())
    }
    
    /**
    Checks if date is next year.
    
    :returns: :Bool Returns true if date is next year.
    */
    func isNextYear() -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: NSDate())
        return (comp1.year == comp2.year + 1)
    }
    
    /**
    Checks if date is last year.
    
    :returns: :Bool Returns true if date is last year.
    */
    func isLastYear() -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: NSDate())
        return (comp1.year == comp2.year - 1)
    }
    
    /**
    Compares dates to see if it's an earlier date.
    
    :param: date :NSDate Date to compare.
    :returns: :Bool Returns true if date is earlier.
    */
    func isEarlierThanDate(date: NSDate) -> Bool
    {
        return self.earlierDate(date) == self
    }
    
    /**
    Compares dates to see if it's a later date.
    
    :param: date :NSDate Date to compare.
    :returns: :Bool Returns true if date is later.
    */
    func isLaterThanDate(date: NSDate) -> Bool
    {
        return self.laterDate(date) == self
    }
    
    /**
    Checks if date is in future.
    
    :returns: :Bool Returns true if date is in future.
    */
    func isInFuture() -> Bool
    {
        return self.isLaterThanDate(NSDate())
    }
    
    /**
    Checks if date is in past.
    
    :returns: :Bool Returns true if date is in past.
    */
    func isInPast() -> Bool
    {
        return self.isEarlierThanDate(NSDate())
    }
    
    
    // MARK: Adjusting Dates
    
    /**
    Returns a new NSDate object by a adding days.
    
    :param: days :Int Days to add.
    :returns: NSDate
    */
    func dateByAddingDays(days: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.day = days
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Returns a new NSDate object by a substracting days.
    
    :param: days :Int Days to substract.
    :returns: NSDate
    */
    func dateBySubtractingDays(days: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.day = (days * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Returns a new NSDate object by a adding hours.
    
    :param: days :Int Hours to add.
    :returns: NSDate
    */
    func dateByAddingHours(hours: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.hour = hours
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Returns a new NSDate object by a substracting hours.
    
    :param: days :Int Hours to substract.
    :returns: NSDate
    */
    func dateBySubtractingHours(hours: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.hour = (hours * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Returns a new NSDate object by a adding minutes.
    
    :param: days :Int Minutes to add.
    :returns: NSDate
    */
    func dateByAddingMinutes(minutes: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.minute = minutes
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Returns a new NSDate object by a adding minutes.
    
    :param: days :Int Minutes to add.
    :returns: NSDate
    */
    func dateBySubtractingMinutes(minutes: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.minute = (minutes * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Returns a new NSDate object from the start of the day.
    
    :returns: NSDate
    */
    func dateAtStartOfDay() -> NSDate
    {
        let components = self.components()
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    /**
    Returns a new NSDate object from the end of the day.
    
    :returns: NSDate
    */
    func dateAtEndOfDay() -> NSDate
    {
        let components = self.components()
        components.hour = 23
        components.minute = 59
        components.second = 59
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    /**
    Returns a new NSDate object from the start of the week.
    
    :returns: NSDate
    */
    func dateAtStartOfWeek() -> NSDate
    {
        let flags :NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Weekday]
        let components = NSCalendar.currentCalendar().components(flags, fromDate: self)
        components.weekday = NSCalendar.currentCalendar().firstWeekday
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    /**
    Returns a new NSDate object from the end of the week.
    
    :returns: NSDate
    */
    func dateAtEndOfWeek() -> NSDate
    {
        let flags :NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Weekday]
        let components = NSCalendar.currentCalendar().components(flags, fromDate: self)
        components.weekday = NSCalendar.currentCalendar().firstWeekday + 6
        components.hour = 0
        components.minute = 0
        components.second = 0
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    /**
    Return a new NSDate object of the first day of the month
    
    :returns: NSDate
    */
    func dateAtTheStartOfMonth() -> NSDate
    {
        //Create the date components
        let components = self.components()
        components.day = 1
        //Builds the first day of the month
        let firstDayOfMonthDate :NSDate = NSCalendar.currentCalendar().dateFromComponents(components)!
        
        return firstDayOfMonthDate
        
    }
    
    /**
    Return a new NSDate object of the last day of the month
    
    :returns: NSDate
    */
    func dateAtTheEndOfMonth() -> NSDate {
        
        //Create the date components
        let components = self.components()
        //Set the last day of this month
        components.month += 1
        components.day = 0
        
        //Builds the first day of the month
        let lastDayOfMonth :NSDate = NSCalendar.currentCalendar().dateFromComponents(components)!
        
        return lastDayOfMonth
        
    }
    
    
    // MARK: Retrieving Intervals
    
    /**
    Returns the interval in minutes after a date.
    
    :param: date :NSDate Date to compare.
    :returns: Int
    */
    func minutesAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.minuteInSeconds())
    }
    
    /**
    Returns the interval in minutes before a date.
    
    :param: date :NSDate Date to compare.
    :returns: Int
    */
    func minutesBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.minuteInSeconds())
    }
    
    /**
    Returns the interval in hours after a date.
    
    :param: date :NSDate Date to compare.
    :returns: Int
    */
    func hoursAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.hourInSeconds())
    }
    
    /**
    Returns the interval in hours before a date.
    
    :param: date :NSDate Date to compare.
    :returns: Int
    */
    func hoursBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.hourInSeconds())
    }
    
    /**
    Returns the interval in days after a date.
    
    :param: date :NSDate Date to compare.
    :returns: Int
    */
    func daysAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.dayInSeconds())
    }
    
    /**
    Returns the interval in days before a date.
    
    :param: date :NSDate Date to compare.
    :returns: Int
    */
    func daysBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.dayInSeconds())
    }
    
    
    // MARK: Decomposing Dates
    
    /**
    Returns the nearest hour.
    
    :returns: Int
    */
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
    /**
    Returns the year component.
    
    :returns: Int
    */
    func year () -> Int { return self.components().year  }
    /**
    Returns the month component.
    
    :returns: Int
    */
    func month () -> Int { return self.components().month }
    /**
    Returns the week of year component.
    
    :returns: Int
    */
    func week () -> Int { return self.components().weekOfYear }
    /**
    Returns the day component.
    
    :returns: Int
    */
    func day () -> Int { return self.components().day }
    /**
    Returns the hour component.
    
    :returns: Int
    */
    func hour () -> Int { return self.components().hour }
    /**
    Returns the minute component.
    
    :returns: Int
    */
    func minute () -> Int { return self.components().minute }
    /**
    Returns the seconds component.
    
    :returns: Int
    */
    func seconds () -> Int { return self.components().second }
    /**
    Returns the weekday component.
    
    :returns: Int
    */
    func weekday () -> Int { return self.components().weekday }
    /**
    Returns the nth days component. e.g. 2nd Tuesday of the month is 2.
    
    :returns: Int
    */
    func nthWeekday () -> Int { return self.components().weekdayOrdinal }
    /**
    Returns the days of the month.
    
    :returns: Int
    */
    func monthDays () -> Int { return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length }
    /**
    Returns the first day of the week.
    
    :returns: Int
    */
    func firstDayOfWeek () -> Int {
        let distanceToStartOfWeek = NSDate.dayInSeconds() * Double(self.components().weekday - 1)
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return NSDate(timeIntervalSinceReferenceDate: interval).day()
    }
    /**
    Returns the last day of the week.
    
    :returns: Int
    */
    func lastDayOfWeek () -> Int {
        let distanceToStartOfWeek = NSDate.dayInSeconds() * Double(self.components().weekday - 1)
        let distanceToEndOfWeek = NSDate.dayInSeconds() * Double(7)
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return NSDate(timeIntervalSinceReferenceDate: interval).day()
    }
    /**
    Checks to see if the date is a weekdday.
    
    :returns: :Bool Returns true if weekday.
    */
    func isWeekday() -> Bool {
        return !self.isWeekend()
    }
    /**
    Checks to see if the date is a weekdend.
    
    :returns: :Bool Returns true if weekend.
    */
    func isWeekend() -> Bool {
        let range = NSCalendar.currentCalendar().maximumRangeOfUnit(NSCalendarUnit.Weekday)
        return (self.weekday() == range.location || self.weekday() == range.length)
    }
    
    
    // MARK: To String
    
    /**
    Returns a new String object using .ShortStyle date style and .ShortStyle time style.
    
    :returns: :String
    */
    func toString() -> String {
        return self.toString(dateStyle: .ShortStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
    }
    
    /**
    Returns a new String object based on a  date format.
    
    :param: format :DateFormat Format of date. Can be .ISO8601(.ISO8601Format?), .DotNet, .RSS, .AltRSS or Custom(FormatString).
    :returns: String
    */
    func toString(format format: DateFormat) -> String
    {
        var dateFormat: String
        switch format {
        case .DotNet:
            let offset = NSTimeZone.defaultTimeZone().secondsFromGMT / 3600
            let nowMillis = 1000 * self.timeIntervalSince1970
            return  "/Date(\(nowMillis)\(offset))/"
        case .ISO8601(let isoFormat):
            dateFormat = (isoFormat != nil) ? isoFormat!.rawValue : ISO8601Format.DateTimeMilliSec.rawValue
        case .RSS:
            dateFormat = RSSFormat
        case .AltRSS:
            dateFormat = AltRSSFormat
        case .Custom(let string):
            dateFormat = string
        }
        let formatter = NSDate.formatter(format: dateFormat)
        return formatter.stringFromDate(self)
    }
    
    /**
    Returns a new String object based on a date style, time style and optional relative flag.
    
    :param: dateStyle :NSDateFormatterStyle
    :param: timeStyle :NSDateFormatterStyle
    :param: doesRelativeDateFormatting :Bool
    :returns: String
    */
    func toString(dateStyle dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle, doesRelativeDateFormatting: Bool = false) -> String
    {
        let formatter = NSDate.formatter(dateStyle: dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: doesRelativeDateFormatting)
        return formatter.stringFromDate(self)
    }
    
    /**
    Returns a new String object based on a relative time language. i.e. just now, 1 minute ago etc..
    
    :returns: String
    */
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
    
    /**
    Returns the weekday as a new String object.
    
    :returns: String
    */
    func weekdayToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.weekdaySymbols[self.weekday()-1] as String
    }
    
    /**
    Returns the short weekday as a new String object.
    
    :returns: String
    */
    func shortWeekdayToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.shortWeekdaySymbols[self.weekday()-1] as String
    }
    
    /**
    Returns the very short weekday as a new String object.
    
    :returns: String
    */
    func veryShortWeekdayToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.veryShortWeekdaySymbols[self.weekday()-1] as String
    }
    
    /**
    Returns the month as a new String object.
    
    :returns: String
    */
    func monthToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.monthSymbols[self.month()-1] as String
    }
    
    /**
    Returns the short month as a new String object.
    
    :returns: String
    */
    func shortMonthToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.shortMonthSymbols[self.month()-1] as String
    }
    
    /**
    Returns the very short month as a new String object.
    
    :returns: String
    */
    func veryShortMonthToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.veryShortMonthSymbols[self.month()-1] as String
    }
    
    
    // MARK: Static Cached Formatters
    
    /**
    Returns a static singleton array of NSDateFormatters so that thy are only created once.
    
    :returns: [String: NSDateFormatter] Array of NSDateFormatters
    */
    private class func sharedDateFormatters() -> [String: NSDateFormatter] {
        struct Static {
            static var formatters: [String: NSDateFormatter]? = nil
            static var once: dispatch_once_t = 0
        }
        dispatch_once(&Static.once) {
            Static.formatters = [String: NSDateFormatter]()
        }
        return Static.formatters!
    }
    
    /**
    Returns a singleton formatter based on the format, timeZone and locale. Formatters are cached in a singleton array using hashkeys generated by format, timeZone and locale.
    
    :param: format :String
    :param: timeZone :NSTimeZone Uses local time zone as the default
    :param: locale :NSLocale Uses current locale as the default
    :returns: [String: NSDateFormatter] Singleton of NSDateFormatters
    */
    private class func formatter(format format:String = DefaultFormat, timeZone: NSTimeZone = NSTimeZone.localTimeZone(), locale: NSLocale = NSLocale.currentLocale()) -> NSDateFormatter {
        let hashKey = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        var formatters = NSDate.sharedDateFormatters()
        if let cachedDateFormatter = formatters[hashKey] {
            return cachedDateFormatter
        } else {
            let formatter = NSDateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = timeZone
            formatter.locale = locale
            formatters[hashKey] = formatter
            return formatter
        }
    }
    
    /**
    Returns a singleton formatter based on date style, time style and relative date. Formatters are cached in a singleton array using hashkeys generated by date style, time style, relative date, timeZone and locale.
    
    :param: dateStyle :NSDateFormatterStyle
    :param: timeStyle :NSDateFormatterStyle
    :param: doesRelativeDateFormatting :Bool
    :param: timeZone :NSTimeZone
    :param: locale :NSLocale
    :returns: [String: NSDateFormatter] Singleton array of NSDateFormatters
    */
    private class func formatter(dateStyle dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle, doesRelativeDateFormatting: Bool, timeZone: NSTimeZone = NSTimeZone.localTimeZone(), locale: NSLocale = NSLocale.currentLocale()) -> NSDateFormatter {
        var formatters = NSDate.sharedDateFormatters()
        let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        if let cachedDateFormatter = formatters[hashKey] {
            return cachedDateFormatter
        } else {
            let formatter = NSDateFormatter()
            formatter.dateStyle = dateStyle
            formatter.timeStyle = timeStyle
            formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
            formatter.timeZone = timeZone
            formatter.locale = locale
            formatters[hashKey] = formatter
            return formatter
        }
    }
    
    
    
}