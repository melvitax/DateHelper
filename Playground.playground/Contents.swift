//: Playground - noun: a place where people can play

import UIKit
import DateHelper

let now = Date()
let thirtySecondsForward = now.adjust(.second, offset: 30)
let thirtySecondsBack = now.adjust(.second, offset: -30)
let lastHour = now.adjust(.hour, offset: -1)
let nextHour = now.adjust(.hour, offset: 1)
let twoHoursForward = now.adjust(.hour, offset: 2)
let twoHoursBack = now.adjust(.hour, offset: -2)
let tomorrow = now.dateFor(.tomorrow)
let yesterday = now.dateFor(.yesterday)
let twoDaysForward = now.adjust(.day, offset: 2)
let twoDaysBack = now.adjust(.day, offset: -2)
let nextWeek = now.adjust(.week, offset: 1)
let lastWeek = now.adjust(.week, offset: -1)
let twoWeeksForward = now.adjust(.week, offset: -2)
let twoWeeksBack = now.adjust(.week, offset: 2)
let nextMonth = now.adjust(.month, offset: 1)
let lastMonth = now.adjust(.month, offset: -1)
let twoMonthsForward = now.adjust(.month, offset: 2)
let twoMonthsBack = now.adjust(.month, offset: -2)
let nextYear = now.adjust(.year, offset: 1)
let lastYear = now.adjust(.year, offset: -1)
let twoYearsForward = now.adjust(.year, offset: 2)
let twoYearsBack = now.adjust(.year, offset: -2)

/***********************
    Date From Sring
 ***********************/

// Custom format
Date(fromString: "16 July 1972 6:12:00", format: .custom("dd MMM yyyy HH:mm:ss"))
// ISO8601 Year
Date(fromString: "2009", format: .isoYear)
// ISO8601 Year and Month
Date(fromString: "2009-08", format: .isoYearMonth)
// ISO8601 Date
Date(fromString: "2009-08-11", format: .isoDate)
// ISO8601 Date & Time
Date(fromString: "2009-08-11T06:00-07:00", format: .isoDateTime)
// ISO8601 Date & Time & Sec
Date(fromString: "2009-08-11T06:00:00-07:00", format: .isoDateTimeSec)
// ISO8601 Date & Time & MilliSec
Date(fromString: "2009-08-11T06:00:00.000-07:00", format: .isoDateTimeMilliSec)
// DotNet
Date(fromString: "/Date(1260123281843)/", format: .dotNet)
// RSS
Date(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .rss)
// AltRSS
Date(fromString: "09 Sep 2011 15:26:08 +0200", format: .altRSS)
// HTTP Header
Date(fromString: "Wed, 01 03 2017 06:43:19 -0500", format: .httpHeader)


/***********************
    Date To String
 ***********************/

now.toString(style: .short)
now.toString(style: .medium)
now.toString(style: .long)
now.toString(style: .full)
now.toString(style: .ordinalDay)
now.toString(style: .weekday)
now.toString(style: .shortWeekday)
now.toString(style: .veryShortWeekday)
now.toString(style: .month)
now.toString(style: .shortMonth)
now.toString(style: .veryShortMonth)

now.toString(format: .isoYear)
now.toString(format: .isoYearMonth)
now.toString(format: .isoDate)
now.toString(format: .isoDateTime)
now.toString(format: .isoDateTimeSec)
now.toString(format: .isoDateTimeMilliSec)
now.toString(format: .dotNet)
now.toString(format: .rss)
now.toString(format: .altRSS)
now.toString(format: .httpHeader)
now.toString(format: .standard)
now.toString(format: .custom("dd MMM yyyy HH:mm:ss"))

now.toString(dateStyle: .short, timeStyle: .none, isRelative: true)
now.toString(dateStyle: .none, timeStyle: .short)
now.toString(dateStyle: .short, timeStyle: .none)
now.toString(dateStyle: .short, timeStyle: .short)
now.toString(dateStyle: .medium, timeStyle: .medium)
now.toString(dateStyle: .long, timeStyle: .long)
now.toString(dateStyle: .full, timeStyle: .full)

