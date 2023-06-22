import XCTest
@testable import DateHelper

final class DateHelperAdjustingTests: XCTestCase {
    // adjust date and time
    func testDateAdjustDateAndTime() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
            let adjusted = original.adjust(hour: 1, minute: 10, second: 30, day: 15, month: 1),
            let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 01, day: 15, hour: 1, minute: 10, second: 30)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset second
    func testDateOffsetSecond() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
            let adjusted = original.offset(.second, value: 10),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 51)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset minute
    func testDateOffsetMinute() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14)),
            let adjusted = original.offset(.minute, value: 10),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 24)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset hour
    func testDateOffsetHour() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18)),
            let adjusted = original.offset(.hour, value: 2),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 20)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset day
    func testDateOffsetDay() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06)),
            let adjusted = original.offset(.day, value: 10),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 16)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset weekday
    func testDateOffsetWeekday() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06)),
            let adjusted = original.offset(.weekday, value: 10),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 16)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset ordinal weekday
    func testDateOffsetWeekdayOrdinal() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06)),
            let adjusted = original.offset(.weekdayOrdinal, value: 2),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 20)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset week
    func testDateOffsetWeek() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06)),
            let adjusted = original.offset(.week, value: -2),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 11, day: 22)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset month
    func testDateOffsetMonth() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06)),
            let adjusted = original.offset(.month, value: 2),
              let comparison = Calendar.current.date(from: DateComponents(year: 2010, month: 02, day: 06)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // offset week
    func testDateOffsetYear() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06)),
            let adjusted = original.offset(.year, value: -2),
              let comparison = Calendar.current.date(from: DateComponents(year: 2007, month: 12, day: 06)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .startOfDay
    func testDateAdjustStartOfDay() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
              let adjusted = original.adjust(for: .startOfDay),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 0, minute: 0, second: 0)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .endOfDay
    func testDateAdjustEndOfDay() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
              let adjusted = original.adjust(for: .endOfDay),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 23, minute: 59, second: 59, nanosecond: 999_000_000)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .startOfWeek
    func testDateAdjustStartOfWeek() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 08, hour: 18, minute: 14, second: 41)),
              let adjusted = original.adjust(for: .startOfWeek),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .endOfWeek
    func testDateAdjustEndOfWeek() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
              let adjusted = original.adjust(for: .endOfWeek),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 12, hour: 18, minute: 14, second: 41)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .startOfMonth
    func testDateAdjustStartOfMonth() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
              let adjusted = original.adjust(for: .startOfMonth),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 01, hour: 18, minute: 14, second: 41)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .endOfMonth
    func testDateAdjustEndOfMonth() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
              let adjusted = original.adjust(for: .endOfMonth),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 31, hour: 18, minute: 14, second: 41)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .tomorrow
    func testDateAdjustTomorrow() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
            let adjusted = original.adjust(for: .tomorrow),
            let tomorrow = Date().offset(.day, value: 1) else {
          return
        }
        let components = Date.components(tomorrow)
        guard let comparison = Calendar.current.date(from: DateComponents(year: components.year, month: components.month, day: components.day, hour: 18, minute: 14, second: 41)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .yesterday
    func testDateAdjustYesterday() throws {
        guard let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
            let adjusted = original.adjust(for: .yesterday),
            let yesterday = Date().offset(.day, value: -1) else {
          return
        }
        let components = Date.components(yesterday)
        guard let comparison = Calendar.current.date(from: DateComponents(year: components.year, month: components.month, day: components.day, hour: 18, minute: 14, second: 41)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .nearestMinute
    func testDateAdjustNearestMinute() throws {
        guard
              let original1 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 18, minute: 14)),
              let adjusted1 = original1.adjust(for: .nearestMinute(minute: 30)),
              let comparison1 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 18, minute: 00)),
              let original2 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 18, minute: 40)),
              let adjusted2 = original2.adjust(for: .nearestMinute(minute: 30)),
              let comparison2 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 18, minute: 30)),
              let original3 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 18, minute: 50)),
              let adjusted3 = original3.adjust(for: .nearestMinute(minute: 30)),
              let comparison3 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 19, minute: 00)) else {
          return
        }
        XCTAssertEqual(adjusted1, comparison1)
        XCTAssertEqual(adjusted2, comparison2)
        XCTAssertEqual(adjusted3, comparison3)
    }
    // adjust .nearestHour
    func testDateAdjustNearestHour() throws {
        guard
              let original1 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 18)),
              let adjusted1 = original1.adjust(for: .nearestHour(hour: 12)),
              let comparison1 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 08, hour: 00)),
              let original2 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 07)),
              let adjusted2 = original2.adjust(for: .nearestHour(hour: 12)),
              let comparison2 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 12)),
              let original3 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 03)),
              let adjusted3 = original3.adjust(for: .nearestHour(hour: 12)),
              let comparison3 = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 07, hour: 00)) else {
          return
        }
        XCTAssertEqual(adjusted1, comparison1)
        XCTAssertEqual(adjusted2, comparison2)
        XCTAssertEqual(adjusted3, comparison3)
    }
    // adjust .startOfYear
    func testDateAdjustStartOfYear() throws {
        guard
            let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 41)),
              let adjusted = original.adjust(for: .startOfYear),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 01, day: 01, hour: 0)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
    // adjust .endOfYear
    func testDateAdjustEndOfYear() throws {
        guard
              let original = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 00)),
              let adjusted = original.adjust(for: .endOfYear),
              let comparison = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 31, hour: 23, minute: 59, second: 59)) else {
          return
        }
        XCTAssertEqual(adjusted, comparison)
    }
}
