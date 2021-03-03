//: [Previous](@previous)
import DateHelper
/*:
 # Comparing Dates
 Provides common checks like isToday or isNextWeek. It can also check against another date like isSameDay or isEarlier.
 */
let nowDate = Date()
let nextHourDate = Date().adjust(.hour, offset: 1)
let tomorrowDate = Date().adjust(.day, offset: 1)
let yesterdayDate = Date().adjust(.day, offset: -1)
let nextWeekDate = Date().adjust(.week, offset: 1)
let lastWeekDate = Date().adjust(.week, offset: -1)
let nextTwoWeeksDate = Date().adjust(.week, offset: 2)
let nextMonthDate = Date().adjust(.month, offset: 1)
let nextYearDate = Date().adjust(.year, offset: 1)
let lastYearDate = Date().adjust(.year, offset: -1)
/*:
 ---
 ## Quick Checks
 Checks date against common scenarios
 
 `func compare(_ comparison: DateComparisonType) -> Bool`
 */
/*:
 Check if Date is `today`
 */
 tomorrowDate.compare(.isToday)
 nowDate.compare(.isToday)
/*:
 Check if date is `tomorrow`
 */
 tomorrowDate.compare(.isTomorrow)
 nowDate.compare(.isTomorrow)
/*:
 Check if date is `yesterday`
 */
 yesterdayDate.compare(.isYesterday)
 nowDate.compare(.isYesterday)
/*:
 Check if date is `this week`
 */
 nextWeekDate.compare(.isThisWeek)
 nowDate.compare(.isThisWeek)
/*:
 Check if date is `next week`
 */
 nextWeekDate.compare(.isNextWeek)
 nowDate.compare(.isNextWeek)
/*:
 Check if date is `last week`
 */
 nowDate.compare(.isLastWeek)
 lastWeekDate.compare(.isLastWeek)
/*:
 Check if date is `this year`
 */
 nowDate.compare(.isThisYear)
 nextYearDate.compare(.isThisYear)
/*:
 Check if date is `next year`
 */
 nowDate.compare(.isNextYear)
 nextYearDate.compare(.isNextYear)
/*:
 Check if date is `last year`
 */
 nowDate.compare(.isLastYear)
 lastYearDate.compare(.isLastYear)
/*:
 Check if date is `in the future`
 */
 nowDate.compare(.isInTheFuture)
 nextWeekDate.compare(.isInTheFuture)
/*:
 Check if date is `in the past`
 */
 tomorrowDate.compare(.isInThePast)
 lastWeekDate.compare(.isInThePast)
/*:
 ---
 ## Comparing Dates
 Checks first date against second date
 */
/*:
 Check if date is `same day` as other date
 */
 nowDate.compare(.isSameDay(as: yesterdayDate))
 nowDate.compare(.isSameDay(as: nextHourDate))
/*:
 Check if date is `same week` as other date
 */
 nowDate.compare(.isSameWeek(as: nextTwoWeeksDate))
 nowDate.compare(.isSameWeek(as: nextHourDate))
/*:
 Check if date is `same month` as other date
 */
 nowDate.compare(.isSameMonth(as: nextMonthDate))
 nowDate.compare(.isSameMonth(as: nextHourDate))
/*:
 Check if date is `same year`
 */
 nowDate.compare(.isSameYear(as: nextYearDate))
 nowDate.compare(.isSameYear(as: nextHourDate))
/*:
 Check if date is `earlier than` other date
 */
 tomorrowDate.compare(.isEarlier(than: nowDate))
 lastWeekDate.compare(.isEarlier(than: nowDate))
/*:
 Check if date is `later than` other date
 */
 yesterdayDate.compare(.isLater(than: nowDate))
 nextWeekDate.compare(.isLater(than: nowDate))

//: [Next](@next)
