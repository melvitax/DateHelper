//
//  AFDateHelper.swift
//  https://github.com/melvitax/DateHelper
//  Version 4.3.0
//
//  Created by Melvin Rivera on 7/15/14.
//  Copyright (c) 2014. All rights reserved.
//

import Foundation


public extension Date {
    
    // MARK: Convert from String
    
    /*
        Initializes a new Date() objext based on a date string, format, optional timezone and optional locale.
     
        - Returns: A Date() object if successfully converted from string or nil.
    */
    init?(fromString string: String, format:DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Foundation.Locale.current, isLenient: Bool = true) {
        guard !string.isEmpty else {
            return nil
        }
        var string = string
        switch format {
            case .dotNet:
                let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
                let regex = try! NSRegularExpression(pattern: pattern)
                guard let match = regex.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) else {
                    return nil
                }
                 #if swift(>=4.0)
                let dateString = (string as NSString).substring(with: match.range(at: 1))
                #else
                let dateString = (string as NSString).substring(with: match.rangeAt(1))
                #endif
                let interval = Double(dateString)! / 1000.0
                self.init(timeIntervalSince1970: interval)
                return
            case .rss, .altRSS:
                if string.hasSuffix("Z") {
                    string = string[..<string.index(string.endIndex, offsetBy: -1)].appending("GMT")
                }
            default:
                break
        }
        let formatter = Date.cachedDateFormatters.cachedFormatter(
            format.stringFormat,
            timeZone: timeZone.timeZone,
            locale: locale, 
            isLenient: isLenient)
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self.init(timeInterval:0, since:date)
    }
    
    // MARK: Convert to String
    
    
    /// Converts the date to string using the short date and time style.
    func toString(style:DateStyleType = .short) -> String {
        switch style {
        case .short:
            return self.toString(dateStyle: .short, timeStyle: .short, isRelative: false)
        case .medium:
            return self.toString(dateStyle: .medium, timeStyle: .medium, isRelative: false)
        case .long:
            return self.toString(dateStyle: .long, timeStyle: .long, isRelative: false)
        case .full:
            return self.toString(dateStyle: .full, timeStyle: .full, isRelative: false)
        case .ordinalDay:
            let formatter = Date.cachedDateFormatters.cachedNumberFormatter()
            if #available(iOSApplicationExtension 9.0, *) {
                formatter.numberStyle = .ordinal
            }
            return formatter.string(from: component(.day)! as NSNumber)!
        case .weekday:
            let weekdaySymbols = Date.cachedDateFormatters.cachedFormatter().weekdaySymbols!
            let string = weekdaySymbols[component(.weekday)!-1] as String
            return string
        case .shortWeekday:
            let shortWeekdaySymbols = Date.cachedDateFormatters.cachedFormatter().shortWeekdaySymbols!
            return shortWeekdaySymbols[component(.weekday)!-1] as String
        case .veryShortWeekday:
            let veryShortWeekdaySymbols = Date.cachedDateFormatters.cachedFormatter().veryShortWeekdaySymbols!
            return veryShortWeekdaySymbols[component(.weekday)!-1] as String
        case .month:
            let monthSymbols = Date.cachedDateFormatters.cachedFormatter().monthSymbols!
            return monthSymbols[component(.month)!-1] as String
        case .shortMonth:
            let shortMonthSymbols = Date.cachedDateFormatters.cachedFormatter().shortMonthSymbols!
            return shortMonthSymbols[component(.month)!-1] as String
        case .veryShortMonth:
            let veryShortMonthSymbols = Date.cachedDateFormatters.cachedFormatter().veryShortMonthSymbols!
            return veryShortMonthSymbols[component(.month)!-1] as String
        }
    }
    
    /// Converts the date to string based on a date format, optional timezone and optional locale.
    func toString(format: DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Locale.current) -> String {
        switch format {
        case .dotNet:
            let offset = Foundation.NSTimeZone.default.secondsFromGMT() / 3600
            let nowMillis = 1000 * self.timeIntervalSince1970
            return String(format: format.stringFormat, nowMillis, offset)
        default:
            break
        }
        let formatter = Date.cachedDateFormatters.cachedFormatter(format.stringFormat, timeZone: timeZone.timeZone, locale: locale)
        return formatter.string(from: self)
    }
    
    /// Converts the date to string based on DateFormatter's date style and time style with optional relative date formatting, optional time zone and optional locale.
    func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, isRelative: Bool = false, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current) -> String {
        let formatter = Date.cachedDateFormatters.cachedFormatter(dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: isRelative, timeZone: timeZone, locale: locale)
        return formatter.string(from: self)
    }
    
    /// Converts the date to string based on a relative time language. i.e. just now, 1 minute ago etc...
    func toStringWithRelativeTime(strings:[RelativeTimeStringType:String]? = nil) -> String {
        
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        let isPast = now - time > 0
        
        let sec:Double = abs(now - time)
        let min:Double = round(sec/60)
        let hr:Double = round(min/60)
        let d:Double = round(hr/24)
        
        if sec < 60 {
            if sec < 10 {
                if isPast {
                    return strings?[.nowPast] ?? NSLocalizedString("just now", comment: "Date format")
                } else {
                    return strings?[.nowFuture] ?? NSLocalizedString("in a few seconds", comment: "Date format")
                }
            } else {
                let string:String
                if isPast {
                    string = strings?[.secondsPast] ?? NSLocalizedString("%.f seconds ago", comment: "Date format")
                } else {
                    string = strings?[.secondsFuture] ?? NSLocalizedString("in %.f seconds", comment: "Date format")
                }
                return String(format: string, sec)
            }
        }
        if min < 60 {
            if min == 1 {
                if isPast {
                    return strings?[.oneMinutePast] ?? NSLocalizedString("1 minute ago", comment: "Date format")
                } else {
                    return strings?[.oneMinuteFuture] ?? NSLocalizedString("in 1 minute", comment: "Date format")
                }
            } else {
                let string:String
                if isPast {
                    string = strings?[.minutesPast] ?? NSLocalizedString("%.f minutes ago", comment: "Date format")
                } else {
                    string = strings?[.minutesFuture] ?? NSLocalizedString("in %.f minutes", comment: "Date format")
                }
                return String(format: string, min)
            }
        }
        if hr < 24 {
            if hr == 1 {
                if isPast {
                    return strings?[.oneHourPast] ?? NSLocalizedString("last hour", comment: "Date format")
                } else {
                    return strings?[.oneHourFuture] ?? NSLocalizedString("next hour", comment: "Date format")
                }
            } else {
                let string:String
                if isPast {
                    string = strings?[.hoursPast] ?? NSLocalizedString("%.f hours ago", comment: "Date format")
                } else {
                    string = strings?[.hoursFuture] ?? NSLocalizedString("in %.f hours", comment: "Date format")
                }
                return String(format: string, hr)
            }
        }
        if d < 7 {
            if d == 1 {
                if isPast {
                    return strings?[.oneDayPast] ?? NSLocalizedString("yesterday", comment: "Date format")
                } else {
                    return strings?[.oneDayFuture] ?? NSLocalizedString("tomorrow", comment: "Date format")
                }
            } else {
                let string:String
                if isPast {
                    string = strings?[.daysPast] ?? NSLocalizedString("%.f days ago", comment: "Date format")
                } else {
                    string = strings?[.daysFuture] ?? NSLocalizedString("in %.f days", comment: "Date format")
                }
                return String(format: string, d)
            }
        }
        if d < 28 {
            if isPast {
                if compare(.isLastWeek) {
                    return strings?[.oneWeekPast] ?? NSLocalizedString("last week", comment: "Date format")
                } else {
                    let string = strings?[.weeksPast] ?? NSLocalizedString("%.f weeks ago", comment: "Date format")
                    return String(format: string, Double(abs(since(Date(), in: .week))))
                }
            } else {
                if compare(.isNextWeek) {
                    return strings?[.oneWeekFuture] ?? NSLocalizedString("next week", comment: "Date format")
                } else {
                    let string = strings?[.weeksFuture] ?? NSLocalizedString("in %.f weeks", comment: "Date format")
                    return String(format: string, Double(abs(since(Date(), in: .week))))
                }
            }
        }
        if compare(.isThisYear) {
            if isPast {
                if compare(.isLastMonth) {
                    return strings?[.oneMonthPast] ?? NSLocalizedString("last month", comment: "Date format")
                } else {
                    let string = strings?[.monthsPast] ?? NSLocalizedString("%.f months ago", comment: "Date format")
                    return String(format: string, Double(abs(since(Date(), in: .month))))
                }
            } else {
                if compare(.isNextMonth) {
                    return strings?[.oneMonthFuture] ?? NSLocalizedString("next month", comment: "Date format")
                } else {
                    let string = strings?[.monthsFuture] ?? NSLocalizedString("in %.f months", comment: "Date format")
                    return String(format: string, Double(abs(since(Date(), in: .month))))
                }
            }
        }
        if isPast {
            if compare(.isLastYear) {
                return strings?[.oneYearPast] ?? NSLocalizedString("last year", comment: "Date format")
            } else {
                let string = strings?[.yearsPast] ?? NSLocalizedString("%.f years ago", comment: "Date format")
                return String(format: string, Double(abs(since(Date(), in: .year))))
            }
        } else {
            if compare(.isNextYear) {
                return strings?[.oneYearFuture] ?? NSLocalizedString("next year", comment: "Date format")
            } else {
                let string = strings?[.yearsFuture] ?? NSLocalizedString("in %.f years", comment: "Date format")
                return String(format: string, Double(abs(since(Date(), in: .year))))
            }
        }
    }
    
    
    // MARK: Compare Dates
    
    /// Compares dates to see if they are equal while ignoring time.
    func compare(_ comparison:DateComparisonType) -> Bool {
        switch comparison {
            case .isToday:
                return compare(.isSameDay(as: Date()))
            case .isTomorrow:
                let comparison = Date().adjust(.day, offset:1)
                return compare(.isSameDay(as: comparison))
            case .isYesterday:
                let comparison = Date().adjust(.day, offset: -1)
                return compare(.isSameDay(as: comparison))
            case .isSameDay(let date):
                return component(.year) == date.component(.year)
                    && component(.month) == date.component(.month)
                    && component(.day) == date.component(.day)
            case .isThisWeek:
                return self.compare(.isSameWeek(as: Date()))
            case .isNextWeek:
                let comparison = Date().adjust(.week, offset:1)
                return compare(.isSameWeek(as: comparison))
            case .isLastWeek:
                let comparison = Date().adjust(.week, offset:-1)
                return compare(.isSameWeek(as: comparison))
            case .isSameWeek(let date):
                if component(.week) != date.component(.week) {
                    return false
                }
                // Ensure time interval is under 1 week
                return abs(self.timeIntervalSince(date)) < Date.weekInSeconds
            case .isThisMonth:
                return self.compare(.isSameMonth(as: Date()))
            case .isNextMonth:
                let comparison = Date().adjust(.month, offset:1)
                return compare(.isSameMonth(as: comparison))
            case .isLastMonth:
                let comparison = Date().adjust(.month, offset:-1)
                return compare(.isSameMonth(as: comparison))
            case .isSameMonth(let date):
                return component(.year) == date.component(.year) && component(.month) == date.component(.month)
            case .isThisYear:
                return self.compare(.isSameYear(as: Date()))
            case .isNextYear:
                let comparison = Date().adjust(.year, offset:1)
                return compare(.isSameYear(as: comparison))
            case .isLastYear:
                let comparison = Date().adjust(.year, offset:-1)
                return compare(.isSameYear(as: comparison))
            case .isSameYear(let date):
                return component(.year) == date.component(.year)
            case .isInTheFuture:
                return self.compare(.isLater(than: Date()))
            case .isInThePast:
                return self.compare(.isEarlier(than: Date()))
            case .isEarlier(let date):
                return (self as NSDate).earlierDate(date) == self
            case .isLater(let date):
                return (self as NSDate).laterDate(date) == self
        case .isWeekday:
            return !compare(.isWeekend)
        case .isWeekend:
            let range = Calendar.current.maximumRange(of: Calendar.Component.weekday)!
            return (component(.weekday) == range.lowerBound || component(.weekday) == range.upperBound - range.lowerBound)
        }
        
    }
 
    
    // MARK: Adjust dates
    
    /// Creates a new date with adjusted components
    
    func adjust(_ component:DateComponentType, offset:Int) -> Date {
        var dateComp = DateComponents()
        switch component {
            case .second:
                dateComp.second = offset
            case .minute:
                dateComp.minute = offset
            case .hour:
                dateComp.hour = offset
            case .day:
                dateComp.day = offset
            case .weekday:
                dateComp.weekday = offset
            case .nthWeekday:
                dateComp.weekdayOrdinal = offset
            case .week:
                dateComp.weekOfYear = offset
            case .month:
                dateComp.month = offset
            case .year:
                dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    /// Return a new Date object with the new hour, minute and seconds values.
    func adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date {
        var comp = Date.components(self)
        comp.month = month ?? comp.month
        comp.day = day ?? comp.day
        comp.hour = hour ?? comp.hour
        comp.minute = minute ?? comp.minute
        comp.second = second ?? comp.second
        return Calendar.current.date(from: comp)!
    }
    
    // MARK: Date for...
    
    func dateFor(_ type:DateForType, calendar:Calendar = Calendar.current) -> Date {
        switch type {
        case .startOfDay:
            return adjust(hour: 0, minute: 0, second: 0)
        case .endOfDay:
            return adjust(hour: 23, minute: 59, second: 59)
        case .startOfWeek:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        case .endOfWeek:
            let offset = 7 - component(.weekday)!
            return adjust(.day, offset: offset)
        case .startOfMonth:
            return adjust(hour: 0, minute: 0, second: 0, day: 1)
        case .endOfMonth:
            let month = (component(.month) ?? 0) + 1
            return adjust(hour: 0, minute: 0, second: 0, day: 0, month: month)
        case .tomorrow:
            return adjust(.day, offset:1)
        case .yesterday:
            return adjust(.day, offset:-1)
        case .nearestMinute(let nearest):
            let minutes = (component(.minute)! + nearest/2) / nearest * nearest
            return adjust(hour: nil, minute: minutes, second: nil)
        case .nearestHour(let nearest):
            let hours = (component(.hour)! + nearest/2) / nearest * nearest
            return adjust(hour: hours, minute: 0, second: nil)
        }
    }
    
    // MARK: Time since...
    
    func since(_ date:Date, in component:DateComponentType) -> Int64 {
        switch component {
        case .second:
            return Int64(timeIntervalSince(date))
        case .minute:
            let interval = timeIntervalSince(date)
            return Int64(interval / Date.minuteInSeconds)
        case .hour:
            let interval = timeIntervalSince(date)
            return Int64(interval / Date.hourInSeconds)
        case .day:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .day, in: .era, for: self)
            let start = calendar.ordinality(of: .day, in: .era, for: date)
            return Int64(end! - start!)
        case .weekday: 
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekday, in: .era, for: self)
            let start = calendar.ordinality(of: .weekday, in: .era, for: date)
            return Int64(end! - start!)
        case .nthWeekday:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: self)
            let start = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: date)
            return Int64(end! - start!)
        case .week:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekOfYear, in: .era, for: self)
            let start = calendar.ordinality(of: .weekOfYear, in: .era, for: date)
            return Int64(end! - start!)
        case .month:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .month, in: .era, for: self)
            let start = calendar.ordinality(of: .month, in: .era, for: date)
            return Int64(end! - start!)
        case .year:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .year, in: .era, for: self)
            let start = calendar.ordinality(of: .year, in: .era, for: date)
            return Int64(end! - start!)
            
        }
    }
    
    
    // MARK: Extracting components
    
    func component(_ component:DateComponentType) -> Int? {
        let components = Date.components(self)
        switch component {
        case .second:
            return components.second
        case .minute:
            return components.minute
        case .hour:
            return components.hour
        case .day:
            return components.day
        case .weekday:
            return components.weekday
        case .nthWeekday:
            return components.weekdayOrdinal
        case .week:
            return components.weekOfYear
        case .month:
            return components.month
        case .year:
            return components.year
        }
    }
    
    func numberOfDaysInMonth() -> Int {
        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self)!
        return range.upperBound - range.lowerBound
    }
    
    func firstDayOfWeek() -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds * Double(self.component(.weekday)! - 1)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)!
    }
    
    func lastDayOfWeek() -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds * Double(self.component(.weekday)! - 1)
        let distanceToEndOfWeek = Date.dayInSeconds * Double(7)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)!
    }
    
    
    // MARK: Internal Components
    
    internal static func componentFlags() -> Set<Calendar.Component> { return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear] }
    internal static func components(_ fromDate: Date) -> DateComponents {
        return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }
  
    internal class concurrentFormatterCache {
        private static let cachedDateFormattersQueue = DispatchQueue(
            label: "date-formatter-queue",
            attributes: .concurrent
        )
        
        private static let cachedNumberFormatterQueue = DispatchQueue(
            label: "number-formatter-queue",
            attributes: .concurrent
        )
        
        private static var cachedDateFormatters = [String: DateFormatter]()
        private static var cachedNumberFormatter = NumberFormatter()
        
        private func register(hashKey: String, formatter: DateFormatter) -> Void {
            concurrentFormatterCache.cachedDateFormattersQueue.async(flags: .barrier) {
                concurrentFormatterCache.cachedDateFormatters.updateValue(formatter, forKey: hashKey)
            }

        }
        
        private func retrieve(hashKey: String) -> DateFormatter? {
            let dateFormatter = concurrentFormatterCache.cachedDateFormattersQueue.sync { () -> DateFormatter? in
                guard let result = concurrentFormatterCache.cachedDateFormatters[hashKey] else { return nil }
                
                return result.copy() as? DateFormatter
            }
            
            return dateFormatter
        }
        
        private func retrieve() -> NumberFormatter {
            let numberFormatter = concurrentFormatterCache.cachedNumberFormatterQueue.sync { () -> NumberFormatter in
                
                // Should always be NumberFormatter
                return concurrentFormatterCache.cachedNumberFormatter.copy() as! NumberFormatter
            }
            
            return numberFormatter
        }
        
        public func cachedFormatter(_ format: String = DateFormatType.standard.stringFormat,
                                    timeZone: Foundation.TimeZone = Foundation.TimeZone.current,
                                    locale: Locale = Locale.current, isLenient: Bool = true) -> DateFormatter {
            
                let hashKey = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
                
                if Date.cachedDateFormatters.retrieve(hashKey: hashKey) == nil {
                    let formatter = DateFormatter()
                    formatter.dateFormat = format
                    formatter.timeZone = timeZone
                    formatter.locale = locale
                    formatter.isLenient = isLenient
                    Date.cachedDateFormatters.register(hashKey: hashKey, formatter: formatter)
                }
            
                return Date.cachedDateFormatters.retrieve(hashKey: hashKey)!
        }
        
        /// Generates a cached formatter based on the provided date style, time style and relative date.
        /// Formatters are cached in a singleton array using hashkeys.
        public func cachedFormatter(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, doesRelativeDateFormatting: Bool, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current, isLenient: Bool = true) -> DateFormatter {
            let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
            if Date.cachedDateFormatters.retrieve(hashKey: hashKey) == nil {
                let formatter = DateFormatter()
                formatter.dateStyle = dateStyle
                formatter.timeStyle = timeStyle
                formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
                formatter.timeZone = timeZone
                formatter.locale = locale
                formatter.isLenient = isLenient
                Date.cachedDateFormatters.register(hashKey: hashKey, formatter: formatter)
            }

            return Date.cachedDateFormatters.retrieve(hashKey: hashKey)!
        }
        
        public func cachedNumberFormatter() -> NumberFormatter {
            return Date.cachedDateFormatters.retrieve()
        }
        
    }
    
    /// A cached static array of DateFormatters so that thy are only created once.
    private static var cachedDateFormatters = concurrentFormatterCache()
    
    // MARK: Intervals In Seconds
    internal static let minuteInSeconds:Double = 60
    internal static let hourInSeconds:Double = 3600
    internal static let dayInSeconds:Double = 86400
    internal static let weekInSeconds:Double = 604800
    internal static let yearInSeconds:Double = 31556926
    
}

