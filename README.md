# AFDateHelper

[![Version](https://img.shields.io/cocoapods/v/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![License](https://img.shields.io/cocoapods/l/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![Platform](https://img.shields.io/cocoapods/p/AFDateHelper.svg?style=flat)](http://cocoapods.org/pods/AFDateHelper)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

An NSDate Extension for Swift 2.0

![Sample Project Screenshot](https://raw.githubusercontent.com/melvitax/AFDateHelper/master/Screenshot.png "Sample Project Screenshot")


## Usage

To run the example project, clone or download the repo, and run.

### Creating Date from String
```Swift
// Date from String with custom format
NSDate(fromString: "16 July 1972 6:12:00 ", format: .Custom("dd MMM yyyy HH:mm:ss")) -> NSDate
// Date from ISO8601(Year) String
NSDate(fromString:  "2009", format: .ISO8601(nil)) -> NSDate
// Date from ISO8601(Year & Month) String
NSDate(fromString:  "2009-08", format: .ISO8601(nil)) -> NSDate
// Date from ISO8601(Date) String
NSDate(fromString:  "2009-08-11", format: .ISO8601(nil)) -> NSDate
// Date from ISO8601(Date & Time) String
NSDate(fromString:  "2009-08-11T06:00-07:00", format: .ISO8601(nil)) -> NSDate
// Date from ISO8601(Date & Time & Sec) String
NSDate(fromString:  "2009-08-11T06:00:00-07:00", format: .ISO8601(nil)) -> NSDate
// Date from ISO8601(Date & Time & MilliSec) String
NSDate(fromString: "2009-08-11T06:00:00.000-07:00", format: .ISO8601(nil)) -> NSDate
// Date from DotNetJSON String
NSDate(fromString: "/Date(1260123281843)/", format: .DotNet) -> NSDate
// Date from RSS String
NSDate(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .RSS) -> NSDate
// Date from AltRSS String
NSDate(fromString: "09 Sep 2011 15:26:08 +0200", format: .AltRSS) -> NSDate -> NSDate
```

### Creating Date
```Swift
NSDate.tomorrow() -> NSDate
NSDate.yesterday() -> NSDate
```

### Comparing Dates
```Swift
date.isEqualToDate(date) -> Bool
date.isToday() -> Bool  
date.isTomorrow()-> Bool
date.isYesterday() -> Bool
date.isSameWeekAsDate(date) -> Bool
date.isSameMonthAsDate(date) -> Bool
date.isThisWeek() -> Bool
date.isNextWeek() -> Bool
date.isLastWeek() -> Bool
date.isSameYearAsDate(date) -> Bool
date.isThisYear() -> Bool
date.isNextYear() -> Bool
date.isLastYear() -> Bool
```

### Adjusting Dates
```Swift
date.dateByAddingMonths(2) -> NSDate
date.dateBySubtractingMonths(4) -> NSDate
date.dateByAddingWeeks(2) -> NSDate
date.dateBySubtractingWeeks(4) -> NSDate
date.dateByAddingDays(2) -> NSDate
date.dateBySubtractingDays(4) -> NSDate
date.dateByAddingHours(2) -> NSDate
date.dateBySubtractingHours(4) -> NSDate
date.dateByAddingMinutes(2) -> NSDate
date.dateBySubtractingMinutes(4) -> NSDate
date.dateByAddingSeconds(90) -> NSDate
date.dateBySubtractingSeconds(90) -> NSDate
date.dateAtStartOfDay() -> NSDate
date.dateAtEndOfDay() -> NSDate
date.dateAtStartOfWeek() -> NSDate
date.dateAtEndOfWeek() -> NSDate
date.dateAtTheStartOfMonth() -> NSDate
date.dateAtTheEndOfMonth() -> NSDate
date.setTimeOfDate(hour: 6, minute: 30, second: 15) -> NSDate
```

### Time Interval Between Dates
```Swift
date.secondsAfterDate(now) -> Int
date.secondsBeforeDate(now) -> Int
date.minutesAfterDate(now) -> Int
date.minutesBeforeDate(now) -> Int
date.hoursAfterDate(now) -> Int
date.hoursBeforeDate(now) -> Int
date.daysAfterDate(now) -> Int
date.daysBeforeDate(now) -> Int
```

### Decomposing Dates
```Swift
date.nearestHour() -> Int
date.year() -> Int
date.month() -> Int
date.week() -> Int
date.day() -> Int
date.hour() -> Int
date.minute() -> Int
date.seconds() -> Int
date.weekday() -> Int
date.nthWeekday() -> Int
date.monthDays() -> Int
date.firstDayOfWeek() -> Int
date.lastDayOfWeek() -> Int
date.isWeekday() -> Int
date.isWeekend() -> Int
```

### To String
```Swift
date.toString() -> String
date.toString(format: .Custom("dd MMM yyyy HH:mm:ss")) -> String
date.toString(format: .ISO8601(ISO8601Format.Year)) -> String
date.toString(format: .ISO8601(ISO8601Format.YearMonth)) -> String
date.toString(format: .ISO8601(ISO8601Format.Date)) -> String
date.toString(format: .ISO8601(ISO8601Format.DateTime)) -> String
date.toString(format: .ISO8601(ISO8601Format.DateTimeSec)) -> String
date.toString(format: .ISO8601(ISO8601Format.DateTimeMilliSec)) -> String
date.toString(format: .DotNet) -> String
date.toString(format: .RSS) -> String
date.toString(format: .AltRSS) -> String
date.toString(dateStyle: .ShortStyle, timeStyle: .NoStyle, doesRelativeDateFormatting: true) -> String
date.toString(dateStyle: .ShortStyle, timeStyle: .NoStyle, doesRelativeDateFormatting: false) -> String
date.toString(dateStyle: .MediumStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false) -> String
date.toString(dateStyle: .LongStyle, timeStyle: .LongStyle, doesRelativeDateFormatting: false) -> String
date.toString(dateStyle: .FullStyle, timeStyle: .FullStyle, doesRelativeDateFormatting: false) -> String
date.relativeTimeToString()
```

### Components To String
```Swift
date.weekdayToString() -> String
date.shortWeekdayToString() -> String
date.veryShortWeekdayToString() -> String
date.monthToString() -> String
date.shortMonthToString() -> String
date.veryShortMonthToString() -> String
```


## Requirements

Swift 2.0

## Installation

AFDateHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AFDateHelper"
```

AFDateHelper is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ogdl
github "melvitax/AFDateHelper"
```

## Author

Melvin Rivera, melvin@allforces.com

## License

AFDateHelper is available under the MIT license. See the LICENSE file for more info.