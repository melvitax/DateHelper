//: [Previous](@previous)
import DateHelper
/*:
 # Adjusting Dates
 Provides two functions for adjusting dates
 */
/*:
 **1. adjust(_ component:, offset:)**
 
 `func adjust(_ component:DateComponentType, offset:Int) -> Date `
 */
Date().adjust(.second, offset: 110)
Date().adjust(.minute, offset: 60)
Date().adjust(.hour, offset: 2)
Date().adjust(.day, offset: 1)
Date().adjust(.weekday, offset: 2)
Date().adjust(.nthWeekday, offset: 1)
Date().adjust(.week, offset: 1)
Date().adjust(.month, offset: 1)
Date().adjust(.year, offset: 1)
/*:
 ### Component types
 * second
 * minute
 * hour
 * day
 * weekday
 * nthWeekday
 * week
 * month
 * year
 */
/*:
 ---
 2. adjust(hour:minute:second:)
 
 `func adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date `
 */
Date().adjust(hour: 12, minute: 0, second: 0)

//: [Next](@next)
