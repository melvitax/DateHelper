# DateHelper

[![License](https://img.shields.io/badge/License-MIT-lightgrey)](https://github.com/melvitax/DateHelper/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS-lightgrey)](https://github.com/melvitax/DateHelper)
[![Cocoapods Compatible](https://img.shields.io/badge/Cocoapods-Deprecated-red)](http://cocoapods.org/pods/AFDateHelpe)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-Compatible-green)](https://github.com/Carthage/Carthage)
[![Swift Package Manager Compatible](https://img.shields.io/badge/Swift%20Package%20Manager-Compatible-green)](https://swift.org/package-manager/)

![Sample Project Screenshot](https://raw.githubusercontent.com/melvitax/DateHelper/master/logo.png "Date Helper")

A high performant Swift Date Extension for creating, converting, comparing, or modifying dates. 


## Capabilities

### Creating a Date from a String
Provides two initializers to create a date from string.

- **detectFromString:**  
`init?(detectFromString string: String)`  
Uses NSDataDetector to detect a date from natural language in a string. It works similar to how Apple Mail detects dates. This initializer is not as efficient as **fromString:format:** and should not be used in collections like lists.

```Swift
Date(detectFromString: "It happened on August 11 of 2009")
Date(detectFromString: "Tomorrow at 5:30 PM")
```

- **fromString:format:**  
`init?(fromString string: String, format:DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Foundation.Locale.current, isLenient: Bool = true) `  
Initializes a date from a string using a strict or custom format that is cached, highly performant and thread safe.

```Swift
 Date(fromString: "2009", format: .isoYear)
 Date(fromString: "2009-08", format: .isoYearMonth)
 Date(fromString: "2009-08-11", format: .isoDate)
 Date(fromString: "2009-08-11T06:00-07:00", format: .isoDateTime)
 Date(fromString: "2009-08-11T06:00:00-07:00", format: .isoDateTimeSec)
 Date(fromString: "2009-08-11T06:00:00.000-07:00", format: .isoDateTimeMilliSec)
 Date(fromString: "/Date(1260123281843)/", format: .dotNet)
 Date(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .rss)
 Date(fromString: "09 Sep 2011 15:26:08 +0200", format: .altRSS)
 Date(fromString: "Wed, 01 03 2017 06:43:19 -0500", format: .httpHeader)
 Date(fromString: "16 July 1972 6:12:00", format: .custom("dd MMM yyyy HH:mm:ss"))

```

### Convert a Date to a String
Provides three ways to convert a Date object to string

- **toString(style:)**  
`func toString(style:DateStyleType = .short) -> String`  
Converts a date to string based on a pre-desfined style

```Swift
Date().toString(style: .short)
Date().toString(style: .medium)
Date().toString(style: .long)
Date().toString(style: .full)
Date().toString(style: .ordinalDay)
Date().toString(style: .weekday)
Date().toString(style: .shortWeekday)
Date().toString(style: .veryShortWeekday)
Date().toString(style: .month)
Date().toString(style: .shortMonth)
Date().toString(style: .veryShortMonth)
```

- **toString(format:)**  
`func toString(format: DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Locale.current) -> String`  
Converts a date to string based on a predefined or custom format

```Swift
Date().toString(format: .custom("MMM d, yyyy"))
Date().toString(format: .custom("h:mm a"))
Date().toString(format: .custom("MMM d"))
Date().toString(format: .custom("MMM d"))
Date().toString(format: .isoYear)
Date().toString(format: .isoYearMonth)
Date().toString(format: .isoDate)
Date().toString(format: .isoDateTime)
Date().toString(format: .isoDateTimeSec)
Date().toString(format: .isoDateTimeMilliSec)
Date().toString(format: .dotNet)
Date().toString(format: .rss)
Date().toString(format: .altRSS)
Date().toString(format: .httpHeader)
```

- **toString(dateStyle:timeStyle)**  
`func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, isRelative: Bool = false, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current) -> String`  
Converts a date to string based on a predefined date and time style

```Swift 
Date().toString(dateStyle: .none, timeStyle: .short)
Date().toString(dateStyle: .short, timeStyle: .none)
Date().toString(dateStyle: .short, timeStyle: .short)
Date().toString(dateStyle: .medium, timeStyle: .medium)
Date().toString(dateStyle: .long, timeStyle: .long)
Date().toString(dateStyle: .full, timeStyle: .full)
```

### Compare Dates
Provides common checks like isToday or isNextWeek. It can also check against another date like isSameDay or isEarlier.

- **Quick Checks**  
 Checks date against common scenarios  
 `func compare(_ comparison: DateComparisonType) -> Bool`

```Swift
Date().compare(.isToday) 
Date().compare(.isTomorrow)
Date().compare(.isYesterday)
Date().compare(.isThisWeek)
Date().compare(.isNextWeek)
Date().compare(.isLastWeek)
Date().compare(.isThisYear)
Date().compare(.isNextYear)
Date().compare(.isLastYear)
Date().compare(.isInTheFuture)
Date().compare(.isInThePast)
```

- **Comparing Dates**  
Checks first date against second date  
 `func compare(_ comparison: DateComparisonType) -> Bool`

```Swift
firstDate.compare(.isSameDay(as: secondDate))
firstDate.compare(.isSameWeek(as: secondDate))
firstDate.compare(.isSameMonth(as: secondDate))
firstDate.compare(.isSameYear(as: secondDate))
firstDate.compare(.isEarlier(than: secondDate))
firstDate.compare(.isLater(than: secondDate))
```

### Adjust dates
Provides two functions for adjusting dates

- **adjust(_ component:, offset:)**  
Offsets the specified date compontent of a date  
`func adjust(_ component:DateComponentType, offset:Int) -> Date`

```Swift
Date().adjust(.second, offset: 110)
Date().adjust(.minute, offset: 60)
Date().adjust(.hour, offset: 2)
Date().adjust(.day, offset: 1)
Date().adjust(.weekday, offset: 2)
Date().adjust(.nthWeekday, offset: 1)
Date().adjust(.week, offset: 1)
Date().adjust(.month, offset: 1)
Date().adjust(.year, offset: 1)
```
- **adjust(hour:minute:second:)**  
Offsets the specified time component of the date  
`func adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date`

```Swift
Date().adjust(hour: 12, minute: 0, second: 0)
```

### Create Dates for...  
Provides convenience date creators for common scenarios like endOfDay, startOfDay etc.  
`func dateFor(_ type:DateForType, calendar:Calendar = Calendar.current) -> Date`  

```Swift 
Date().dateFor(.startOfDay)
Date().dateFor(.endOfDay)
Date().dateFor(.startOfWeek)
Date().dateFor(.endOfWeek)
Date().dateFor(.startOfMonth)
Date().dateFor(.endOfMonth)
Date().dateFor(.tomorrow)
Date().dateFor(.yesterday)
Date().dateFor(.nearestMinute(minute:30))
Date().dateFor(.nearestHour(hour:2)) 
Date().dateFor(.startOfYear)
Date().dateFor(.endOfYear)
```

### Time since...  
Returns a number in the specified unit of measure since the secondary date.  
`func since(_ date:Date, in component:DateComponentType) -> Int64`  

```Swift
Date().since(secondDate, in: .second)
Date().since(secondDate, in: .minute)
Date().since(secondDate, in: .hour)
Date().since(secondDate, in: .day)
Date().since(secondDate, in: .week)
Date().since(secondDate, in: .nthWeekday)
Date().since(secondDate, in: .week)
Date().since(secondDate, in: .month)
Date().since(secondDate, in: .year)  
```
### Miscellaneous
**Setting the start day of the week**  

```Swift
var calendar = Calendar(identifier: .gregorian)
calendar.firstWeekday = 2 // sets the week to start on Monday
Date().dateFor(.startOfWeek, calendar: calendar)
```

**Extracting components from a date**. 

```Swift
Date().component(.second)
Date().component(.minute)
Date().component(.hour)
Date().component(.day)
Date().component(.weekday)
Date().component(.nthWeekday)
Date().component(.month)
Date().component(.year)
```

**Extracting miscellaneous items from a date**. 

```Swift
Date().numberOfDaysInMonth()
Date().firstDayOfWeek()
Date().lastDayOfWeek()
```

## Custom Component guide

**Unicode Date Field Symbol Guide**

| Format  | Description | Example |
| ------------- | ------------- | ------------- |
| "y" | 1 digit min year | 1, 42, 2017 |
| "yy" | 2 digit year | 01, 42, 17 |
| "yyy" | 3 digit min year | 001, 042, 2017 |
| "yyyy" | 4 digit min year | 0001, 0042, 2017 |
| "M" | 1 digit min month | 7, 12 |
| "MM" | 2 digit month  | 07, 12 |
| "MMM" | 3 letter month abbr. | Jul, Dec |
| "MMMM" | Full month | July, December |
| "MMMMM" | 1 letter month abbr. | J, D |
| "d" | 1 digit min day | 4, 25 |
| "dd" | 2 digit day | 04, 25 |
| "E", "EE", "EEE" | 3 letter day name abbr. | Wed, Thu |
| "EEEE" | full day name | Wednesday, Thursday |
| "EEEEE" | 1 letter day name abbr. | W, T |
| "EEEEEE" | 2 letter day name abbr. | We, Th |
| "a" | Period of day | AM, PM |
| "h" | AM/PM 1 digit min hour | 5, 7 |
| "hh" | AM/PM 2 digit hour | 05, 07 |
| "H" | 24 hr 1 digit min hour | 17, 7 |
| "HH" | 24 hr 2 digit hour | 17, 07 |
| "m" | 1 digit min minute | 1, 40 |
| "mm" | 2 digit minute | 01, 40 |
| "s" | 1 digit min second | 1, 40 |
| "ss" | 2 digit second | 01, 40 |
| "S" | 10th's place of fractional second | 123ms -> 1, 7ms -> 0 |
| "SS" | 10th's & 100th's place of fractional second | 123ms -> 12, 7ms -> 00 |
| "SSS" | 10th's & 100th's & 1,000's place of fractional second | 123ms -> 123, 7ms -> 007 |

## Requirements

Language: Swift 5.0
Minimum: iOS 11, tvOS 12, watchOS 4, macOS 10.14


## Installation

**Swift Package Manager** https://github.com/melvitax/DateHelper.git  
**Carthage** github "melvitax/DateHelper"  
**Manually**  Include DateHelper.swift in your project  
**CocodaPods**  NO LONGER SUPPORTED


## Author

Melvin Rivera

## License

DateHelper is available under the MIT license. See the LICENSE file for more info.
