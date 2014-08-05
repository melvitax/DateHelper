AF+Date+Helper
=============================

Convenience extension for NSDate in Swift


### Date from String
```Swift
// Date from String with custom format
NSDate(fromString: "16 July 1972 6:12:00 ", format: .Custom("dd MMM yyyy HH:mm:ss")) -> NSDate
// Date from ISO8601 String
NSDate(fromString: "1972-07-16T08:15:30-05:00", format: .ISO8601) -> NSDate
// Date from DotNetJSON String
NSDate(fromString: "/Date(1260123281843)/", format: .DotNet) -> NSDate
// Date from RSS String
NSDate(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .RSS) -> NSDate
// Date from AltRSS String
NSDate(fromString: "09 Sep 2011 15:26:08 +0200", format: .AltRSS) -> NSDate -> NSDate
```

### Comparing Dates
```Swift
date.isEqualToDate(date) -> Bool
date.isToday() -> Bool  
date.isTomorrow()-> Bool
date.isYesterday() -> Bool
date.isSameWeekAsDate(date) -> Bool
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
date.dateByAddingDays(2) -> NSDate
date.dateBySubtractingDays(4) -> NSDate
date.dateByAddingHours(2) -> NSDate
date.dateBySubtractingHours(4) -> NSDate
date.dateByAddingMinutes(2) -> NSDate
date.dateBySubtractingMinutes(4) -> NSDate
date.dateAtStartOfDay() -> NSDate
date.dateAtEndOfDay() -> NSDate
date.dateAtStartOfWeek() -> NSDate
date.dateAtEndOfWeek() -> NSDate
```

### Time Interval Between Dates */
```Swift
date.minutesAfterDate(now) -> Int
date.minutesBeforeDate(now) -> Int
date.hoursAfterDate(now) -> Int
date.hoursBeforeDate(now) -> Int
date.daysAfterDate(now) -> Int
date.daysBeforeDate(now) -> Int
```

### Decomposing Dates
```Swift
date.toString -> Int
date.nearestHour -> Int
date.year -> Int
date.month -> Int
date.week -> Int
date.day -> Int
date.hour -> Int
date.minute -> Int
date.seconds -> Int
date.weekday -> Int
date.nthWeekday -> Int
date.monthDays -> Int
date.firstDayOfWeek -> Int
date.lastDayOfWeek -> Int
date.isWeekday -> Int
date.isWeekend -> Int
```

### To String
```Swift
date.toString() -> String
date.toString(format: .Custom("dd MMM yyyy HH:mm:ss")) -> String
date.toString(format: .ISO8601) -> String
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

