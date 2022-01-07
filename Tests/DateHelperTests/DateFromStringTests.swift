import XCTest
@testable import DateHelper

final class DateHelperFromStringTests: XCTestCase {

    // date from isoYear string
    func testDateFromIsoYearString() throws {
        let date = Date(fromString: "2009", format: .isoYear)
        let comparison = Calendar.current.date(from: DateComponents(year: 2009))
        XCTAssertEqual(date, comparison)
    }

    // date from isoYearMonth string
    func testDateFromIsoYearMonthString() throws {
        let date = Date(fromString: "2009-08", format: .isoYearMonth)
        let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 08))
        XCTAssertEqual(date, comparison)
    }

    // date from isoYearMonth string
    func testDateFromIsoDateString() throws {
        let date = Date(fromString: "2009-08-11", format: .isoDate)
        let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 08, day: 11))
        XCTAssertEqual(date, comparison)
    }

    // date from isoDateTime string
    func testDateFromIsoDateTimeString() throws {
        let date = Date(fromString: "2009-08-11T06:30:03-05:00", format: .isoDateTime)
        let offset = -5
        let timeZone = TimeZone(secondsFromGMT: 60 * 60 * offset)
        let comparison = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2009, month: 08, day: 11, hour: 06, minute: 30, second: 03))
        XCTAssertEqual(date, comparison)
    }

    // date from isoDateTimeFull string
    func testDateFromIsoDateTimeFullString() throws {
        let date = Date(fromString: "2009-08-11T06:30:03.161-05:00", format: .isoDateTimeFull)
        let offset = -5
        let nanoseconds = 161*1000000
        let timeZone = TimeZone(secondsFromGMT: 60 * 60 * offset)
        let comparison = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2009, month: 08, day: 11, hour: 06, minute: 30, second: 03, nanosecond: nanoseconds))
        XCTAssertEqual(date, comparison)
    }

    // date from dotNet string
    func testDateFromDotNetString() throws {
        let date = Date(fromString: "/Date(1260123281843)/", format: .dotNet)
        let timeZone = TimeZone(secondsFromGMT: 0)
        let nanoseconds = 843*1000000
        let comparison = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41, nanosecond: nanoseconds))
        XCTAssertEqual(date?.timeIntervalSince1970, comparison?.timeIntervalSince1970)
    }

    // date from rss string
    func testDateFromRSSString() throws {
        guard let date = Date(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .rss),
            let timeZone = TimeZone(secondsFromGMT: 60 * 60 * 2),
            let comparison = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2011, month: 09, day: 09, hour: 15, minute: 26, second: 08)) else {
                  return
        }
        XCTAssertEqual(date, comparison)
    }

    // date from altRSS string
    func testDateFromAltRSSString() throws {
        guard let date = Date(fromString: "09 Sep 2011 15:26:08 +0200", format: .altRSS),
            let timeZone = TimeZone(secondsFromGMT: 60 * 60 * 2),
            let comparison = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2011, month: 09, day: 09, hour: 15, minute: 26, second: 08)) else {
            return
        }
        XCTAssertEqual(date, comparison)
    }

    // date from httpHeader string
    func testDateFromHttpHeaderString() throws {
        guard let date = Date(fromString: "Wed, 01 03 2017 06:43:19 -0500", format: .httpHeader),
            let timeZone = TimeZone(secondsFromGMT: 60 * 60 * (-5)),
            let comparison = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2017, month: 03, day: 01, hour: 06, minute: 43, second: 19)) else {
            return
        }
        XCTAssertEqual(date, comparison)
    }
    
    // date from custom format string
    func testDateFromCustomFormatString() throws {
        guard let date = Date(fromString: "16 July 1972 6:12:00", format: .custom("dd MMM yyyy HH:mm:ss")),
            let comparison = Calendar.current.date(from: DateComponents(year: 1972, month: 07, day: 16, hour: 06, minute: 12, second: 00)) else {
            return
        }
        XCTAssertEqual(date, comparison)
    }

    // date from string using date detector
    func testDateFromDetectorString() throws {
        let date = Date(detectFromString: "Tomorrow at 5:30 PM")!
        let calendar = Calendar.current
        let today = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let components = calendar.dateComponents(Date.componentFlags(), from: tomorrow)
        let comparison = calendar.date(from: DateComponents(timeZone: TimeZone.current, year: components.year, month: components.month, day: components.day, hour: 17, minute: 30, second: 0))
        XCTAssertEqual(date, comparison)
    }
}