// MARK: Enums used


/**
 The string format used for date string conversion.
 
 ````
 case isoYear: i.e. 1997
 case isoYearMonth: i.e. 1997-07
 case isoDate: i.e. 1997-07-16
 case isoDateTime: i.e. 1997-07-16T19:20+01:00
 case isoDateTimeSec: i.e. 1997-07-16T19:20:30+01:00
 case isoDateTimeMilliSec: i.e. 1997-07-16T19:20:30.45+01:00
 case dotNet: i.e. "/Date(1268123281843)/"
 case rss: i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
 case altRSS: i.e. "09 Sep 2011 15:26:08 +0200"
 case httpHeader: i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
 case standard: "EEE MMM dd HH:mm:ss Z yyyy"
 case custom(String): a custom date format string
 ````
 
 */
public enum DateFormatType {
    
    /// The ISO8601 formatted year "yyyy" i.e. 1997
    case isoYear
    
    /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
    case isoYearMonth
    
    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
    case isoDate
    
    /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
    case isoDateTime
    
    /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
    case isoDateTimeSec
    
    /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
    case isoDateTimeMilliSec
    
    /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
    case dotNet
    
    /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
    case rss
    
    /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
    case altRSS
    
    /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
    case httpHeader
    
    /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
    case standard
    
    /// A custom date format string
    case custom(String)
    
