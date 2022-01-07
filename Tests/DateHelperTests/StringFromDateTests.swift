import XCTest
@testable import DateHelper

final class DateHelperToStringTests: XCTestCase {

    // date to string with style
    func testToStringWithStyle() throws {
        guard let timeZone = TimeZone(secondsFromGMT: 60 * 60 * (-5)),
        let date = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2017, month: 03, day: 01, hour: 06, minute: 43, second: 19)) else {
            return
        }
        // short
        if let string = date.toString(style: .short) {
            XCTAssertEqual(string, "3/1/17, 6:43 AM")
        }
        // medium
        if let string = date.toString(style: .medium) {
            XCTAssertEqual(string, "Mar 1, 2017 at 6:43:19 AM")
        }
        // long
        if let string = date.toString(style: .long) {
            XCTAssertEqual(string, "March 1, 2017 at 6:43:19 AM EST")
        }
        // full
        if let string = date.toString(style: .full) {
            XCTAssertEqual(string, "Wednesday, March 1, 2017 at 6:43:19 AM Eastern Standard Time")
        }
        // ordinalDay
        if let string = date.toString(style: .ordinalDay) {
            XCTAssertEqual(string, "1st")
        }
        // weekday
        if let string = date.toString(style: .weekday) {
            XCTAssertEqual(string, "Wednesday")
        }
        // shortWeekday
        if let string = date.toString(style: .shortWeekday) {
            XCTAssertEqual(string, "Wed")
        }
        // veryShortWeekday
        if let string = date.toString(style: .veryShortWeekday) {
            XCTAssertEqual(string, "W")
        }
        // month
        if let string = date.toString(style: .month) {
            XCTAssertEqual(string, "April")
        }
        // shortMonth
        if let string = date.toString(style: .shortMonth) {
            XCTAssertEqual(string, "Apr")
        }
        // veryShortMonth
        if let string = date.toString(style: .veryShortMonth) {
            XCTAssertEqual(string, "A")
        }
    }
    // date to string with format
    func testToStringWithFormat() throws {
        guard let timeZone = TimeZone(secondsFromGMT: 60 * 60 * (-5)),
        let date = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2017, month: 03, day: 01, hour: 06, minute: 43, second: 19)),
        let isoYear = date.toString(format: .isoYear),
        let isoYearMonth = date.toString(format: .isoYearMonth),
        let isoDate = date.toString(format: .isoDate),
        let isoDateTime = date.toString(format: .isoDateTime),
        let isoDateTimeFull = date.toString(format: .isoDateTimeFull),
        let dotNet = date.toString(format: .dotNet),
        let rss = date.toString(format: .rss),
        let altRSS = date.toString(format: .altRSS),
        let httpHeader = date.toString(format: .httpHeader),
        let custom1 = date.toString(format: .custom("MMM d, yyyy")),
        let custom2 = date.toString(format: .custom("h:mm a")),
        let custom3 = date.toString(format: .custom("E MMM d"))
        else {
            return
        }
        XCTAssertEqual(isoYear, "2017")
        XCTAssertEqual(isoYearMonth, "2017-03")
        XCTAssertEqual(isoDate, "2017-03-01")
        XCTAssertEqual(isoDateTime, "2017-03-01T06:43:19-05:00")
        XCTAssertEqual(isoDateTimeFull, "2017-03-01T06:43:19.000-05:00")
        XCTAssertEqual(dotNet, "/Date(-51488368599000.000000)/")
        XCTAssertEqual(rss, "Wed, 1 Mar 2017 06:43:19 -0500")
        XCTAssertEqual(altRSS, "1 Mar 2017 06:43:19 -0500")
        XCTAssertEqual(httpHeader, "Wed, 01 03 2017 06:43:19 -0500")
        XCTAssertEqual(custom1, "Mar 1, 2017")
        XCTAssertEqual(custom2, "6:43 AM")
        XCTAssertEqual(custom3, "Wed Mar 1")
        
    }
    // date to string with date and time style
    func testToStringWithDateAndTimeStyle() throws {
        guard let timeZone = TimeZone(secondsFromGMT: 60 * 60 * (-5)),
        let date = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2017, month: 03, day: 01, hour: 06, minute: 43, second: 19)) else {
            return
        }
        // dateStyle: .none, timeStyle: .short
        if let string = date.toString(dateStyle: .none, timeStyle: .short) {
            XCTAssertEqual(string, "6:43 AM")
        }
        // dateStyle: .short, timeStyle: .none
        if let string = date.toString(dateStyle: .short, timeStyle: .none) {
            XCTAssertEqual(string, "3/1/17")
        }
        // dateStyle: dateStyle: .short, timeStyle: .short
        if let string = date.toString(dateStyle: .short, timeStyle: .short) {
            XCTAssertEqual(string, "3/1/17, 6:43 AM")
        }
        // dateStyle: .medium, timeStyle: .medium
        if let string = date.toString(dateStyle: .medium, timeStyle: .medium) {
            XCTAssertEqual(string, "Mar 1, 2017 at 6:43:19 AM")
        }
        // dateStyle: .long, timeStyle: .long
        if let string = date.toString(dateStyle: .long, timeStyle: .long) {
            XCTAssertEqual(string, "March 1, 2017 at 6:43:19 AM EST")
        }
        // dateStyle: .full, timeStyle: .full
        if let string = date.toString(dateStyle: .full, timeStyle: .full) {
            XCTAssertEqual(string, "Wednesday, March 1, 2017 at 6:43:19 AM Eastern Standard Time")
        }
    }

    // date to string with date and time style
    func testToStringWithRelativeTime() throws {
        guard let date4years = Date().offset(.year, value: -4),
              let justNow = Date().offset(.second, value: -8) else {
            return
        }
        // toStringWithRelativeTime default behaviour
        if let string = date4years.toStringWithRelativeTime() {
            XCTAssertEqual(string, "4 years ago")
        }
        // toStringWithRelativeTime with custom year string
        if let string = date4years.toStringWithRelativeTime(customStrings: [.yearsPast: "%.f ages ago in a galaxy far away"]) {
            XCTAssertEqual(string, "4 ages ago in a galaxy far away")
        }
        // toStringWithRelativeTime with custom just now string
        if let string = justNow.toStringWithRelativeTime(customStrings: [.nowPast: "just happened"]) {
            XCTAssertEqual(string, "just happened")
        }
    }
}
