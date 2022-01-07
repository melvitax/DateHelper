import XCTest
@testable import DateHelper

final class DateHelperTimeSinceTests: XCTestCase {
    
    // time since in second
    func testDateTimeSinceInSecond() throws {
        guard
            let date = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 06, hour: 18, minute: 14, second: 11)),
            let minus30Sec = date.offset(.second, value: -30),
            let minus30SecSince = date.since(minus30Sec, in: .second),
            let minus2Hr = date.offset(.hour, value: -2),
            let minus2HrSinceMin = date.since(minus2Hr, in: .minute),
            let minus2HrSinceHr = date.since(minus2Hr, in: .hour),
            let minus1Day = date.offset(.day, value: -1),
            let minus1DaySince = date.since(minus1Day, in: .day),
            let minus1Week = date.offset(.week, value: -1),
            let minus1WeekSince = date.since(minus1Week, in: .week),
            let plus1Week = date.offset(.week, value: 1),
            let plus1WeekSince = date.since(plus1Week, in: .week),
            let minus2Week = date.offset(.week, value: -2),
            let minus2WeekSince = date.since(minus2Week, in: .weekdayOrdinal),
            let minus1Month = date.offset(.month, value: -1),
            let minus1MonthSince = date.since(minus1Month, in: .month),
            let minus1Year = date.offset(.year, value: -1),
            let minus1YearSince = date.since(minus1Year, in: .year)
             else {
          return
        }
        print("date: \(date.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        print("minus30SecSince: \(minus30Sec.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        print("minus2Hr: \(minus2Hr.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        print("minus1Day: \(minus1Day.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        print("minus1Week: \(minus1Week.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        print("plus1Week: \(plus1Week.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        print("minus2Week: \(minus2Week.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        print("minus1Month: \(minus1Month.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        print("minus1Year: \(minus1Year.toString(format: .custom("yyyy-MM-dd hh-mm-ss"))!)")
        XCTAssertEqual(minus30SecSince, 30)
        XCTAssertEqual(minus2HrSinceMin, 120)
        XCTAssertEqual(minus2HrSinceHr, 2)
        XCTAssertEqual(minus1DaySince, 1)
        XCTAssertEqual(minus1WeekSince, 1)
        XCTAssertEqual(plus1WeekSince, -1)
        XCTAssertEqual(minus2WeekSince, 2)
        XCTAssertEqual(minus1MonthSince, 1)
        XCTAssertEqual(minus1YearSince, 1)
    }
}