    var stringFormat:String {
        switch self {
        case .isoYear: return "yyyy"
        case .isoYearMonth: return "yyyy-MM"
        case .isoDate: return "yyyy-MM-dd"
        case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
        case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .dotNet: return "/Date(%d%f)/"
        case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
        case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
        case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
        case .custom(let customFormat): return customFormat
        }
    }
}

extension DateFormatType: Equatable {
    public static func ==(lhs: DateFormatType, rhs: DateFormatType) -> Bool {
        switch (lhs, rhs) {
        case (.custom(let lhsString), .custom(let rhsString)):
            return lhsString == rhsString
        default:
            return lhs == rhs
        }
    }
}

/// The time zone to be used for date conversion
public enum TimeZoneType {
    case local, `default`, utc, custom(Int)
    var timeZone:TimeZone {
        switch self {
        case .local: return NSTimeZone.local
        case .default: return NSTimeZone.default
        case .utc: return TimeZone(secondsFromGMT: 0)!
        case let .custom(gmt): return TimeZone(secondsFromGMT: gmt)!
        }
    }
}

// The string keys to modify the strings in relative format
public enum RelativeTimeStringType {
    case nowPast, nowFuture, secondsPast, secondsFuture, oneMinutePast, oneMinuteFuture, minutesPast, minutesFuture, oneHourPast, oneHourFuture, hoursPast, hoursFuture, oneDayPast, oneDayFuture, daysPast, daysFuture, oneWeekPast, oneWeekFuture, weeksPast, weeksFuture, oneMonthPast, oneMonthFuture, monthsPast, monthsFuture, oneYearPast, oneYearFuture, yearsPast, yearsFuture
}

