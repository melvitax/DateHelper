import XCTest
@testable import DateHelper

final class DateHelperComparisonTests: XCTestCase {
    let now = Date()
    // .isToday
    func testDateTodayComparison() throws {
        guard let comparison = now.offset(.day, value: 1) else {
          return
        }
        XCTAssertTrue(!comparison.compare(.isToday))
        XCTAssertTrue(now.compare(.isToday))
    }
    // .isTomorrow
    func testDateTomorrowComparison() throws {
        guard let comparison = now.offset(.day, value: 1) else {
          return
        }
        XCTAssertTrue(comparison.compare(.isTomorrow))
        XCTAssertTrue(!now.compare(.isTomorrow))
    }
    // .isYesterday
    func testDateYesterdayComparison() throws {
        guard let comparison = now.offset(.day, value: -1) else {
          return
        }
        XCTAssertTrue(comparison.compare(.isYesterday))
        XCTAssertTrue(!now.compare(.isYesterday))
    }
    // .isThisWeek
    func testDateThisWeekComparison() throws {
        guard let comparison = now.offset(.week, value: -1) else {
          return
        }
        XCTAssertTrue(!comparison.compare(.isThisWeek))
        XCTAssertTrue(now.compare(.isThisWeek))
    }
    // .isNextWeek
    func testDateNextWeekComparison() throws {
        guard let comparison = now.offset(.week, value: 1) else {
          return
        }
        XCTAssertTrue(comparison.compare(.isNextWeek))
        XCTAssertTrue(!now.compare(.isNextWeek))
    }
    // .isLastWeek
    func testDateLastWeekComparison() throws {
        guard let comparison = now.offset(.week, value: -1) else {
          return
        }
        XCTAssertTrue(comparison.compare(.isLastWeek))
        XCTAssertTrue(!now.compare(.isLastWeek))
    }
    // .isThisYear
    func testDateThisYearComparison() throws {
        guard let comparison = now.offset(.year, value: -1) else {
          return
        }
        XCTAssertTrue(!comparison.compare(.isThisYear))
        XCTAssertTrue(now.compare(.isThisYear))
    }
    // .isNextYear
    func testDateNextYearComparison() throws {
        guard let comparison = now.offset(.year, value: 1) else {
          return
        }
        XCTAssertTrue(comparison.compare(.isNextYear))
        XCTAssertTrue(!now.compare(.isNextYear))
    }
    // .isLastYear
    func testDateLastYearComparison() throws {
        guard let comparison = now.offset(.year, value: -1) else {
          return
        }
        XCTAssertTrue(comparison.compare(.isLastYear))
        XCTAssertTrue(!now.compare(.isLastYear))
    }
    // .isInTheFuture
    func testDateFutureComparison() throws {
        guard let future = now.offset(.week, value: 1),
        let past = now.offset(.week, value: -1) else {
          return
        }
        XCTAssertTrue(future.compare(.isInTheFuture))
        XCTAssertTrue(!past.compare(.isInTheFuture))
    }
    // .isInThePast
    func testDatePastComparison() throws {
        guard let future = now.offset(.week, value: 1),
        let past = now.offset(.week, value: -1) else {
          return
        }
        XCTAssertTrue(!future.compare(.isInThePast))
        XCTAssertTrue(past.compare(.isInThePast))
    }
    // .isSameDay
    func testDateSameDayComparison() throws {
        guard let future = now.offset(.day, value: 1),
        let past = now.offset(.day, value: -1),
              let today = now.adjust(for: .startOfDay) else {
          return
        }
        XCTAssertTrue(!future.compare(.isSameDay(as: now)))
        XCTAssertTrue(!past.compare(.isSameDay(as: now)))
        XCTAssertTrue(today.compare(.isSameDay(as: now)))
    }
    // .isSameWeek
    func testDateSameWeekComparison() throws {
        guard let future = now.offset(.week, value: 1),
        let past = now.offset(.week, value: -1),
        let today = now.adjust(for: .startOfDay) else {
          return
        }
        XCTAssertTrue(!future.compare(.isSameWeek(as: now)))
        XCTAssertTrue(!past.compare(.isSameWeek(as: now)))
        XCTAssertTrue(today.compare(.isSameWeek(as: now)))
    }
    // .isSameMonth
    func testDateSameMonthComparison() throws {
        guard let future = now.offset(.month, value: 1),
        let past = now.offset(.month, value: -1),
        let today = now.adjust(for: .startOfDay) else {
          return
        }
        XCTAssertTrue(!future.compare(.isSameMonth(as: now)))
        XCTAssertTrue(!past.compare(.isSameMonth(as: now)))
        XCTAssertTrue(today.compare(.isSameMonth(as: now)))
        
    }
    // .isSameYear
    func testDateSameYearComparison() throws {
        guard let future = now.offset(.year, value: 1),
        let past = now.offset(.year, value: -1),
        let today = now.adjust(for: .startOfDay) else {
          return
        }
        XCTAssertTrue(!future.compare(.isSameYear(as: now)))
        XCTAssertTrue(!past.compare(.isSameYear(as: now)))
        XCTAssertTrue(today.compare(.isSameYear(as: now)))
    }
    // .isEarlierThan
    func testDateEarlierThanComparison() throws {
        guard let future = now.offset(.minute, value: 1),
        let past = now.offset(.minute, value: -1) else {
          return
        }
        XCTAssertTrue(!future.compare(.isEarlier(than: now)))
        XCTAssertTrue(past.compare(.isEarlier(than: now)))
    }
    // .isLaterThan
    func testDateLaterThanComparison() throws {
        guard let future = now.offset(.minute, value: 1),
        let past = now.offset(.minute, value: -1) else {
          return
        }
        XCTAssertTrue(future.compare(.isLater(than: now)))
        XCTAssertTrue(!past.compare(.isLater(than: now)))
    }
    // .isWeekend
    func testDateIsWeekendComparison() throws {
        guard let weekday = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 15)),
        let weekend = Calendar.current.date(from: DateComponents(year: 2021, month: 12, day: 18)) else {
          return
        }
        XCTAssertTrue(!weekday.compare(.isWeekend))
        XCTAssertTrue(weekend.compare(.isWeekend))
    }
}
