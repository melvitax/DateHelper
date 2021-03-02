//: [Previous](@previous)
import DateHelper
/*:
 # Miscellaneous
 */
/*:
 Setting the start day of the week
*/
var calendar = Calendar(identifier: .gregorian)
calendar.firstWeekday = 2 // sets the week to start on Monday
Date().dateFor(.startOfWeek, calendar: calendar)
/*:
 Extracting components from a date
*/
Date().component(.second)
Date().component(.minute)
Date().component(.hour)
Date().component(.day)
Date().component(.weekday)
Date().component(.nthWeekday)
Date().component(.month)
Date().component(.year)
/*:
 Extracting miscellaneous items from a date
*/
Date().numberOfDaysInMonth()
Date().firstDayOfWeek()
Date().lastDayOfWeek()

//: [Next](@next)

