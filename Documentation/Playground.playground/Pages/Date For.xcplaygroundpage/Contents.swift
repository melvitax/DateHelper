//: [Previous](@previous)
import DateHelper
/*:
 # Date For
 Provides convenience date creators for common scenarios like endOfDay, startOfDay etc.
 
 `1. dateFor(_ type:)`
 */
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

/*:
 `2. dateFor(_ type:calendar:)`
 */
var calendar = Calendar(identifier: .gregorian)
calendar.firstWeekday = 2 // sets startOfWeek to Monday
Date().dateFor(.startOfWeek, calendar: calendar).toString(format: .custom("E MMM d"))
Date().dateFor(.endOfWeek, calendar: calendar).toString(format: .custom("E MMM d"))
//: [Next](@next)
