# DateHelper

[![Version](https://img.shields.io/cocoapods/v/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![License](https://img.shields.io/cocoapods/l/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![Platform](https://img.shields.io/cocoapods/p/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A Swift Date extension for iOS, watchOS, tvOS, and macOS that creates or converts dates to or from strings. It can also compare, modify or extract date components and uses cached formatters for performance gains. 

![Sample Project Screenshot](https://raw.githubusercontent.com/melvitax/DateHelper/master/logo.png "Date Helper")


## Capabilities

Convert from string

```Swift
date = Date(fromString: "2009-08-11", format: .isoDate)
```

Convert to string

```Swift
let mediumDateString = date.toString(style: .medium)
let rssDateString = date.toString(format: .rss)
let shortTimeString =  date.toString(dateStyle: .none, timeStyle: .short)
let relativeTimeSting = date.toStringWithRelativeTime()
```

Compare dates

```Swift
let isToday = date.compare(.isToday)
let isSameWeek = date.compare(.isSameWeek(as: otherDate))
```

Adjust dates

```Swift
let twoHoursBefore = date.adjust(.hour, offset: -2)
let atNoon = date.adjust(hour: 12, minute: 0, second: 0)
```

Create dates for...

```Swift
let startOfWeek = date.dateFor(.startOfWeek)
let nearest5Hours = date.dateFor(.nearestHour(hour:5))
```

Forcing a week to start on monday
```Swift
var calendar = Calendar(identifier: .gregorian)
calendar = 2 // sets the week to start on the second day.. monday
now.dateFor(.startOfWeek, calendar: calendar)
```

Time since...

```Swift
let secondsSince = date.since(otherDate, in: .second)
```

Extracting components

```Swift
let seconds = date.component(.second)
let daysInMonth = date.numberOfDaysInMonth()
let firstDayOfWeek = date.firstDayOfWeek()
let lastDayOfWeek = date.lastDayOfWeek()
```

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
case ordinalDay; 27th
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

### Adjusting Dates

Use the `adjust(_ component:DateComponentType, offset:Int) -> Date` to change a the date with an offset.

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

Use the `adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date` function to change the date components.

```Swift
let atNoon = date.adjust(hour: 12, minute: 0, second: 0)
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

Language: Swift 5.0
Minimum: iOS 11, tvOS 12, watchOS 4, macOS 10.14


## Installation


**Carthage** github "melvitax/DateHelper"   
**Swift Package Manager** https://github.com/melvitax/DateHelper.git   
**Cocoapods** pod 'AFDateHelper', '~> 4.3.0'   
**Manually**  Include DateHelper.swift in your project


## Author

Melvin Rivera

## License

DateHelper is available under the MIT license. See the LICENSE file for more info.
