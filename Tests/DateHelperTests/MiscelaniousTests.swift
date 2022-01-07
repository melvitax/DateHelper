import XCTest
@testable import DateHelper

final class DateHelperMiscelaniousTests: XCTestCase {

    // extract date components
    func testDateComponents() throws {
        guard
            let timeZone = TimeZone(secondsFromGMT: 60 * 60 * (-5)),
            let date = Calendar.current.date(from: DateComponents(timeZone: timeZone, year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 11)),
            let second = date.component(.second),
            let minute = date.component(.minute),
            let hour = date.component(.hour),
            let day = date.component(.day),
            let weekday = date.component(.weekday),
            let weekdayOrdinal = date.component(.weekdayOrdinal),
            let month = date.component(.month),
            let year = date.component(.year) else { return }
        XCTAssertEqual(second, 11)
        XCTAssertEqual(minute, 14)
        XCTAssertEqual(hour, 18)
        XCTAssertEqual(day, 06)
        XCTAssertEqual(weekday, 1)
        XCTAssertEqual(weekdayOrdinal, 1)
        XCTAssertEqual(month, 12)
        XCTAssertEqual(year, 2009)
        print("date: \(date)")
        print("second: \(second)")
        print("minute: \(minute)")
        print("hour: \(hour)")
        print("day: \(day)")
        print("weekday: \(weekday)")
        print("weekdayOrdinal: \(weekdayOrdinal)")
        print("month: \(month)")
        print("year: \(year)")
    }
    // extract date items
    func testDateItemExtraction() throws {
        guard
            let date = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 17)),
            let numberOfDaysInMonth = date.numberOfDaysInMonth(),
            let firstDayOfWeek = date.firstDayOfWeek(),
            let lastDayOfWeek = date.lastDayOfWeek() else { return }
        XCTAssertEqual(numberOfDaysInMonth, 31)
        XCTAssertEqual(firstDayOfWeek, 12)
        XCTAssertEqual(lastDayOfWeek, 19)
        print("date: \(date)")
        print("numberOfDaysInMonth: \(numberOfDaysInMonth)")
        print("firstDayOfWeek: \(firstDayOfWeek)")
        print("lastDayOfWeek: \(lastDayOfWeek)")
    }
}
