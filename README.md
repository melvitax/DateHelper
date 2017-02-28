# DateHelper

[![Version](https://img.shields.io/cocoapods/v/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![License](https://img.shields.io/cocoapods/l/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![Platform](https://img.shields.io/cocoapods/p/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A Swift Date extension helper that uses predefined or custom cached formatters for creating dates or converting dates to strings. You can also do date comparisons based on relative times, adjust a component of a date or extract components from it.

![Sample Project Screenshot](https://raw.githubusercontent.com/melvitax/DateHelper/master/logo.png "Date Helper")

## Requirements

Swift 3

## Installation

**Carthage** github "melvitax/DateHelper"  
**Cocoapods** pod 'AFDateHelper', '~> 4.0.1'  
**Manually**  Include DateHelper.swift in your project

## Usage

### Date from string

Use the initializer `Date(fromString:String, format: DateFormatType)?` to create an optional date from a string. 

```Swift
if let date = Date(fromString: "09 Sep 2011 15:26:08 +0200", format: .httpHeader) -> 
 {
	// Do stuff with date
}
```
The DateFormatType enum has a few predifined options as well as a tupple for providing a custom date format.

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

### To String

There's four options for converting a date to string.

1. date.toString(style: .shortWeekday) 
2. date.toString(format: .rss)
3. date.toString(dateStyle: .short, timeStyle: .short)
4. date.toStringWithRelativeTime()

### 1. String with style
Converts to string using a predefined style

```Swift
let string = date.toString(.shortWeekday)
// Mon
```
The DateStyleType enum 

```Swift
case short; "2/27/17, 2:22 PM"
case medium; "Feb 27, 2017, 2:22:06 PM"
case long; "February 27, 2017 at 2:22:06 PM EST"
case full; "Monday, February 27, 2017 at 2:22:06 PM Eastern Standard Time"
case weekday; "Monday"
case shortWeekday; "Mon"
case veryShortWeekday; "M"
case month; "February"
case shortMonth; "Feb"
case veryShortMonth; "F"
```

### 2. String with format

Converts to string with specific or  custom date formatters.

```Swift
let string = date.toString(format: .rss)
// Fri, 09 Sep 2011 15:26:08 +0200
```

The DateFormatType enum has a few predifined options as well as a tupple for providing a custom date format.

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

### 3. String with date and time style

Converts to string using a DateFormatter.Style for date and time style plus an optional isRelative flag.

```Swift
let string = date.toString(dateStyle: .short, timeStyle: .short)
// 11/23/37 3:30 PM
```
The DateFormatter.Style uses predefined formats for date and time.

```Swift
case .none
case .short; "11/23/37" or "3:30 PM"
case .medium; "Nov 23, 1937" or "3:30:32 PM"
case .long; "November 23, 1937" or "3:30:32 PM PST"
case .full; "Tuesday, April 12, 1952 AD" or "3:30:42 PM Pacific Standard Time"

```

### 4. String with relative time format

Converts to string using a customizable  relative time format.

```Swift
let string = date.toStringWithRelativeTime()
// yesterday
```
Use the optional `strings:[RelativeTimeStringType:String]?` to customize the relative time strings

```Swift
let string = date.toStringWithRelativeTime([.nowPast: "just posted"])
```

The RelativeTimeStringType enum keys are used for customizing the strings

```Swift
case nowPast: "just now"
case nowFuture: "in a few seconds"
case secondsPast: "%.f seconds ago"
case secondsFuture: "in %.f seconds"
case oneMinutePast: "1 minute ago"
case oneMinuteFuture: "in 1 minute"
case minutesPast: "%.f minutes ago"
case minutesFuture: "in %.f minutes"
case oneHourPast: "last hour"
case oneHourFuture: "next hour"
case hoursPast: "%.f hours ago"
case hoursFuture: "in %.f hours"
case oneDayPast: "yesterday"
case oneDayFuture: "tomorrow"
case daysPast: "%.f days ago"
case daysFuture: "in %.f days"
case oneWeekPast: "last week"
case oneWeekFuture: "next week"
case weeksPast: "%.f weeks ago"
case weeksFuture: "in %.f weeks"
case oneMonthPast: "last month"
case oneMonthFuture: "next month"
case monthsPast: "%.f months ago"
case monthsFuture: "in %.f months"
case oneYearPast: "last year"
case oneYearFuture: "next year"
case yearsPast: "%.f years ago"
case yearsFuture: "in %.f years"
```

### Comparing Dates

Use the `compare(_ comparison:DateComparisonType) -> Bool` function to compare a date against a type or a date.

```Swift
var isSameDay = now.compare(.isSameDay(as: date))
var isToday = now.compare(.isToday)  
```
The DateComparisonType enum can compare the date to a predetermined date, period or a custom date in a tupple. i.e. isLater(thanDate:Date)

```Swift
// Days
case isToday
case isTomorrow
case isYesterday
case isSameDay(as:Date)
// Weeks
case isThisWeek
case isNextWeek
case isLastWeek
case isSameWeek(as:Date)
// Months
case isThisMonth
case isNextMonth
case isLastMonth
case isSameMonth(as:Date)
// Years
case isThisYear
case isNextYear
case isLastYear
case isSameYear(as:Date)
// Relative Time
case isInTheFuture
case isInThePast
case isEarlier(than:Date)
case isLater(than:Date)
case isWeekday
case isWeekend
```

### Adjusting Date Components

Use the `adjust(_ component:DateComponentType, offset:Int) -> Date` to adjust a change the value of a date component.

```Swift
date = now.adjust(.day, offset: -4)
```
The DateComponentType enum is used for the components that can be adjusted.

```Swift
case second
case minute
case hour
case day
case weekday
case nthWeekday
case week
case month
case year
```

### Create Dates For...

Use the `dateFor(_ type:DateForType) -> Date` function to create a new date for a specific occasion relative to the date.

```Swift
let date = now.dateFor(.startOfWeek)
let nearestHour = now.dateFor(.nearestHour(hour:1))
```
The DateForType enum is used as a predetermined list of options.

```Swift
case startOfDay
case endOfDay
case startOfWeek
case endOfWeek
case startOfMonth
case endOfMonth
case tomorrow
case yesterday
case nearestHour
case nearestMinute(minute:Int)
case nearestHour(hour:Int)
```

### Time Since In...

Use the `since(_ date:Date, in component:DateComponentType) -> Int64` function to retrieve the component interval value compared to another date.

```Swift
var num = date.since(now, in: .second)
```

The DateComponentType enum is used for the vlaue to be retrieved.

```Swift
case second
case minute
case hour
case day
case weekday
case nthWeekday
case week
case month
case year
```


### Extracting Components

Use the `component(_ component:DateComponentType) -> Int? ` to get a specific component froma date.

```Swift
let minute = date.component(.minute) 
```

The DateComponentType enum is used for the vlaue to be retrieved.

```Swift
case second
case minute
case hour
case day
case weekday
case nthWeekday
case week
case month
case year
```
Related components to the date

```Swift
date.numberOfDaysInMonth()
date.firstDayOfWeek()
date.lastDayofWeek()
```

## Requirements

Swift 3


## Author

Melvin Rivera, melvin@allforces.com

## License

DateHelper is available under the MIT license. See the LICENSE file for more info.
