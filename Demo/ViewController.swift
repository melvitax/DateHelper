//
//  ViewController.swift
//
//  Created by Melvin Rivera on 7/2/14.
//  Copyright (c) All rights reserved.
//

import Foundation
import UIKit

struct TableItem {
    let title: String
    let description: String
}

class ViewController: UITableViewController {
    
    let now = NSDate()
    var date = NSDate()
    
    var sections:[String] = []
    var items:[[TableItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: **** DATE FROM STRING ****
        sections.append("Date From String")
        var sectionItems = [TableItem]()
        
        // MARK: Date from string with custom format
        date = NSDate(fromString: "16 July 1972 6:12:00", format: .Custom("dd MMM yyyy HH:mm:ss"))
        sectionItems.append(TableItem(title: "Custom Format", description: "dd MMM yyyy HH:mm:ss = \(date.toString())"))
        
        // MARK: Date from ISO8601(Year) String
        date = NSDate(fromString:  "2009", format: .ISO8601(nil))
        sectionItems.append(TableItem(title: "ISO8601(Year)", description:  "2009 = \(date.toString())"))
        
        // MARK: Date from ISO8601(Year & Month) String
        date = NSDate(fromString:  "2009-08", format: .ISO8601(nil))
        sectionItems.append(TableItem(title: "ISO8601(Year & Month)", description:  "2009-08 = \(date.toString())"))
        
        // MARK: Date from ISO8601(Date) String
        date = NSDate(fromString:  "2009-08-11", format: .ISO8601(nil))
        sectionItems.append(TableItem(title: "ISO8601(Date)", description:  "2009-08-11 = \(date.toString())"))
        
        // MARK: Date from ISO8601(Date & Time) String
        date = NSDate(fromString:  "2009-08-11T06:00-07:00", format: .ISO8601(nil))
        sectionItems.append(TableItem(title: "ISO8601(Date & Time)", description:  "2009-08-11T06:00-07:00 = \(date.toString())"))
        
        // MARK: Date from ISO8601(Date & Time & Sec) String
        date = NSDate(fromString:  "2009-08-11T06:00:00-07:00", format: .ISO8601(nil))
        sectionItems.append(TableItem(title: "ISO8601(Date & Time & Sec)", description:  "2009-08-11T06:00:00-07:00 = \(date.toString())"))
        
        // MARK: Date from ISO8601(Date & Time & MilliSec) String
        date = NSDate(fromString: "2009-08-11T06:00:00.000-07:00", format: .ISO8601(nil))
        sectionItems.append(TableItem(title: "ISO8601(Date & Time & MilliSec)", description: "2009-08-11T06:00:00.000-07:00 = \(date.toString())"))
        
        // MARK: Date from DotNetJSON String
        date = NSDate(fromString: "/Date(1260123281843)/", format: .DotNet)
        sectionItems.append(TableItem(title: "DotNetJSON", description: "Date(1260123281843) = \(date.toString())"))
        
        // MARK: Date from RSS String
        date = NSDate(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .RSS)
        sectionItems.append(TableItem(title: "RSS", description:"Fri, 09 Sep 2011 15:26:08 +0200 = \(date.toString())"))
        
        // MARK: Date from AltRSS String
        date = NSDate(fromString: "09 Sep 2011 15:26:08 +0200", format: .AltRSS)
        sectionItems.append(TableItem(title: "Alt RSS", description: "09 Sep 2011 15:26:08 +0200 = \(date.toString())"))
        
        items.append(sectionItems)
        
        // MARK: **** CREATING DATES ****
        sectionItems = [TableItem]()
        sections.append("Creating Dates")
        sectionItems.append(TableItem(title: "Tomorrow", description: "\(NSDate.tomorrow())"))
        sectionItems.append(TableItem(title: "Yesterday", description: "\(NSDate.yesterday())"))
        items.append(sectionItems)
        
        // MARK: **** COMPARING DATES ****
        sections.append("Comparing Dates")
        sectionItems = [TableItem]()
        
        // MARK: isEqual
        var equality = now.isEqualToDateIgnoringTime(date) ? "is equal to" : "is not equal to"
        sectionItems.append(TableItem(title: "Is Equal To Date Ignoring Time", description: "\(now.toString()) \(equality) \(date.toString())"))
        
        // MARK: isToday
        equality = now.isToday() ? "is today" : "is not today"
        sectionItems.append(TableItem(title: "Today", description: "\(now.toString()) \(equality)"))
        
        // MARK: isTomorrow
        date = now.dateByAddingDays(1)
        equality = date.isTomorrow() ? "is tomorrow" : "is not tomorrow"
        sectionItems.append(TableItem(title: "Tomorrow", description: "\(date.toString()) \(equality)"))
        
        // MARK: isYesterday
        date = now.dateBySubtractingDays(1)
        equality = date.isYesterday() ? "is yesterday" : "is not yesterday"
        sectionItems.append(TableItem(title: "Yesterday", description: "\(date.toString()) \(equality)"))
        
        // MARK: isSameWeekAsDate
        equality = now.isSameWeekAsDate(date) ? "is same week as" : "is not same week as"
        sectionItems.append(TableItem(title: "Same Week", description: "\(now.toString()) \(equality) \(date.toString())"))
      
        // MARK: isSameMonthAsDate
        equality = now.isSameMonthAsDate(date) ? "is same month as" : "is not same month as"
        sectionItems.append(TableItem(title: "Same Month", description: "\(now.toString()) \(equality) \(date.toString())"))
      
        // MARK: isThisWeek
        equality = date.isThisWeek() ? "is this week" : "is not this week"
        sectionItems.append(TableItem(title: "This Week", description: "\(date.toString()) \(equality)"))
        
        // MARK: isNextWeek
        date = now.dateByAddingDays(7)
        equality = date.isNextWeek() ? "is next week" : "is not next week"
        sectionItems.append(TableItem(title: "Next Week", description: "\(date.toString()) \(equality)"))
        
        // MARK: isLastWeek
        date = now.dateBySubtractingDays(7)
        equality = date.isLastWeek() ? "is last week" : "is not last week"
        sectionItems.append(TableItem(title: "Last Week", description: "\(date.toString()) \(equality)"))
        
        // MARK: isSameYearAsDate
        equality = now.isSameYearAsDate(date) ? "is same year as" : "is not same year as"
        sectionItems.append(TableItem(title: "Same Year", description: "\(now.toString()) \(equality) \(date.toString())"))
        
        // MARK: dateByAddingDays
        date = now.dateByAddingDays(365)
        equality = date.isNextYear() ? "is next year" : "is not next year"
        sectionItems.append(TableItem(title: "Next Year", description: "\(date.toString()) \(equality)"))
        
        // MARK: dateBySubstractingDays
        date = now.dateBySubtractingDays(365)
        equality = date.isLastYear() ? "is last year" : "is not last year"
        sectionItems.append(TableItem(title: "Last Year", description: "\(date.toString()) \(equality)"))

        
        // MARK: isEarlierThanDate
        equality = date.isEarlierThanDate(now) ? "is earlier than now" : "is not earlier than now"
        sectionItems.append(TableItem(title: "Earlier Than", description: "\(date.toString()) \(equality)"))
        
        // MARK: isLaterThanDate
        equality = date.isLaterThanDate(now) ? "is later than now" : "is not later than now"
        sectionItems.append(TableItem(title: "Later Than", description: "\(date.toString()) \(equality)"))
        
        // MARK: isEarlierThanDate
        equality = date.isEarlierThanDate(now) ? "is earlier than now" : "is not earlier than now"
        sectionItems.append(TableItem(title: "Earlier Than", description: "\(date.toString()) \(equality)"))
        
        // MARK: isInFuture
        date = now.dateByAddingDays(1)
        equality = date.isInFuture() ? "is in the future" : "is not the future"
        sectionItems.append(TableItem(title: "Future", description: "\(date.toString()) \(equality)"))
        
        // MARK: isInPast
        date = now.dateBySubtractingDays(1)
        equality = date.isInPast() ? "is in the past" : "is not the past"
        sectionItems.append(TableItem(title: "Past", description: "\(date.toString()) \(equality)"))
        
        
        items.append(sectionItems)
        
        // MARK: **** ADJUSTING DATES ****
        sections.append("Adjusting Dates")
        sectionItems = [TableItem]()
        
        // MARK: dateByAddingMonths
        date = now.dateByAddingMonths(2)
        sectionItems.append(TableItem(title: "Adding Months", description: "+ 2 Months: \(date.toString())"))
        
        // MARK: dateBySubstractingMonths
        date = now.dateBySubtractingMonths(4)
        sectionItems.append(TableItem(title: "Substracting Months", description: "- 4 Months: \(date.toString())"))
        
        // MARK: dateByAddingWeeks
        date = now.dateByAddingWeeks(2)
        sectionItems.append(TableItem(title: "Adding Weeks", description: "+ 2 Weeks: \(date.toString())"))
        
        // MARK: dateBySubstractingWeeks
        date = now.dateBySubtractingWeeks(4)
        sectionItems.append(TableItem(title: "Substracting Weeks", description: "- 4 Weeks: \(date.toString())"))
        
        // MARK: dateByAddingDays
        date = now.dateByAddingDays(2)
        sectionItems.append(TableItem(title: "Adding Days", description: "+ 2 Days: \(date.toString())"))
        
        // MARK: dateBySubstractingDays
        date = now.dateBySubtractingDays(4)
        sectionItems.append(TableItem(title: "Substracting Days", description: "- 4 Days: \(date.toString())"))
        
        // MARK: dateByAddingHours
        date = now.dateByAddingHours(2)
        sectionItems.append(TableItem(title: "Adding Hours", description: "+ 2 Hours: \(date.toString())"))
        
        // MARK: dateBySubstractingHours
        date = now.dateBySubtractingHours(4)
        sectionItems.append(TableItem(title: "Substracting Hours", description: "- 4 Hours: \(date.toString())"))
        
        // MARK: dateByAddingMinutes
        date = now.dateByAddingMinutes(2)
        sectionItems.append(TableItem(title: "Adding Minutes", description: "+ 2 Minutes: \(date.toString())"))
        
        // MARK: dateBySubstractingMinutes
        date = now.dateBySubtractingMinutes(4)
        sectionItems.append(TableItem(title: "Substracting Minutes", description: "- 4 Minutes: \(date.toString())"))
        
        // MARK: dateByAddingSeconds
        date = now.dateByAddingSeconds(90)
        sectionItems.append(TableItem(title: "Adding Seconds", description: "+ 90 Seconds: \(date.toString())"))
        
        // MARK: dateBySubstractingSeconds
        date = now.dateBySubtractingSeconds(90)
        sectionItems.append(TableItem(title: "Substracting Seconds", description: "- 90 Minutes: \(date.toString())"))
        
        // MARK: dateAtStartOfDay
        date = now.dateAtStartOfDay()
        sectionItems.append(TableItem(title: "Start of Day", description: "\(date.toString())"))
        
        // MARK: dateAtEndOfDay
        date = now.dateAtEndOfDay()
        sectionItems.append(TableItem(title: "End of Day", description: "\(date.toString())"))
        
        // MARK: sateAtStartOfWeek
        date = now.dateAtStartOfWeek()
        sectionItems.append(TableItem(title: "Start of Week", description: "\(date.toString())"))
        
        // MARK: dateAtEndOfWeek
        date = now.dateAtEndOfWeek()
        sectionItems.append(TableItem(title: "End of Week", description: "\(date.toString())"))
        
        // MARK: dateAtStartOfMonth
        date = now.dateAtTheStartOfMonth()
        sectionItems.append(TableItem(title: "Start of Month", description: "\(date.toString())"))
        
        // MARK: dateAtEndOfMonth
        date = now.dateAtTheEndOfMonth()
        sectionItems.append(TableItem(title: "End of Month", description: "\(date.toString())"))
        
        // MARK: setTimeOfDate
        date = now.setTimeOfDate(hour: 6, minute: 30, second: 15)
        sectionItems.append(TableItem(title: "Set Time of Date", description: "\(date.toString())"))
        
        items.append(sectionItems)
        
        
        // MARK: **** TIME INTERVAL BETWEEN DATES ****
        sections.append("Time Intervals")
        sectionItems = [TableItem]()
        
        // MARK: secondsAfterDate
        var num = date.secondsAfterDate(now)
        sectionItems.append(TableItem(title: "Seconds After", description: "Interval from \(date.toString()): \(num)"))
        
        // MARK: secondsBeforeDate
        num = date.secondsBeforeDate(now)
        sectionItems.append(TableItem(title: "Seconds Before", description: "Interval from \(date.toString()): \(num)"))
        
        // MARK: minutesAfterDate
        num = date.minutesAfterDate(now)
        sectionItems.append(TableItem(title: "Minutes After", description: "Interval from \(date.toString()): \(num)"))
        
        // MARK: minutesBeforeDate
        num = date.minutesBeforeDate(now)
        sectionItems.append(TableItem(title: "Minutes Before", description: "Interval from \(date.toString()): \(num)"))
        
        // MARK: hoursAfterDate
        num = date.hoursAfterDate(now)
        sectionItems.append(TableItem(title: "Hours After", description: "Interval from \(date.toString()): \(num)"))
        
        // MARK: hoursBeforeDate
        num = date.hoursBeforeDate(now)
        sectionItems.append(TableItem(title: "Hours Before", description: "Interval from \(date.toString()): \(num)"))
        
        // MARK: daysAfterDate
        num = date.daysAfterDate(now)
        sectionItems.append(TableItem(title: "Days After", description: "Interval from \(date.toString()): \(num)"))
        
        // MARK: daysBeforeDate
        num = date.daysBeforeDate(now)
        sectionItems.append(TableItem(title: "Days Before", description: "Interval from \(date.toString()): \(num)"))
        
        items.append(sectionItems)
        
        
        // MARK: **** DECOMPOSING DATES ****
        sections.append("Decomposing Dates")
        sectionItems = [TableItem]()
        
        // MARK: Nearest Hour
        sectionItems.append(TableItem(title: "Nearest Hour", description: "\(now.nearestHour())"))
        // MARK: Year
        sectionItems.append(TableItem(title: "Year", description: "\(now.year())"))
        // MARK: Month
        sectionItems.append(TableItem(title: "Month", description: "\(now.month())"))
        // MARK: Week
        sectionItems.append(TableItem(title: "Week", description: "\(now.week())"))
        // MARK: Day
        sectionItems.append(TableItem(title: "Day", description: "\(now.day())"))
        // MARK: Hour
        sectionItems.append(TableItem(title: "Hour", description: "\(now.hour())"))
        // MARK: Minute
        sectionItems.append(TableItem(title: "Minute", description: "\(now.minute())"))
        // MARK: Seconds
        sectionItems.append(TableItem(title: "Seconds", description: "\(now.seconds())"))
        // MARK: Weekday
        sectionItems.append(TableItem(title: "Weekday", description: "\(now.weekday())"))
        // MARK: Nth Weekday
        sectionItems.append(TableItem(title: "Nth Weekday", description: "\(now.nthWeekday())"))
        // MARK: Month Days
        sectionItems.append(TableItem(title: "Month Days", description: "\(now.monthDays())"))
        // MARK: First Day Of Week
        sectionItems.append(TableItem(title: "First Day Of Week", description: "\(now.firstDayOfWeek())"))
        // MARK: Last Day Of Week
        sectionItems.append(TableItem(title: "Last Day Of Week", description: "\(now.lastDayOfWeek())"))
        // MARK: Is Weekday
        sectionItems.append(TableItem(title: "Is Weekday", description: "\(now.isWeekday())"))
        // MARK: Is Weekend
        sectionItems.append(TableItem(title: "Is Weekend", description: "\(now.isWeekend())"))
        items.append(sectionItems)
        
        // MARK: **** DATE TO STRING ****
        sections.append("Date To String")
        sectionItems = [TableItem]()
        
        // MARK: toString
        sectionItems.append(TableItem(title: "toString()", description: now.toString()))
        
        // MARK: toString Cutom Format
        sectionItems.append(TableItem(title: "Custom: dd MMM yyyy HH:mm:ss", description: now.toString(format: .Custom("dd MMM yyyy HH:mm:ss"))))
        
        // MARK: toString ISO8601(Year)
        sectionItems.append(TableItem(title: "ISO8601(Year)", description: now.toString(format: .ISO8601(ISO8601Format.Year))))
        
        // MARK: toString ISO8601(Year & Month)
        sectionItems.append(TableItem(title: "ISO8601(Year & Month)", description: now.toString(format: .ISO8601(ISO8601Format.YearMonth))))
        
        // MARK: toString ISO8601(Date)
        sectionItems.append(TableItem(title: "ISO8601(Date)", description: now.toString(format: .ISO8601(ISO8601Format.Date))))
        
        // MARK: toString ISO8601(Date & Time)
        sectionItems.append(TableItem(title: "ISO8601(Date & Time)", description: now.toString(format: .ISO8601(ISO8601Format.DateTime))))
        
        // MARK: toString ISO8601(Date & Time & Sec)
        sectionItems.append(TableItem(title: "ISO8601(Date & Time & Sec)", description: now.toString(format: .ISO8601(ISO8601Format.DateTimeSec))))
        
        // MARK: toString ISO8601(Date & Time & MilliSec)
        sectionItems.append(TableItem(title: "ISO8601(Date & Time & MilliSec)", description: now.toString(format: .ISO8601(ISO8601Format.DateTimeMilliSec))))
        
        // MARK: toString DotNet JSON
        sectionItems.append(TableItem(title: "DotNet JSON", description: now.toString(format: .DotNet)))
        
        // MARK: toString RSS
        sectionItems.append(TableItem(title: "RSS", description: now.toString(format: .RSS)))
        
        // MARK: toString AltRSS
        sectionItems.append(TableItem(title: "AltRSS", description: now.toString(format: .AltRSS)))
        
        // MARK: toString Short Date, No Time, Relative
        sectionItems.append(TableItem(title: "Short Date, No Time, Relative", description: now.toString(dateStyle: .ShortStyle, timeStyle: .NoStyle, doesRelativeDateFormatting: true)))
        
        // MARK: toString Short Date, Short Time, Not Relative
        sectionItems.append(TableItem(title: "Short Date, Short Time, Not Relative", description: now.toString(dateStyle: .ShortStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)))
        
        // MARK: toString Medium Date, Medium Time, Not Relative
        sectionItems.append(TableItem(title: "Medium Date, Medium Time, Not Relative", description: now.toString(dateStyle: .MediumStyle, timeStyle: .MediumStyle, doesRelativeDateFormatting: false)))
        
        // MARK: toString Long Date, Long Time, Not Relative
        sectionItems.append(TableItem(title: "Long Date, Long Time, Not Relative", description: now.toString(dateStyle: .LongStyle, timeStyle: .LongStyle, doesRelativeDateFormatting: false)))
        
        // MARK: toString Full Date, Full Time, Not Relative
        sectionItems.append(TableItem(title: "Full Date, Full Time, Not Relative", description: now.toString(dateStyle: .FullStyle, timeStyle: .FullStyle, doesRelativeDateFormatting: false)))
        
        // MARK: Relative Time
        sectionItems.append(TableItem(title: "Relative Time", description: now.relativeTimeToString()))
        
        items.append(sectionItems)
        
        // MARK: **** DATE COMPONENTS TO STRING ****
        
        sections.append("Date Components")
        sectionItems = [TableItem]()
        
        // MARK: Weekday
        sectionItems.append(TableItem(title: "Weekday", description: now.weekdayToString()))
        
        // MARK: Short Weekday
        sectionItems.append(TableItem(title: "Short Weekday", description: now.shortWeekdayToString()))
        
        // MARK: Very Short Weekday
        sectionItems.append(TableItem(title: "Very Short Weekday", description: now.veryShortWeekdayToString()))
        
        // MARK: Month
        sectionItems.append(TableItem(title: "Month", description: now.monthToString()))
        
        // MARK: Short Month
        sectionItems.append(TableItem(title: "Short Month", description: now.shortMonthToString()))
        
        // MARK: Very Short Month
        sectionItems.append(TableItem(title: "Very Short Month", description: now.veryShortMonthToString()))
        
        
        items.append(sectionItems)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let item = items[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.description
        
        return cell
    }
    
    
    
    
    
}
