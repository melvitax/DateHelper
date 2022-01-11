# DateHelper 5.0.1

[![License](https://img.shields.io/badge/License-MIT-lightgrey)](https://github.com/melvitax/DateHelper/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS-lightgrey)](https://github.com/melvitax/DateHelper)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-Compatible-green)](https://github.com/Carthage/Carthage)
[![Swift Package Manager Compatible](https://img.shields.io/badge/Swift%20Package%20Manager-Compatible-green)](https://swift.org/package-manager/)

![Sample Project Screenshot](https://raw.githubusercontent.com/melvitax/DateHelper/master/logo.png "Date Helper")

A high performant Swift Date Extension for creating, comparing, or modifying dates. 


## Capabilities
- **Date from String**
	- Using date detection i.e. `"Tomorrow at 5:30 PM"`
	- With predefined format: i.e. `.isoDateTime` 
	- With custom format: i.e. `"dd MMM yyyy HH:mm:ss"`
- **String from Date**
	- With predefined format: i.e. `.rss`
	- With custom format: i.e. `""MMM d, yyyy""`
    - With combined date and time style: i.e. `.medium`
    - With individual date and time style: i.e. `.medium, .short`
- **Modify Date**
    - Offset date component: i.e. `.offset(.second, value: 110)`
    - Adjust date component: i.e. `.adjust(hour: 12, minute: 0, second: 0)`
    - Adjust date to a predefined time: i.e. `.adjust(for: .startOfDay)`
- **Compare Date**
    - Compare against relative date in predefined format: i.e. `.isToday, .isThisWeek`
    - Compare againnst target date: i.e. `firstDate.compare(.isSameMonth(as: secondDate))`
- **Time Since**
    - Time since target date in component: i.e. `Date().since(secondDate, in: .second)`
- **Extras**
    - Extract date and time components: i.e. `.hour, .minute, .day`
    - Conveniance methods: i.e. `numberOfDaysInMonth(), firstDayOfWeek(), .lastDayOfWeek()` 

## Date From String
Provides initializers to create a Date from a String


### Detect a Date from natural language in a String

```swift
Date(detectFromString: "Tomorrow at 5:30 PM")
```
Uses NSDataDetector to detect a date from natural language in a string. It works similar to how Apple Mail detects dates. This initializer is not as efficient as **fromString:format:** and should not be used in collections or lists.


### Date from a string with predefined format

```swift
 Date(fromString: "2009", format: .isoYear)
 Date(fromString: "2009-08", format: .isoYearMonth)
 Date(fromString: "2009-08-11", format: .isoDate)
 Date(fromString: "2009-08-11T06:00:00-07:00", format: .isoDateTime)
 Date(fromString: "2009-08-11T06:00:00.000-07:00", format: .isoDateTimeFull)
 Date(fromString: "/Date(1260123281843)/", format: .dotNet)
 Date(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .rss)
 Date(fromString: "09 Sep 2011 15:26:08 +0200", format: .altRSS)
 Date(fromString: "Wed, 01 03 2017 06:43:19 -0500", format: .httpHeader)
```
Highly performant, cached and thread safe. Can optionally receive timeZone, locale or  isLenient flag.

### Date from a string with custom format

```swift
 Date(fromString: "16 July 1972 6:12:00", format: .custom("dd MMM yyyy HH:mm:ss"))
```
Highly performant, cached and thread safe. Can optionally receive timeZone, locale or  isLenient flag.

## String From Date
Provides three ways to convert a Date object to a String


### Convert Date to String using predefined format

```swift
Date().toString(format: .isoYear)
"2017"
Date().toString(format: .isoYearMonth)
"2017-03"
Date().toString(format: .isoDate)
"2017-03-01"
Date().toString(format: .isoDateTime)
"2017-03-01T06:43:19-05:00"
Date().toString(format: .isoDateTimeFull)
"2017-03-01T06:43:19.000-05:00"
Date().toString(format: .dotNet)
"/Date(-51488368599000.000000)/"
Date().toString(format: .rss)
"Wed, 1 Mar 2017 06:43:19 -0500"
Date().toString(format: .altRSS)
"1 Mar 2017 06:43:19 -0500"
Date().toString(format: .httpHeader)
"Wed, 01 03 2017 06:43:19 -0500"
```
Highly performant, cached and thread safe. Can optionally receive timeZone and locale.

### Convert Date to String using custom format

```swift
Date().toString(format: .custom("MMM d, yyyy"))
"Mar 1, 2017"
Date().toString(format: .custom("h:mm a"))
"6:43 AM"
Date().toString(format: .custom("MMM d"))
"Wed Mar 1"
```
Highly performant, cached and thread safe. Can optionally receive timeZone and locale.

### Convert Date to String using predefined combined date and time styles
```swift
Date().toString(style: .short) 
"3/1/17, 6:43 AM"
Date().toString(style: .medium)
"Mar 1, 2017 at 6:43:19 AM"
Date().toString(style: .long)
"March 1, 2017 at 6:43:19 AM EST"
Date().toString(style: .full)
"Wednesday, March 1, 2017 at 6:43:19 AM Eastern Standard Time"
Date().toString(style: .ordinalDay)
"1st"
Date().toString(style: .weekday)
"Wednesday"
Date().toString(style: .shortWeekday)
"Wed"
Date().toString(style: .veryShortWeekday)
"W"
Date().toString(style: .month)
"April"
Date().toString(style: .shortMonth)
"Apr"
Date().toString(style: .veryShortMonth)
"A"
```

### Convert Date to String using predefined individual date and time styles

```swift 
Date().toString(dateStyle: .none, timeStyle: .short)
"6:43 AM"
Date().toString(dateStyle: .short, timeStyle: .none)
"3/1/17"
Date().toString(dateStyle: .short, timeStyle: .short)
"3/1/17, 6:43 AM"
Date().toString(dateStyle: .medium, timeStyle: .medium)
"Mar 1, 2017 at 6:43:19 AM"
Date().toString(dateStyle: .long, timeStyle: .long)
"March 1, 2017 at 6:43:19 AM EST"
Date().toString(dateStyle: .full, timeStyle: .full)
"Wednesday, March 1, 2017 at 6:43:19 AM Eastern Standard Time"
```

## Modifying dates
Provides functions for adjusting or shifting dates

### Offset components

```swift 
Date().offset(.second, value: 10)
"18:14:41" -> "18:14:51"
Date().offset(.minute, value: 10)
"18:14:41" -> "18:24:41"
Date().offset(.hour, value: 2)
"18:14:41" -> "20:14:41"
Date().offset(.day, value: 1)
"2009-12-06" -> "2009-12-07"
Date().offset(.weekday, value: 2)
"2009-12-06" -> "2009-16-06"
Date().offset(.weekdayOrdinal, value: 1)
"2009-12-06" -> "2009-12-20"
Date().offset(.week, value: -2)
"2009-12-06" ->  "2009-11-22"
Date().offset(.month, value: 2)
"2009-12-06" -> "2010-02-06"
Date().offset(.year, value: -2)
"2009-12-06" -> "2007-12-06"
```

### Adjust components
Modifies date with the specified date component  

```swift 
Date().adjust(hour: 1, minute: 10, second: 30, day: 15, month: 1)
"2009-12-06 18:14:41" -> "2009-01-15 06:10:30"
Date().adjust(minute: 59)
"2009-12-06 18:14:41" -> "2009-12-06 18:59:30"
```

### Adjust date
Modifies date with predefined times like endOfDay, startOfDay startOfWeek etc.

```swift 
Date().adjust(for: .startOfDay)
"2009-12-06 18:14:41" -> "2009-12-06 00:00:00"
Date().adjust(for: .endOfDay)
"2009-12-06 18:14:41" -> "2009-12-06 23-59-59"
Date().adjust(for: .startOfWeek)
"2009-12-08 18:14:41" -> "2009-12-06 18:14:41"
Date().adjust(for: .endOfWeek)
"2009-12-06 18:14:41" -> "2009-12-12 18:14:41"
Date().adjust(for: .startOfMonth)
"2009-12-06 18:14:41" -> "2009-12-01 18:14:41"
Date().adjust(for: .endOfMonth)
"2009-12-06 18:14:41" -> "2009-12-31 18:14:41"
Date().adjust(for: .tomorrow)
"2009-12-06 18:14:41" -> "tomorrow at 18:14:41"
Date().adjust(for: .yesterday)
"2009-12-06 18:14:41" -> "yesterday at 18:14:41"
Date().adjust(for: .nearestMinute(minute:30))
"2009-12-07 18-14-00" -> "2009-12-07 18-00-00"
"2009-12-07 18-40-00" -> "2009-12-07 18-30-00"
"2009-12-07 18-50-00" -> "2009-12-07 19-00-00"
Date().adjust(for: .nearestHour(hour:2)) 
"2009-12-07 18-00-00" -> "2009-12-08 00-00-00"
"2009-12-07 07-00-00" -> "2009-12-07 12-00-00"
"2009-12-07 03-00-00" -> "2009-12-07 00-00-00"
Date().adjust(for: .startOfYear)
"2009-12-06 18:14:41" -> "2009-01-01 00-00-00"
Date().adjust(for: .endOfYear)
"2009-12-06 18:14:41" -> "2009-12-31 23-59-59"
```

## Compare Dates
Compares dates using predefined times like today, tomorrow, this year, next year etc. Returns true if it matches.

### Compare against relative date
```swift
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
Date().compare(.isWeekend)
"2021-12-15" != weekend
"2021-12-18" == weekend
```

### Compare against another date
```swift
firstDate.compare(.isSameDay(as: secondDate))
"2022-01-08" != "2022-01-07"
"2022-01-06" != "2022-01-07"
"2022-01-07" == "2022-01-07"
firstDate.compare(.isSameWeek(as: secondDate))
"2022-01-14" != "2022-01-07"
"2021-12-31" != "2022-01-07"
"2022-01-07" == "2022-01-07"
firstDate.compare(.isSameMonth(as: secondDate))
"2022-02-07" != "2022-01-07"
"2021-12-07" != "2022-01-07"
"2022-01-07" == "2022-01-07"
firstDate.compare(.isSameYear(as: secondDate))
"2023-01-07" != "2022-01-07"
"2021-01-07" != "2022-01-07"
"2022-01-07" == "2022-01-07"
firstDate.compare(.isEarlier(than: secondDate))
"2022-01-07 19:26:53" != "2022-01-07 19:25:53"
"2022-01-07 19:24:53" == "2022-01-07 19:25:53"
firstDate.compare(.isLater(than: secondDate))
"2022-01-07 19:28:49" == "2022-01-07 19:27:49"
"2022-01-07 19:26:49" != "2022-01-07 19:27:49"
```

## Time since...  
Returns a number in the specified unit of measure since the secondary date.  

```swift
Date().since(secondDate, in: .second)
"2009-12-06 06-14-11" since "2009-12-06 06-13-41" in .second == 30 
Date().since(secondDate, in: .minute)
"2009-12-06 06-14-11" since "2009-12-06 04-14-11" in .minute == 120 
Date().since(secondDate, in: .hour)
"2009-12-06 06-14-11" since "2009-12-06 04-14-11" in .hour == 2 
Date().since(secondDate, in: .day)
"2009-12-06" since "2009-12-05" in .day == 1 
Date().since(secondDate, in: .week)
"2009-12-06" since "2009-11-29" in .week == 1
"2009-12-06" since "2009-12-13" in .week == -1
Date().since(secondDate, in: .weekdayOrdinal)
"2009-12-06" since "2009-11-22" in .weekdayOrdinal == 2
Date().since(secondDate, in: .month)
"2009-12-06" since "2009-11-06" in .month == 2
Date().since(secondDate, in: .year)  
"2009-12-06" since "2008-12-06" in .year == 1
```

## Miscellaneous

### Extracting components from a date

```swift
Date().component(.second)
"2009-12-06 18:14:11" .second == "11"
Date().component(.minute)
"2009-12-06 18:14:11" .minute == "14"
Date().component(.hour)
"2009-12-06 18:14:11" .hour == "18"
Date().component(.day)
"2009-12-06 18:14:11" .day == "6"
Date().component(.weekday)
"2009-12-06 18:14:11" .weekday == "1"
Date().component(.weekdayOrdinal)
"2009-12-06 18:14:11" .weekdayOrdinal == "1"
Date().component(.month)
"2009-12-06 18:14:11" .month == "12"
Date().component(.year)
"2009-12-06 18:14:11" .year == "2009"
```

### Conveneience methods 

```swift
Date().numberOfDaysInMonth()
"2021-12-17" numberOfDaysInMonth() == 31
Date().firstDayOfWeek()
"2021-12-17" firstDayOfWeek() == 12
Date().lastDayOfWeek()
"2021-12-17" lastDayOfWeek() == 19
```

### Custom start day of the week

```swift
var calendar = Calendar(identifier: .gregorian)
calendar.firstWeekday = 2 // sets the week to start on Monday
Date().dateFor(.startOfWeek, calendar: calendar)
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
Supports: iOS, tvOS, watchOS, macOS


## Installation

**Swift Package Manager** https://github.com/melvitax/DateHelper.git  
**Carthage** github "melvitax/DateHelper"  
**Manually**  Include DateHelper.swift in your project  


## Author

Melvin Rivera

## License

DateHelper is available under the MIT license. See the LICENSE file for more info.
