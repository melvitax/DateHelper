//: [Previous](@previous)
import DateHelper
/*:
 # Date To String
 Provides three ways to convert a Date object to string
 
 **1. toString(style:)**
 
 `func toString(style:DateStyleType = .short) -> String`
 Converts a date to string based on a pre-desfined style
 */
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
/*:
 **2. toString(format:)**
 
 `func toString(format: DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Locale.current) -> String`
 Converts a date to string based on a predefined or custom format
 */
 Date().toString(format: .custom("MMM d, yyyy"))
 Date().toString(format: .custom("h:mm a"))
 Date().toString(format: .custom("MMM d"))
 Date().toString(format: .custom("MMM d"))
 Date().toString(format: .custom("E MMM d"))
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
/*:
 #### Custom Component guide
 * `y:` 1 digit min year i.e. *1*, *2017*
 * `yy:` 2 digit year i.e. *42*, *17*
 * `yyy:` 3 digit min year i.e. *042*, *2017*
 * `yyyy:` 4 digit min year i.e. *0042, 2017*
 * `M:` 1 digit min month i.e. *7, 12*
 * `MM:` 2 digit month i.e. *07, 12*
 * `MMM:` 3 letter month abbr. i.e. *Jul*
 * `MMMM:` Full month i.e. *July*
 * `MMMMM:` 1 letter month abbr. i.e. *J*
 * `d:` 1 digit min day i.e. *4, 25*
 * `dd:` 2 digit day i.e. *04, 25*
 * `E, EE, EEE:` 3 letter day name abbr. i.e. *Wed*
 * `EEEE:` full day name i.e. *Wednesday*
 * `EEEEE:` 1 letter day name abbr. i.e. *W*
 * `EEEEEE:` 2 letter day name abbr. i.e. *We*
 * `a:` Period of day i.e. *AM, PM*
 * `h:` AM/PM 1 digit min hour i.e. *5, 7*
 * `hh:` AM/PM 2 digit hour i.e. *05, 07*
 * `H:` 24 hr 1 digit min hour i.e. *17, 7*
 * `HH:` 24 hr 2 digit hour i.e. *17, 07*
 * `m:` 1 digit min minute i.e. *1, 40*
 * `mm:` 2 digit minute i.e. *01, 40*
 * `s:` 1 digit min second i.e. *1, 40*
 * `ss:` 2 digit second i.e. *01, 40*
 * `S:` 10th's place of fractional second i.e. *123ms -> 1, 7ms -> 0*
 * `SS:` 10th's & 100th's place of fractional second i.e. *123ms -> 12, 7ms -> 00*
 * `SSS:` 10th's & 100th's & 1,000's place of fractional second i.e. *123ms -> 123, 7ms -> 007*
 */
/*:
 **3. toString(dateStyle:timeStyle:isRelative:timeZone:locale)**
 
 `func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, isRelative: Bool = false, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current) -> String`
 Converts a date to string based on a predefined date and time style
 */
Date().toString(dateStyle: .none, timeStyle: .short)
Date().toString(dateStyle: .short, timeStyle: .none)
Date().toString(dateStyle: .short, timeStyle: .short)
Date().toString(dateStyle: .medium, timeStyle: .medium)
Date().toString(dateStyle: .long, timeStyle: .long)
Date().toString(dateStyle: .full, timeStyle: .full)

/*:
 **4. toStringWithRelativeTime(strings:)**
 
 `func toStringWithRelativeTime(strings:[RelativeTimeStringType:String]? = nil) -> String `
 
 Converts a date to string based on a relative time from the current time on device. Optional strings array can replace default strings.
 */
Date().toStringWithRelativeTime()
Date().toStringWithRelativeTime(strings: [.nowPast: "just posted"])
/*:
 Options
 * nowPast: "just now"
 * nowFuture: "in a few seconds"
 * secondsPast: "%.f seconds ago"
 * secondsFuture: "in %.f seconds"
 * oneMinutePast: "1 minute ago"
 * oneMinuteFuture: "in 1 minute"
 * minutesPast: "%.f minutes ago"
 * minutesFuture: "in %.f minutes"
 * oneHourPast: "last hour"
 * oneHourFuture: "next hour"
 * hoursPast: "%.f hours ago"
 * hoursFuture: "in %.f hours"
 * oneDayPast: "yesterday"
 * oneDayFuture: "tomorrow"
 * daysPast: "%.f days ago"
 * daysFuture: "in %.f days"
 * oneWeekPast: "last week"
 * oneWeekFuture: "next week"
 * weeksPast: "%.f weeks ago"
 * weeksFuture: "in %.f weeks"
 * oneMonthPast: "last month"
 * oneMonthFuture: "next month"
 * monthsPast: "%.f months ago"
 * monthsFuture: "in %.f months"
 * oneYearPast: "last year"
 * oneYearFuture: "next year"
 * yearsPast: "%.f years ago"
 * yearsFuture: "in %.f years"
 */

//: [Next](@next)
