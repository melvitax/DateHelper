import DateHelper
/*:
 # Date From String
 Provides two initializers to create a date from string.
 
 **1. detectFromString:**
 
 `init?(detectFromString string: String)`
 
 Uses NSDataDetector to detect a date from natural language in a string. Similar to what Apple mail does on emails. This initializer is not as efficient as `fromString:format:` and should not be used in collections like lists.
 */
 Date(detectFromString: "It happened on August 11 of 2009")
 Date(detectFromString: "Tomorrow at 5:30 PM")
/*:
 **2. fromString:format:**
 
 `init?(fromString string: String, format:DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Foundation.Locale.current, isLenient: Bool = true) `
 
 Initializes a date from a string using a strict or custom format that is cached, highly performant and thread safe.
 - .isoYear
 - .isoYearMonth
 - .isoDate
 - .isoDateTime
 - .isoDateTimeSec
 - .isoDateTimeMilliSec
 - .dotNet
 - .rss
 - .altRSS
 - .httpHeader
 */
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
/*:
 
 
 - .custom
 
 Custom format allows fot any combination of date components as the text input i.e. *"dd MMM yyyy HH:mm:ss"*

 */
 Date(fromString: "16 July 1972 6:12:00", format: .custom("dd MMM yyyy HH:mm:ss"))
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

//: [Next](@next)
