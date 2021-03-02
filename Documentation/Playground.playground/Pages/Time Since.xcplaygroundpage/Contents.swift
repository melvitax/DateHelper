//: [Previous](@previous)
import DateHelper
/*:
 # Time Since
 Returns a number in the specified unit of measure since the secondary date.
 */
let thirtySecondsBackDate = Date().adjust(.second, offset: -30)
let twoHoursBackDate = Date().adjust(.hour, offset: -2)
let yesterdayDate = Date().adjust(.day, offset: -1)
let nextWeekDate = Date().adjust(.week, offset: 1)
let lastWeekDate = Date().adjust(.week, offset: -1)
let twoWeeksBackDate = Date().adjust(.week, offset: -2)
let lastMonthDate = Date().adjust(.month, offset: -1)
let lastYearDate = Date().adjust(.year, offset: -1)
/*:
 `1. since(_ date:in:)`
 */
Date().since(thirtySecondsBackDate, in: .second)
Date().since(twoHoursBackDate, in: .minute)
Date().since(twoHoursBackDate, in: .hour)
Date().since(yesterdayDate, in: .day)
Date().since(nextWeekDate, in: .week)
Date().since(twoWeeksBackDate, in: .nthWeekday)
Date().since(lastWeekDate, in: .week)
Date().since(lastMonthDate, in: .month)
Date().since(lastYearDate, in: .year)