now.toStringWithRelativeTime()
now.toStringWithRelativeTime(strings: [.nowPast:"now"])
thirtySecondsForward.toStringWithRelativeTime()
thirtySecondsBack.toStringWithRelativeTime()
lastHour.toStringWithRelativeTime()
nextHour.toStringWithRelativeTime()
twoHoursForward.toStringWithRelativeTime()
twoHoursBack.toStringWithRelativeTime()
yesterday.toStringWithRelativeTime()
tomorrow.toStringWithRelativeTime()
twoDaysForward.toStringWithRelativeTime()
twoDaysBack.toStringWithRelativeTime()
lastWeek.toStringWithRelativeTime()
nextWeek.toStringWithRelativeTime()
twoWeeksForward.toStringWithRelativeTime()
twoWeeksBack.toStringWithRelativeTime()
nextYear.toStringWithRelativeTime()
lastYear.toStringWithRelativeTime()
twoYearsForward.toStringWithRelativeTime()
twoYearsBack.toStringWithRelativeTime()


/***********************
    Comparing Dates
 ***********************/

// Is today
tomorrow.compare(.isToday)
now.compare(.isToday)

// Is tomorrow
now.compare(.isTomorrow)
tomorrow.compare(.isTomorrow)

// Is yesterday
now.compare(.isYesterday)
yesterday.compare(.isYesterday)

// Is same day
now.compare(.isSameDay(as: yesterday))
now.compare(.isSameDay(as: now))

// Is same week as date
now.compare(.isSameWeek(as: yesterday))
now.compare(.isSameWeek(as: now))

// Is same month as date
now.compare(.isSameMonth(as: nextMonth))
now.compare(.isSameMonth(as: now))

// Is this week
nextWeek.compare(.isThisWeek)
now.compare(.isThisWeek)

// Is next week
now.compare(.isNextWeek)
nextWeek.compare(.isNextWeek)

// Is last week
now.compare(.isLastWeek)
lastWeek.compare(.isLastWeek)

// Is same year
now.compare(.isSameYear(as: nextYear))
now.compare(.isSameYear(as: tomorrow))

// Is next year
now.compare(.isNextYear)
nextYear.compare(.isNextYear)

// Is last year
now.compare(.isLastYear)
lastYear.compare(.isLastYear)

// Earlier than
tomorrow.compare(.isEarlier(than: now))
lastWeek.compare(.isEarlier(than: now))

// Later than
yesterday.compare(.isLater(than: now))
nextWeek.compare(.isLater(than: now))

// Future
now.compare(.isInTheFuture)
nextWeek.compare(.isInTheFuture)

// Past
tomorrow.compare(.isInThePast)
lastWeek.compare(.isInThePast)


/***********************
    Adjusting Dates
 ***********************/

now.adjust(.second, offset: 110)
now.adjust(.minute, offset: 60)
now.adjust(.hour, offset: 2)
now.adjust(.day, offset: 1)
now.adjust(.weekday, offset: 2)
now.adjust(.nthWeekday, offset: 1)
now.adjust(.week, offset: 1)
now.adjust(.month, offset: 1)
now.adjust(.year, offset: 1)
now.adjust(hour: 12, minute: 0, second: 0)


/***********************
    Create Dates For
 ***********************/

now.dateFor(.startOfDay)
now.dateFor(.endOfDay)
now.dateFor(.startOfWeek)
var calendar = Calendar(identifier: .gregorian)
calendar.firstWeekday = 2
now.dateFor(.startOfWeek, calendar: calendar)
now.dateFor(.endOfWeek)
now.dateFor(.startOfMonth)
now.dateFor(.endOfMonth)
now.dateFor(.tomorrow)
now.dateFor(.yesterday)
now.dateFor(.nearestMinute(minute:30))
now.dateFor(.nearestHour(hour:2))



/***********************
    Time Since In...
 ***********************/

now.since(thirtySecondsBack, in: .second)
now.since(twoHoursBack, in: .minute)
now.since(twoHoursBack, in: .hour)
now.since(yesterday, in: .day)
now.since(nextWeek, in: .week)
now.since(twoWeeksBack, in: .nthWeekday)
now.since(lastWeek, in: .week)
now.since(lastMonth, in: .month)
now.since(lastYear, in: .year)


/***********************
  Extracting Components
 ***********************/

now.component(.second)
now.component(.minute)
now.component(.hour)
now.component(.day)
now.component(.weekday)
now.component(.nthWeekday)
now.component(.month)
now.component(.year)

now.numberOfDaysInMonth()
now.firstDayOfWeek()
now.lastDayOfWeek()