// The type of comparison to do against today's date or with the suplied date.
public enum DateComparisonType {
    
    // Days
    
    /// Checks if date today.
    case isToday
    /// Checks if date is tomorrow.
    case isTomorrow
    /// Checks if date is yesterday.
    case isYesterday
    /// Compares date days
    case isSameDay(as:Date)
    
    // Weeks
    
    /// Checks if date is in this week.
    case isThisWeek
    /// Checks if date is in next week.
    case isNextWeek
    /// Checks if date is in last week.
    case isLastWeek
    /// Compares date weeks
    case isSameWeek(as:Date)
    
    // Months
    
    /// Checks if date is in this month.
    case isThisMonth
    /// Checks if date is in next month.
    case isNextMonth
    /// Checks if date is in last month.
    case isLastMonth
    /// Compares date months
    case isSameMonth(as:Date)
    
    // Years
    
    /// Checks if date is in this year.
    case isThisYear
    /// Checks if date is in next year.
    case isNextYear
    /// Checks if date is in last year.
    case isLastYear
    /// Compare date years
    case isSameYear(as:Date)
    
    // Relative Time
    
    /// Checks if it's a future date
    case isInTheFuture
    /// Checks if the date has passed
    case isInThePast
    /// Checks if earlier than date
    case isEarlier(than:Date)
    /// Checks if later than date
    case isLater(than:Date)
    /// Checks if it's a weekday
    case isWeekday
    /// Checks if it's a weekend
    case isWeekend
    
}

// The date components available to be retrieved or modifed
public enum DateComponentType {
    case second, minute, hour, day, weekday, nthWeekday, week, month, year
}
    

// The type of date that can be used for the dateFor function.
public enum DateForType {
    case startOfDay, endOfDay, startOfWeek, endOfWeek, startOfMonth, endOfMonth, tomorrow, yesterday, nearestMinute(minute:Int), nearestHour(hour:Int)
}

// Convenience types for date to string conversion
public enum DateStyleType {
    /// Short style: "2/27/17, 2:22 PM"
    case short
    /// Medium style: "Feb 27, 2017, 2:22:06 PM"
    case medium
    /// Long style: "February 27, 2017 at 2:22:06 PM EST"
    case long
    /// Full style: "Monday, February 27, 2017 at 2:22:06 PM Eastern Standard Time"
    case full
    /// Ordinal day: "27th"
    case ordinalDay
    /// Weekday: "Monday"
    case weekday
    /// Short week day: "Mon"
    case shortWeekday
    /// Very short weekday: "M"
    case veryShortWeekday
    /// Month: "February"
    case month
    /// Short month: "Feb"
    case shortMonth
    /// Very short month: "F"
    case veryShortMonth
}
