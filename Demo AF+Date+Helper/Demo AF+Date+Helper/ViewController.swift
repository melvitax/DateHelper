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

class ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    let now = NSDate()
    var date = NSDate()
    
    var sections:[String] = []
    var items:[[TableItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /* DATE FROM STRING */
        sections.append("Date From String")
        var sectionItems = [TableItem]()
        
        // Date from string with custom format
        date = NSDate(fromString: "16 July 1972 6:12:00", format: .Custom("dd MMM yyyy HH:mm:ss"))
        sectionItems.append(TableItem(title: "Custom Format", description: "dd MMM yyyy HH:mm:ss = \(date.toString())"))
        
        // Date from ISO8601 String
        date = NSDate(fromString: "1972-07-16T08:15:30-05:00", format: .ISO8601)
        sectionItems.append(TableItem(title: "ISO8601", description: "1972-07-16T08:15:30-05:00 = \(date.toString())"))
        
        // Date from DotNetJSON String
        date = NSDate(fromString: "/Date(1260123281843)/", format: .DotNet)
        sectionItems.append(TableItem(title: "DotNetJSON", description: "Date(1260123281843) = \(date.toString())"))
        
        // Date from RSS String
        date = NSDate(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .RSS)
        sectionItems.append(TableItem(title: "RSS", description:"Fri, 09 Sep 2011 15:26:08 +0200 = \(date.toString())"))
        
        // Date from AltRSS String
        date = NSDate(fromString: "09 Sep 2011 15:26:08 +0200", format: .AltRSS)
        sectionItems.append(TableItem(title: "Alt RSS", description: "09 Sep 2011 15:26:08 +0200 = \(date.toString())"))
        
        items.append(sectionItems)
        
        /* COMPARING DATES */
        sections.append("Comparing Dates")
        sectionItems = [TableItem]()
        
        var equality = now.isEqualToDate(date) ? "is equal to" : "is not equal to"
        sectionItems.append(TableItem(title: "Is Equal", description: "\(now.toString()) \(equality) \(date.toString())"))
        
        equality = now.isToday() ? "is today" : "is not today"
        sectionItems.append(TableItem(title: "Today", description: "\(now.toString()) \(equality)"))
        
        date = now.dateByAddingDays(1)
        equality = date.isTomorrow() ? "is tomorrow" : "is not tomorrow"
        sectionItems.append(TableItem(title: "Tomorrow", description: "\(date.toString()) \(equality)"))
        
        date = now.dateBySubtractingDays(1)
        equality = date.isYesterday() ? "is yesterday" : "is not yesterday"
        sectionItems.append(TableItem(title: "Yesterday", description: "\(date.toString()) \(equality)"))
        
        equality = now.isSameWeekAsDate(date) ? "is same week as" : "is not same week as"
        sectionItems.append(TableItem(title: "Same Week", description: "\(date.toString()) \(equality) \(date.toString())"))
        
        equality = date.isThisWeek() ? "is this week" : "is not this week"
        sectionItems.append(TableItem(title: "This Week", description: "\(date.toString()) \(equality)"))
        
        date = now.dateByAddingDays(7)
        equality = date.isNextWeek() ? "is next week" : "is not next week"
        sectionItems.append(TableItem(title: "Next Week", description: "\(date.toString()) \(equality)"))
        
        date = now.dateBySubtractingDays(7)
        equality = date.isLastWeek() ? "is last week" : "is not last week"
        sectionItems.append(TableItem(title: "Last Week", description: "\(date.toString()) \(equality)"))
        
        equality = now.isSameYearAsDate(date) ? "is same year as" : "is not same year as"
        sectionItems.append(TableItem(title: "Same Year", description: "\(now.toString()) \(equality) \(date.toString())"))
        
        equality = date.isThisYear() ? "is this year" : "is not this year"
        sectionItems.append(TableItem(title: "This Year", description: "\(date.toString()) \(equality)"))
        
        date = now.dateByAddingDays(365)
        equality = date.isNextYear() ? "is next year" : "is not next year"
        sectionItems.append(TableItem(title: "Next Year", description: "\(date.toString()) \(equality)"))
        
        date = now.dateBySubtractingDays(365)
        equality = date.isLastYear() ? "is last year" : "is not last year"
        sectionItems.append(TableItem(title: "Last Year", description: "\(date.toString()) \(equality)"))
        
        items.append(sectionItems)
        
        /* ADJUSTING DATES */
        sections.append("Adjusting Dates")
        sectionItems = [TableItem]()
        
        date = now.dateByAddingDays(2)
        sectionItems.append(TableItem(title: "Adding Days", description: "+ 2 Days: \(date.toString())"))
        
        date = now.dateBySubtractingDays(4)
        sectionItems.append(TableItem(title: "Substracting Days", description: "- 4 Days: \(date.toString())"))
        
        date = now.dateByAddingHours(2)
        sectionItems.append(TableItem(title: "Adding Hours", description: "+ 2 Hours: \(date.toString())"))
        
        date = now.dateBySubtractingHours(4)
        sectionItems.append(TableItem(title: "Substracting Hours", description: "- 4 Hours: \(date.toString())"))
        
        date = now.dateByAddingMinutes(2)
        sectionItems.append(TableItem(title: "Adding Minutes", description: "+ 2 Minutes: \(date.toString())"))
        
        date = now.dateBySubtractingMinutes(4)
        sectionItems.append(TableItem(title: "Substracting Minutes", description: "- 4 Minutes: \(date.toString())"))
        
        date = now.dateAtStartOfDay()
        sectionItems.append(TableItem(title: "Start of Day", description: "\(date.toString())"))
        
        date = now.dateAtEndOfDay()
        sectionItems.append(TableItem(title: "End of Day", description: "\(date.toString())"))
        
        date = now.dateAtStartOfWeek()
        sectionItems.append(TableItem(title: "Start of Week", description: "\(date.toString())"))
        
        date = now.dateAtEndOfWeek()
        sectionItems.append(TableItem(title: "End of Week", description: "\(date.toString())"))
        
        items.append(sectionItems)
        
        
        /* TIME INTERVAL BETWEEN DATES */
        sections.append("Time Intervals")
        sectionItems = [TableItem]()
        
        var num = date.minutesAfterDate(now)
        sectionItems.append(TableItem(title: "Minutes After", description: "Interval from \(date.toString()): \(num)"))
        
        num = date.minutesBeforeDate(now)
        sectionItems.append(TableItem(title: "Minutes Before", description: "Interval from \(date.toString()): \(num)"))
        
        num = date.hoursAfterDate(now)
        sectionItems.append(TableItem(title: "Hours After", description: "Interval from \(date.toString()): \(num)"))
        
        num = date.hoursBeforeDate(now)
        sectionItems.append(TableItem(title: "Hours Before", description: "Interval from \(date.toString()): \(num)"))
        
        num = date.daysAfterDate(now)
        sectionItems.append(TableItem(title: "Days After", description: "Interval from \(date.toString()): \(num)"))
        
        num = date.daysBeforeDate(now)
        sectionItems.append(TableItem(title: "Days Before", description: "Interval from \(date.toString()): \(num)"))
        
        items.append(sectionItems)
        
        
        /* DECOMPOSING DATES */
        sections.append("Decomposing Dates")
        sectionItems = [TableItem]()
        
        sectionItems.append(TableItem(title: "Nearest Hour", description: "\(now.nearestHour())"))
        sectionItems.append(TableItem(title: "Year", description: "\(now.year())"))
        sectionItems.append(TableItem(title: "Month", description: "\(now.month())"))
        sectionItems.append(TableItem(title: "Week", description: "\(now.week())"))
        sectionItems.append(TableItem(title: "Day", description: "\(now.day())"))
        sectionItems.append(TableItem(title: "Hour", description: "\(now.hour())"))
        sectionItems.append(TableItem(title: "Minute", description: "\(now.minute())"))

        sectionItems.append(TableItem(title: "Seconds", description: "\(now.seconds())"))
        sectionItems.append(TableItem(title: "Weekday", description: "\(now.weekday())"))
        sectionItems.append(TableItem(title: "Nth Weekday", description: "\(now.nthWeekday())"))
        sectionItems.append(TableItem(title: "Month Days", description: "\(now.monthDays())"))
        sectionItems.append(TableItem(title: "First Day Of Week", description: "\(now.firstDayOfWeek())"))
        sectionItems.append(TableItem(title: "Last Day Of Week", description: "\(now.lastDayOfWeek())"))
        sectionItems.append(TableItem(title: "Is Weekday", description: "\(now.isWeekday())"))
        sectionItems.append(TableItem(title: "Is Weekend", description: "\(now.isWeekend())"))
        items.append(sectionItems)

        /* DATE TO STRING */
        sections.append("Date To String")
        sectionItems = [TableItem]()
        
        sectionItems.append(TableItem(title: "toString()", description: now.toString()))
        
        sectionItems.append(TableItem(title: "Custom: dd MMM yyyy HH:mm:ss", description: now.toString(format: .Custom("dd MMM yyyy HH:mm:ss"))))
        
        sectionItems.append(TableItem(title: "ISO8601", description: now.toString(format: .ISO8601)))
        
        sectionItems.append(TableItem(title: "DotNet JSON", description: now.toString(format: .DotNet)))
        
        sectionItems.append(TableItem(title: "RSS", description: now.toString(format: .RSS)))
        
        sectionItems.append(TableItem(title: "AltRSS", description: now.toString(format: .AltRSS)))
        
        sectionItems.append(TableItem(title: "Short Date, No Time, Relative", description: now.toString(dateStyle: .ShortStyle, timeStyle: .NoStyle, doesRelativeDateFormatting: true)))
        
        sectionItems.append(TableItem(title: "Short Date, Short Time, Not Relative", description: now.toString(dateStyle: .ShortStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)))
        
        sectionItems.append(TableItem(title: "Medium Date, Medium Time, Not Relative", description: now.toString(dateStyle: .MediumStyle, timeStyle: .MediumStyle, doesRelativeDateFormatting: false)))
        
        sectionItems.append(TableItem(title: "Long Date, Long Time, Not Relative", description: now.toString(dateStyle: .LongStyle, timeStyle: .LongStyle, doesRelativeDateFormatting: false)))
        
        sectionItems.append(TableItem(title: "Full Date, Full Time, Not Relative", description: now.toString(dateStyle: .FullStyle, timeStyle: .FullStyle, doesRelativeDateFormatting: false)))
        
        sectionItems.append(TableItem(title: "Relative Time", description: now.relativeTimeToString()))
        
        items.append(sectionItems)
        
        /* DATE COMPONENTS TO STRING */
        
        sections.append("Date Components")
        sectionItems = [TableItem]()
        
        sectionItems.append(TableItem(title: "Weekday", description: now.weekdayToString()))
        
        sectionItems.append(TableItem(title: "Short Weekday", description: now.shortWeekdayToString()))
        
        sectionItems.append(TableItem(title: "Very Short Weekday", description: now.veryShortWeekdayToString()))
        
        sectionItems.append(TableItem(title: "Month", description: now.monthToString()))
        
        sectionItems.append(TableItem(title: "Short Month", description: now.shortMonthToString()))
        
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
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let item = items[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.description
        
        return cell
    }
    
    
    


}

