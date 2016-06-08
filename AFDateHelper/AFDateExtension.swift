//
//  AFDateExtension.swift
//
//  Version 3.4.2
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

public enum TimeZone {
    case Local, UTC
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
    Creates a date based on a string and a formatter type. You can ise .ISO8601(nil) to for deducting an ISO8601Format automatically.
    
    - Parameter fromString Date string i.e. "16 July 1972 6:12:00".
    - Parameter format The Date Formatter type can be .ISO8601(ISO8601Format?), .DotNet, .RSS, .AltRSS or Custom(String).
    - Parameter timeZone: The time zone to interpret fromString can be .Local, .UTC applies to Custom format only
    
    - Returns A new date
    */
    
    convenience init(fromString string: String, format:DateFormat, timeZone: TimeZone = .Local)
    {
        if string.isEmpty {
            self.init()
            return
        }
        
        let string = string as NSString
        
        let zone: NSTimeZone
        
        switch timeZone {
        case .Local:
            zone = NSTimeZone.localTimeZone()
        case .UTC:
            zone = NSTimeZone(forSecondsFromGMT: 0)
        }
        
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
            
            let formatter = NSDate.formatter(format: dateFormat, timeZone: zone)
            if let date = formatter.dateFromString(string as String) {
                self.init(timeInterval:0, sinceDate:date)
            } else {
                self.init()
            }
        }
    }
    
    
    
    // MARK: Comparing Dates
    
    /**
    Returns true if dates are equal while ignoring time.
    
    - Parameter date: The Date to compare.
    */
    func isEqualToDateIgnoringTime(date: NSDate) -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: date)
        return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
    }
    
    /**
    Returns Returns true if date is today.
    */
    func isToday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate())
    }
    
    /**
    Returns true if date is tomorrow.
    */
    func isTomorrow() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate().dateByAddingDays(1))
    }
    
    /**
    Returns true if date is yesterday.
    */
    func isYesterday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(NSDate().dateBySubtractingDays(1))
    }
    
    /**
    Returns true if date are in the same week.
     
    - Parameter date: The date to compare.
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
    Returns true if date is this week.
    */
    func isThisWeek() -> Bool
    {
        return self.isSameWeekAsDate(NSDate())
    }
    
    /**
    Returns true if date is next week.
    */
    func isNextWeek() -> Bool
    {
        let interval: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate + NSDate.weekInSeconds()
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return self.isSameWeekAsDate(date)
    }
    
    /**
    Returns true if date is last week.
    */
    func isLastWeek() -> Bool
    {
        let interval: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate - NSDate.weekInSeconds()
        let date = NSDate(timeIntervalSinceReferenceDate: interval)
        return self.isSameWeekAsDate(date)
    }
    
    /**
    Returns true if dates are in the same year.
    
    - Parameter date: The date to compare.
    */
    func isSameYearAsDate(date: NSDate) -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: date)
        return comp1.year == comp2.year
    }
    
    /**
     Returns true if dates are in the same month
     
     - Parameter date: The date to compare
     */
    func isSameMonthAsDate(date: NSDate) -> Bool
    {
      let comp1 = NSDate.components(fromDate: self)
      let comp2 = NSDate.components(fromDate: date)
      
      return comp1.year == comp2.year && comp1.month == comp2.month
    }
  
    /**
    Returns true if date is this year.
    */
    func isThisYear() -> Bool
    {
        return self.isSameYearAsDate(NSDate())
    }
    
    /**
    Returns true if date is next year.
    */
    func isNextYear() -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: NSDate())
        return (comp1.year == comp2.year + 1)
    }
    
    /**
    Returns true if date is last year.
    */
    func isLastYear() -> Bool
    {
        let comp1 = NSDate.components(fromDate: self)
        let comp2 = NSDate.components(fromDate: NSDate())
        return (comp1.year == comp2.year - 1)
    }
    
    /**
    Returns true if date is earlier than date.
    
    - Parameter date: The date to compare.
    */
    func isEarlierThanDate(date: NSDate) -> Bool
    {
        return self.earlierDate(date) == self
    }
    
    /**
     Returns true if date is later than date.
     
     - Parameter date: The date to compare.
     */
    func isLaterThanDate(date: NSDate) -> Bool
    {
        return self.laterDate(date) == self
    }
    
    /**
    Returns true if date is in future.
    */
    func isInFuture() -> Bool
    {
        return self.isLaterThanDate(NSDate())
    }
    
    /**
    Returns true if date is in past.
    */
    func isInPast() -> Bool
    {
        return self.isEarlierThanDate(NSDate())
    }
    
    
    // MARK: Adjusting Dates
    
    /**
     Creates a new date by a adding months.
     
     - Parameter days: The number of months to add.
     - Returns A new date object.
     */
    func dateByAddingMonths(months: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.month = months
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
     Creates a new date by a substracting months.
     
     - Parameter days: The number of months to substract.
     - Returns A new date object.
     */
    func dateBySubtractingMonths(months: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.month = (months * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
     Creates a new date by a adding weeks.
     
     - Parameter days: The number of weeks to add.
     - Returns A new date object.
     */
    func dateByAddingWeeks(weeks: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.day = 7 * weeks
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
     Creates a new date by a substracting weeks.
     
     - Parameter days: The number of weeks to substract.
     - Returns A new date object.
     */
    func dateBySubtractingWeeks(weeks: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.day = ((7 * weeks) * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Creates a new date by a adding days.
    
    - Parameter days: The number of days to add.
    - Returns A new date object.
    */
    func dateByAddingDays(days: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.day = days
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Creates a new date by a substracting days.
    
    - Parameter days: The number of days to substract.
    - Returns A new date object.
    */
    func dateBySubtractingDays(days: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.day = (days * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Creates a new date by a adding hours.
    
    - Parameter days: The number of hours to add.
    - Returns A new date object.
    */
    func dateByAddingHours(hours: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.hour = hours
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Creates a new date by substracting hours.
    
    - Parameter days: The number of hours to substract.
    - Returns A new date object.
    */
    func dateBySubtractingHours(hours: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.hour = (hours * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Creates a new date by adding minutes.
    
    - Parameter days: The number of minutes to add.
    - Returns A new date object.
    */
    func dateByAddingMinutes(minutes: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.minute = minutes
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Creates a new date by substracting minutes.
    
    - Parameter days: The number of minutes to add.
    - Returns A new date object.
    */
    func dateBySubtractingMinutes(minutes: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.minute = (minutes * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
     Creates a new date by adding seconds.
     
     - Parameter seconds: The number of seconds to add.
     - Returns A new date object.
     */
    func dateByAddingSeconds(seconds: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.second = seconds
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
     Creates a new date by substracting seconds.
     
     - Parameter days: The number of seconds to substract.
     - Returns A new date object.
     */
    func dateBySubtractingSeconds(seconds: Int) -> NSDate
    {
        let dateComp = NSDateComponents()
        dateComp.second = (seconds * -1)
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComp, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
    Creates a new date from the start of the day.
    
    - Returns A new date object.
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
    Creates a new date from the end of the day.
    
    - Returns A new date object.
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
    Creates a new date from the start of the week.
    
    - Returns A new date object.
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
    Creates a new date from the end of the week.
    
    - Returns A new date object.
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
    Creates a new date from the first day of the month
    
    - Returns A new date object.
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
    Creates a new date from the last day of the month
    
    - Returns A new date object.
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
    
    /**
     Creates a new date based on tomorrow.
     
     - Returns A new date object.
     */
    class func tomorrow() -> NSDate
    {
        return NSDate().dateByAddingDays(1).dateAtStartOfDay()
    }
    
    /**
     Creates a new date based on yesterdat.
     
     - Returns A new date object.
     */
    class func yesterday() -> NSDate
    {
        return NSDate().dateBySubtractingDays(1).dateAtStartOfDay()
    }
    
    /**
     Return a new NSDate object with the new hour, minute and seconds values
     
     :returns: NSDate
     */
    func setTimeOfDate(hour hour: Int, minute: Int, second: Int) -> NSDate {
        let components = self.components()
        components.hour = hour
        components.minute = minute
        components.second = second
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    
    // MARK: Retrieving Intervals
    
    /**
    Gets the number of seconds after a date.
    
    - Parameter date: the date to compare.
    - Returns The number of seconds
    */
    func secondsAfterDate(date: NSDate) -> Int
    {
        return Int(self.timeIntervalSinceDate(date))
    }
    
    /**
     Gets the number of seconds before a date.
     
     - Parameter date: The date to compare.
     - Returns The number of seconds
     */
    func secondsBeforeDate(date: NSDate) -> Int
    {
        return Int(date.timeIntervalSinceDate(self))
    }
    
    /**
    Gets the number of minutes after a date.
    
    - Parameter date: the date to compare.
    - Returns The number of minutes
    */
    func minutesAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.minuteInSeconds())
    }
    
    /**
    Gets the number of minutes before a date.
    
    - Parameter date: The date to compare.
    - Returns The number of minutes
    */
    func minutesBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.minuteInSeconds())
    }
    
    /**
    Gets the number of hours after a date.
    
    - Parameter date: The date to compare.
    - Returns The number of hours
    */
    func hoursAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.hourInSeconds())
    }
    
    /**
    Gets the number of hours before a date.
    
    - Parameter date: The date to compare.
    - Returns The number of hours
    */
    func hoursBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.hourInSeconds())
    }
    
    /**
    Gets the number of days after a date.
    
    - Parameter date: The date to compare.
    - Returns The number of days
    */
    func daysAfterDate(date: NSDate) -> Int
    {
        let interval = self.timeIntervalSinceDate(date)
        return Int(interval / NSDate.dayInSeconds())
    }
    
    /**
    Gets the number of days before a date.
    
    - Parameter date: The date to compare.
    - Returns The number of days
    */
    func daysBeforeDate(date: NSDate) -> Int
    {
        let interval = date.timeIntervalSinceDate(self)
        return Int(interval / NSDate.dayInSeconds())
    }
    
    
    // MARK: Decomposing Dates
    
    /**
    Returns the nearest hour.
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
    */
    func year () -> Int { return self.components().year  }
    /**
    Returns the month component.
    */
    func month () -> Int { return self.components().month }
    /**
    Returns the week of year component.
    */
    func week () -> Int { return self.components().weekOfYear }
    /**
    Returns the day component.
    */
    func day () -> Int { return self.components().day }
    /**
    Returns the hour component.
    */
    func hour () -> Int { return self.components().hour }
    /**
    Returns the minute component.
    */
    func minute () -> Int { return self.components().minute }
    /**
    Returns the seconds component.
    */
    func seconds () -> Int { return self.components().second }
    /**
    Returns the weekday component.
    */
    func weekday () -> Int { return self.components().weekday }
    /**
    Returns the nth days component. e.g. 2nd Tuesday of the month is 2.
    */
    func nthWeekday () -> Int { return self.components().weekdayOrdinal }
    /**
    Returns the days of the month.
    */
    func monthDays () -> Int { return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length }
    /**
    Returns the first day of the week.
    */
    func firstDayOfWeek () -> Int {
        let distanceToStartOfWeek = NSDate.dayInSeconds() * Double(self.components().weekday - 1)
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return NSDate(timeIntervalSinceReferenceDate: interval).day()
    }
    /**
    Returns the last day of the week.
    */
    func lastDayOfWeek () -> Int {
        let distanceToStartOfWeek = NSDate.dayInSeconds() * Double(self.components().weekday - 1)
        let distanceToEndOfWeek = NSDate.dayInSeconds() * Double(7)
        let interval: NSTimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return NSDate(timeIntervalSinceReferenceDate: interval).day()
    }
    /**
    Returns true if a weekday.
    */
    func isWeekday() -> Bool {
        return !self.isWeekend()
    }
    /**
    Returns true if weekend.
    */
    func isWeekend() -> Bool {
        let range = NSCalendar.currentCalendar().maximumRangeOfUnit(NSCalendarUnit.Weekday)
        return (self.weekday() == range.location || self.weekday() == range.length)
    }
    
    
    // MARK: To String
    
    /**
    A string representation using short date and time style.
    */
    func toString() -> String {
        return self.toString(dateStyle: .ShortStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
    }
    
    /**
    A string representation based on a format.
    
    - Parameter format: The format of date can be .ISO8601(.ISO8601Format?), .DotNet, .RSS, .AltRSS or Custom(FormatString).
    - Parameter timeZone: The time zone to interpret the date can be .Local, .UTC applies to Custom format only
    - Returns The date string representation
    */
    func toString(format format: DateFormat, timeZone: TimeZone = .Local) -> String
    {
        var dateFormat: String
        let zone: NSTimeZone
        switch format {
        case .DotNet:
            let offset = NSTimeZone.defaultTimeZone().secondsFromGMT / 3600
            let nowMillis = 1000 * self.timeIntervalSince1970
            return  "/Date(\(nowMillis)\(offset))/"
        case .ISO8601(let isoFormat):
            dateFormat = (isoFormat != nil) ? isoFormat!.rawValue : ISO8601Format.DateTimeMilliSec.rawValue
            zone = NSTimeZone.localTimeZone()
        case .RSS:
            dateFormat = RSSFormat
            zone = NSTimeZone.localTimeZone()
        case .AltRSS:
            dateFormat = AltRSSFormat
            zone = NSTimeZone.localTimeZone()
        case .Custom(let string):
            switch timeZone {
            case .Local:
                zone = NSTimeZone.localTimeZone()
            case .UTC:
                zone = NSTimeZone(forSecondsFromGMT: 0)
            }
            dateFormat = string
        }
        
        let formatter = NSDate.formatter(format: dateFormat, timeZone: zone)
        return formatter.stringFromDate(self)
    }
    
    /**
    A string representation based on custom style.
    
    - Parameter dateStyle: The date style to use.
    - Parameter timeStyle: The time style to use.
    - Parameter doesRelativeDateFormatting: Enables relative date formatting.
    - Parameter timeZone: The time zone to use.
    - Parameter locale: The locale to use.
    - Returns A string representation of the date.
    */
    func toString(dateStyle dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle, doesRelativeDateFormatting: Bool = false, timeZone: NSTimeZone = NSTimeZone.localTimeZone(), locale: NSLocale = NSLocale.currentLocale()) -> String
    {
        let formatter = NSDate.formatter(dateStyle: dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: doesRelativeDateFormatting, timeZone: timeZone, locale: locale)
        return formatter.stringFromDate(self)
    }
    
    /**
    A string representation based on a relative time language. i.e. just now, 1 minute ago etc..
    */
    func relativeTimeToString() -> String
    {
        let time = self.timeIntervalSince1970
        let now = NSDate().timeIntervalSince1970
        
        let timeIsInPast = now - time > 0
        
        let seconds = abs(now - time)
        let minutes = round(seconds/60)
        let hours = round(minutes/60)
        let days = round(hours/24)
        
        func describe(time: String) -> String {
            if timeIsInPast { return "\(time) ago" }
            else { return "in \(time)" }
        }
        
        if seconds < 10 {
            return NSLocalizedString("just now", comment: "Show the relative time from a date")
        } else if seconds < 60 {
            let relativeTime = NSLocalizedString(describe("%.f seconds"), comment: "Show the relative time from a date")
            return String(format: relativeTime, seconds)
        }
        
        if minutes < 60 {
            if minutes == 1 {
                return NSLocalizedString(describe("1 minute"), comment: "Show the relative time from a date")
            } else {
                let relativeTime = NSLocalizedString(describe("%.f minutes"), comment: "Show the relative time from a date")
                return String(format: relativeTime, minutes)
            }
        }
        
        if hours < 24 {
            if hours == 1 {
                return NSLocalizedString(describe("1 hour"), comment: "Show the relative time from a date")
            } else {
                let relativeTime = NSLocalizedString(describe("%.f hours"), comment: "Show the relative time from a date")
                return String(format: relativeTime, hours)
            }
        }
        
        if days < 7 {
            if days == 1 {
                return NSLocalizedString(describe("1 day"), comment: "Show the relative time from a date")
            } else {
                let relativeTime = NSLocalizedString(describe("%.f days"), comment: "Show the relative time from a date")
                return String(format: relativeTime, days)
            }
        }
        
        return self.toString()
    }
    
    /**
    A string representation of the weekday.
    */
    func weekdayToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.weekdaySymbols[self.weekday()-1] as String
    }
    
    /**
    A short string representation of the weekday.
    */
    func shortWeekdayToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.shortWeekdaySymbols[self.weekday()-1] as String
    }
    
    /**
    A very short string representation of the weekday.
    
    - Returns String
    */
    func veryShortWeekdayToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.veryShortWeekdaySymbols[self.weekday()-1] as String
    }
    
    /**
    A string representation of the month.
    
    - Returns String
    */
    func monthToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.monthSymbols[self.month()-1] as String
    }
    
    /**
    A short string representation of the month.
    
    - Returns String
    */
    func shortMonthToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.shortMonthSymbols[self.month()-1] as String
    }
    
    /**
    A very short string representation of the month.
    
    - Returns String
    */
    func veryShortMonthToString() -> String {
        let formatter = NSDate.formatter()
        return formatter.veryShortMonthSymbols[self.month()-1] as String
    }
    
    
    // MARK: Static Cached Formatters
    
    /**
    Returns a cached static array of NSDateFormatters so that thy are only created once.
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
    Returns a cached formatter based on the format, timeZone and locale. Formatters are cached in a singleton array using hashkeys generated by format, timeZone and locale.
    
    - Parameter format: The format to use.
    - Parameter timeZone: The time zone to use, defaults to the local time zone.
    - Parameter locale: The locale to use, defaults to the current locale
    - Returns The date formatter.
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
    Returns a cached formatter based on date style, time style and relative date. Formatters are cached in a singleton array using hashkeys generated by date style, time style, relative date, timeZone and locale.
    
    - Parameter dateStyle: The date style to use.
    - Parameter timeStyle: The time style to use.
    - Parameter doesRelativeDateFormatting: Enables relative date formatting.
    - Parameter timeZone: The time zone to use.
    - Parameter locale: The locale to use.
    - Returns The date formatter.
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