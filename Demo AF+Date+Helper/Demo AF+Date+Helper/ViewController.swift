//
//  ViewController.swift
//
//  Created by Melvin Rivera on 7/2/14.
//  Copyright (c) All rights reserved.
//

import Foundation
import UIKit



class ViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let now = NSDate()
        var date = NSDate()
        
        
        /* DATE FROM STRING */
        
        println("\nDate From String")
        
        // Date from string with custom format
        date = NSDate(fromString: "16 July 1972 6:12:00 ", format: .Custom("dd MMM yyyy HH:mm:ss"))
        println("Custom: \(date)")
        
        // Date from ISO8601 String
        date = NSDate(fromString: "1972-07-16T08:15:30-05:00", format: .ISO8601)
        println("ISO8601: \(date)")
        
        // Date from DotNetJSON String
        date = NSDate(fromString: "/Date(1260123281843)/", format: .DotNet)
        println("DotNetJSON: \(date)")
        
        // Date from RSS String
        date = NSDate(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .RSS)
        println("RSS: \(date)")
        
        // Date from AltRSS String
        date = NSDate(fromString: "09 Sep 2011 15:26:08 +0200", format: .AltRSS)
        println("Alt RSS: \(date)")
        
                
        /* COMPARING DATES */
        println("\nComparing Dates: \(now) and \(date)")
        var equality = now.isEqualToDate(date) ? "is equal" : "is not equal"
        println(equality)
        
        equality = now.isToday() ? "is today" : "is not today"
        println(equality)
        
        equality = now.isTomorrow() ? "is tomorrow" : "is not tomorrow"
        println(equality)
        
        equality = now.isYesterday() ? "is yesterday" : "is not yesterday"
        println(equality)
        
        equality = now.isSameWeekAsDate(date) ? "is same week as" : "is not same week as"
        println(equality)
        
        equality = now.isThisWeek() ? "is this week" : "is not this week"
        println(equality)
        
        equality = now.isNextWeek() ? "is next week" : "is not next week"
        println(equality)
        
        equality = now.isLasttWeek() ? "is last week" : "is not last week"
        println(equality)
        
        equality = now.isSameYearAsDate(date) ? "is same year as" : "is not same year as"
        println(equality)
        
        equality = now.isThisYear() ? "is this year" : "is not this year"
        println(equality)
        
        equality = now.isNextYear() ? "is next year" : "is not next year"
        println(equality)
        
        equality = now.isLastYear() ? "is last year" : "is not last year"
        println(equality)
        
        
        /* ADJUSTING DATES */
        
        println("\nAdjusting Dates")
        
        date = now.dateByAddingDays(2)
        println("Adding 2 days: \(date)")
        
        date = now.dateBySubtractingDays(4)
        println("Subtracting 4 days: \(date)")
        
        date = now.dateByAddingHours(2)
        println("Adding 2 hours: \(date)")
        
        date = now.dateBySubtractingHours(4)
        println("Subtracting 4 hours: \(date)")
        
        date = now.dateByAddingMinutes(2)
        println("Adding 2 minutes: \(date)")
        
        date = now.dateBySubtractingMinutes(4)
        println("Subtracting 4 minutes: \(date)")
        
        date = now.dateAtStartOfDay()
        println("Start of day: \(date)")
        
        date = now.dateAtEndOfDay()
        println("End of day: \(date)")
        
        date = now.dateAtStartOfWeek()
        println("Start of week: \(date)")
        
        date = now.dateAtEndOfWeek()
        println("End of week: \(date)")
        
        
        /* TIME INTERVAL BETWEEN DATES */
        
        println("\nTime Interval between: \(date) and Now")
        
        var num = date.minutesAfterDate(now)
        println("Minutes after: \(num)")
        
        num = date.minutesBeforeDate(now)
        println("Minutes before: \(num)")
        
        num = date.hoursAfterDate(now)
        println("Hours after: \(num)")
        
        num = date.hoursBeforeDate(now)
        println("Hours before: \(num)")
        
        num = date.daysAfterDate(now)
        println("Days after: \(num)")
        
        num = date.daysBeforeDate(now)
        println("Days before: \(num)")
        
        
        /* DECOMPOSING DATES */
        
        println("\nDecomposing Date: \(now.toString())")
        println("nearest hour \(now.nearestHour())")
        println("year \(now.year())")
        println("month \(now.month())")
        println("week \(now.week())")
        println("day \(now.day())")
        println("hour \(now.hour())")
        println("minute \(now.minute())")
        println("seconds \(now.seconds())")
        println("weekday \(now.weekday())")
        println("nthWeekday \(now.nthWeekday())")
        println("monthDays \(now.monthDays())")
        println("firstDayOfWeek \(now.firstDayOfWeek())")
        println("lastDayOfWeek \(now.lastDayOfWeek())")
        println("isWeekday \(now.isWeekday())")
        println("isWeekend \(now.isWeekend())")
        
        
        /* DATE TO STRING */
        println("\nDate To String")
        
        var string = now.toString()
        println("Default: \(string)")
        
        string = now.toString(format: .Custom("dd MMM yyyy HH:mm:ss"))
        println("Custom format: \(string)")
        
        string = now.toString(format: .ISO8601)
        println("ISO8601: \(string)")

        
        string = now.toString(format: .DotNet)
        println("DotNet JSON: \(string)")
        
        string = now.toString(format: .RSS)
        println("RSS: \(string)")
        
        string = now.toString(format: .AltRSS)
        println("AltRSS: \(string)")
        
        string = now.toString(dateStyle: .ShortStyle, timeStyle: .NoStyle, doesRelativeDateFormatting: true)
        println("Short Date, No Time format plus relative: \(string)")
        
        string = now.toString(dateStyle: .ShortStyle, timeStyle: .NoStyle, doesRelativeDateFormatting: false)
        println("Short Date And No Time: \(string)")
        
        string = now.toString(dateStyle: .MediumStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
        println("Medium Date And Short Time: \(string)")
        
        string = now.toString(dateStyle: .LongStyle, timeStyle: .LongStyle, doesRelativeDateFormatting: false)
        println("Long Date And Short Time: \(string)")
        
        string = now.toString(dateStyle: .FullStyle, timeStyle: .FullStyle, doesRelativeDateFormatting: false)
        println("Full Date And Full Time: \(string)")
        
        string = now.relativeTimeToString()
        println("Relative time to string: \(string)")
        
        /* DATE COMPONENTS TO STRING */
        
        println("\nDate Components To String Fromm Date: \(now.toString())")
        
        string = now.weekdayToString()
        println("Weekday: \(string)")
        
        string = now.shortWeekdayToString()
        println("Short Weekday: \(string)")
        
        string = now.veryShortWeekdayToString()
        println("Very Short Weekday: \(string)")
        
        string = now.monthToString()
        println("Month: \(string)")
        
        string = now.shortMonthToString()
        println("Short Month: \(string)")
        
        string = now.veryShortMonthToString()
        println("Very Short Month: \(string)")
        
        
    }


}

