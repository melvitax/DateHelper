//
//  DateHelper.swift
//  Version: 5.0.1
//  https://github.com/melvitax/DateHelper
//

import Foundation

// swiftlint:disable file_length
public extension Date {

    // MARK: - Date from String

    /// Creates a new Date from on a string with predefined or custom string format. Supports optional timezone and locale.
    init?(fromString string: String, format: DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Foundation.Locale.current, isLenient: Bool = true) {

        guard !string.isEmpty else { return nil }

        var string = string

        switch format {
        case .dotNet:
            let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: string.utf16.count)
            if let match = regex?.firstMatch(in: string, range: range) {
                let dateString = (string as NSString).substring(with: match.range(at: 1))
                if let dateNumber = Double(dateString) {
                    let interval = dateNumber / 1000.0
                    self.init(timeIntervalSince1970: interval)
                    return
                }
            }
            return nil
        case .rss, .altRSS:
            if string.hasSuffix("Z") {
                string = string[..<string.index(string.endIndex, offsetBy: -1)].appending("GMT")
            }
        case .isoDateTimeFull, .isoDateTime, .isoYear, . isoDate, .isoYearMonth:
            let formatter = Date.cachedDateFormatters.cachedISOFormatter(format, timeZone: timeZone, locale: locale)
            if let date = formatter?.date(from: string) {
                self.init(timeInterval: 0, since: date)
                return
            }
            return nil
        default:
            break
        }
        if let zone = timeZone.timeZone,
           let formatter = Date.cachedDateFormatters.cachedFormatter(format.stringFormat, timeZone: zone, locale: locale, isLenient: isLenient),
            let date = formatter.date(from: string) {
            self.init(timeInterval: 0, since: date)
        }
        return nil
    }

    /// Creates a new Date based on the first date detected on a string using data dectors. This initializer doe not use cached formatters so avoid using in lists since it's not as efficient as (fromString: format:).
    init?(detectFromString string: String) {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        // swiftlint:disable:next legacy_constructor
        let range = NSMakeRange(0, string.utf16.count)
        let matches = detector?.matches(in: string, options: [], range: range)
        if let date = matches?.first?.date {
            self.init()
            self = date
        } else {
            return nil
        }
    }

    // MARK: - String from Date

    /// String representation of date using based on style format
    func toString(style: DateStyleType = .short) -> String? {
        switch style {
        case .short, .medium, .long, .full:
            return self.toString(dateStyle: style.formatterStyle, timeStyle: style.formatterStyle, isRelative: false)
        case .ordinalDay:
            let formatter = Date.cachedDateFormatters.cachedNumberFormatter()
            formatter?.numberStyle = .ordinal
            if let day = component(.day) as NSNumber? {
                return formatter?.string(from: day)
            }
        default:
            if let symbols = Date.cachedDateFormatters.cachedFormatter()?.symbols(for: style),
                let weekday = component(.weekday) {
                return symbols[weekday-1] as String
            }
        }
        return nil
    }

    /// Converts the date to string based on a date format, optional timezone and optional locale.
    func toString(format: DateFormatType, timeZone: TimeZoneType = .local, locale: Locale = Locale.current) -> String? {
        switch format {
        case .dotNet:
            let offset = Foundation.NSTimeZone.default.secondsFromGMT() / 3600
            let nowMillis = 1000 * self.timeIntervalSince1970
            return String(format: format.stringFormat, nowMillis, offset)
        case .isoDateTimeFull, .isoDateTime, .isoYear, .isoDate, .isoYearMonth:
            let formatter = Date.cachedDateFormatters.cachedISOFormatter(format, timeZone: timeZone, locale: locale)
            return formatter?.string(from: self)
        default:
            break
        }
        if let zone = timeZone.timeZone {
            let formatter = Date.cachedDateFormatters.cachedFormatter(format.stringFormat, timeZone: zone, locale: locale)
            return formatter?.string(from: self)
        }
        return nil
    }

    /// Converts the date to string based on a date style and time style with optional relative date formatting, optional time zone and optional locale.
    // swiftlint:disable:next line_length
    func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, isRelative: Bool = false, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current) -> String? {
        let formatter = Date.cachedDateFormatters.cachedFormatter(dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: isRelative, timeZone: timeZone, locale: locale)
        return formatter?.string(from: self)
    }

    /// Converts date to string based on a relative time language. i.e. just now, 1 minute ago etc...
    // swiftlint:disable:next cyclomatic_complexity
    func toStringWithRelativeTime(customStrings: [RelativeTimeType: String]? = nil) -> String? {
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        let seconds: Double = abs(now - time)
        let minutes: Double = round(seconds/60)
        let hours: Double = round(minutes/60)
        let days: Double = round(hours/24)
        let relativeTimeType = toRelativeTime()
        let format = customStrings?[relativeTimeType] ?? relativeTimeType.defaultFormat
        switch relativeTimeType {
        case .secondsPast, .secondsFuture:
            return String(format: format, seconds)
        case .minutesPast, .minutesFuture:
            return String(format: format, minutes)
        case .hoursPast, .hoursFuture:
            return String(format: format, hours)
        case .daysPast, .daysFuture:
            return String(format: format, days)
        case .weeksPast, .weeksFuture:
            if let since = since(Date(), in: .week) {
                let w = Double(abs(since))
                return String(format: format, w)
            }
        case .monthsPast, .monthsFuture:
            if let since = since(Date(), in: .month) {
                let m = Double(abs(since))
                return String(format: format, m)
            }
        case .yearsPast, .yearsFuture:
            if let since = since(Date(), in: .year) {
                let y = Double(abs(since))
                return String(format: format, y)
            }
        default:
            return format
        }
        return nil
    }

    /// Converts the date to  a relative time language. i.e. .nowPast, .minutesFuture
    // swiftlint:disable:next cyclomatic_complexity
    private func toRelativeTime() -> RelativeTimeType {
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        let isPast = now - time > 0
        let seconds: Double = abs(now - time)

        switch seconds {
        case let s where s <= DateComponentType.second.inSeconds*10:
            return isPast ? .nowPast : .nowFuture
        case let s where s < DateComponentType.minute.inSeconds:
            return isPast ? .secondsPast : .secondsFuture
        case let s where s < DateComponentType.minute.inSeconds*2:
            return isPast ? .oneMinutePast : .oneMinuteFuture
        case let s where s < DateComponentType.hour.inSeconds:
            return isPast ? .minutesPast : .minutesFuture
        case let s where s < DateComponentType.hour.inSeconds*2:
            return isPast ? .oneHourPast : .oneHourFuture
        case let s where s < DateComponentType.day.inSeconds:
            return isPast ? .hoursPast : .hoursFuture
        case let s where s < DateComponentType.day.inSeconds*2:
            return isPast ? .oneDayPast : .oneDayFuture
        case let s where s < DateComponentType.day.inSeconds*7:
            return isPast ? .daysPast : .daysFuture
        case let s where s < DateComponentType.day.inSeconds*14:
            return isPast ? .oneWeekPast : .oneWeekFuture
        case let s where s < DateComponentType.month.inSeconds:
            if isPast {
                return compare(.isLastWeek) ? .oneWeekPast : .weeksPast
            } else {
                return compare(.isNextWeek) ? .oneWeekFuture : .weeksFuture
            }
        default:
            if compare(.isThisYear) {
                if isPast {
                    return compare(.isLastMonth) ? .oneMonthPast : .monthsPast
                } else {
                    return compare(.isNextMonth) ? .oneMonthFuture : .monthsFuture
                }
            } else {
                if isPast {
                    return compare(.isLastYear) ? .oneYearPast : .yearsPast
                } else {
                    return compare(.isNextYear) ? .oneYearFuture : .yearsFuture
                }
            }
        }
    }

    // MARK: - Compare Dates

    /// Compares dates to see if they are equal while ignoring time.
    // swiftlint:disable:next cyclomatic_complexity function_body_length
    func compare(_ comparison: DateComparisonType) -> Bool {
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        let isPast = now - time > 0
        let offset = isPast ? -1 : 1
        switch comparison {
        case .isToday:
            return compare(.isSameDay(as: Date()))
        case .isTomorrow, .isYesterday:
            if let comparison = Date().offset(.day, value: offset) {
                return compare(.isSameDay(as: comparison))
            }
        case .isSameDay(let date):
            return component(.year) == date.component(.year) && component(.month) == date.component(.month) && component(.day) == date.component(.day)
        case .isThisWeek:
            return self.compare(.isSameWeek(as: Date()))
        case .isNextWeek, .isLastWeek:
            if let comparison = Date().offset(.week, value: offset) {
                return compare(.isSameWeek(as: comparison))
            }
        case .isSameWeek(let date):
            if component(.week) != date.component(.week) {
                return false
            }
            // Ensure time interval is under 1 week
            return abs(self.timeIntervalSince(date)) < DateComponentType.week.inSeconds
        case .isThisMonth:
            return self.compare(.isSameMonth(as: Date()))
        case .isNextMonth, .isLastMonth:
            if let comparison = Date().offset(.month, value: offset) {
                return compare(.isSameMonth(as: comparison))
            }
        case .isSameMonth(let date):
            return component(.year) == date.component(.year) && component(.month) == date.component(.month)
        case .isThisYear:
            return self.compare(.isSameYear(as: Date()))
        case .isNextYear, .isLastYear:
            if let comparison = Date().offset(.year, value: offset) {
                return compare(.isSameYear(as: comparison))
            }
        case .isSameYear(let date):
            return component(.year) == date.component(.year)
        case .isInTheFuture:
            return self.compare(.isLater(than: Date()))
        case .isInThePast:
            return self.compare(.isEarlier(than: Date()))
        case .isEarlier(let date):
            return (self as NSDate).earlierDate(date) == self
        case .isLater(let date):
            return (self as NSDate).laterDate(date) == self
        case .isWeekday:
            return !compare(.isWeekend)
        case .isWeekend:
            if let range = Calendar.current.maximumRange(of: Calendar.Component.weekday) {
                return (component(.weekday) == range.lowerBound || component(.weekday) == range.upperBound - range.lowerBound)
            }
        }
        return false
    }

    // MARK: - Adjust dates

    /// Offsets a date component with a +/- value
    func offset(_ component: DateComponentType, value: Int) -> Date? {
        var dateComp = DateComponents()
        switch component {
        case .second:
            dateComp.second = value
        case .minute:
            dateComp.minute = value
        case .hour:
            dateComp.hour = value
        case .day:
            dateComp.day = value
        case .weekday:
            dateComp.weekday = value
        case .weekdayOrdinal:
            dateComp.weekdayOrdinal = value
        case .week:
            dateComp.weekOfYear = value
        case .month:
            dateComp.month = value
        case .year:
                dateComp.year = value
        }
        return Calendar.current.date(byAdding: dateComp, to: self)
    }

    /// Sets a new value to the specified component and returns as a new date
    func adjust(hour: Int? = nil, minute: Int? = nil, second: Int? = nil, day: Int? = nil, month: Int? = nil) -> Date? {
        var comp = Date.components(self)
        comp.month = month ?? comp.month
        comp.day = day ?? comp.day
        comp.hour = hour ?? comp.hour
        comp.minute = minute ?? comp.minute
        comp.second = second ?? comp.second
        return Calendar.current.date(from: comp)
    }

    // MARK: - Date for...

    // swiftlint:disable:next cyclomatic_complexity
    func adjust(for type: DateAdjustmentType, calendar: Calendar = Calendar.current) -> Date? {
        switch type {
        case .startOfDay:
            return adjust(hour: 0, minute: 0, second: 0)
        case .endOfDay:
            return adjust(hour: 23, minute: 59, second: 59)
        case .startOfWeek:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear, .hour, .minute, .second, .nanosecond], from: self))
        case .endOfWeek:
            let weekStart = self.adjust(for: .startOfWeek, calendar: calendar)
            return weekStart?.offset(.day, value: 6)
        case .startOfMonth:
            return adjust(day: 1)
        case .endOfMonth:
            return adjust(day: numberOfDaysInMonth())
        case .tomorrow:
            let tomorrow = Date().offset(.day, value: 1)
            var components = Date.components(self)
            components.year = tomorrow?.component(.year)
            components.month = tomorrow?.component(.month)
            components.day = tomorrow?.component(.day)
            return Calendar.current.date(from: components)
        case .yesterday:
            let tomorrow = Date().offset(.day, value: -1)
            var components = Date.components(self)
            components.year = tomorrow?.component(.year)
            components.month = tomorrow?.component(.month)
            components.day = tomorrow?.component(.day)
            return Calendar.current.date(from: components)
        case .nearestMinute(let minute):
            if let component = component(.minute) {
                let value = max(min(minute, 60), 0)
                let minutes = (component + value/2) / value * value
                return adjust(hour: nil, minute: minutes, second: nil)
            }
        case .nearestHour(let hour):
            if let component = component(.hour) {
                let value = max(min(hour, 24), 0)
                let hours = (component + value/2) / value * value
                return adjust(hour: hours, minute: 0, second: nil)
            }
        case .startOfYear:
            if let component = component(.year) {
                let date = Date(fromString: "\(component)-01-01", format: .isoDate)
                return date?.adjust(hour: 0, minute: 0, second: 0)
            }
        case .endOfYear:
            if let component = component(.year) {
                let date = Date(fromString: "\(component)-12-31", format: .isoDate)
                return date?.adjust(hour: 23, minute: 59, second: 59)
            }
        }
        return nil
    }

    // MARK: - Time since...

    func since(_ date: Date, in component: DateComponentType) -> Int64? {
        let calendar = Calendar.current
        switch component {
        case .second, .minute, .hour:
            let interval = timeIntervalSince(date)
            return Int64(interval / component.inSeconds)
        case .day, .weekday, .weekdayOrdinal, .week, .month, .year:
            if let end = calendar.ordinality(of: component.calendarComponent, in: .era, for: self),
               let start = calendar.ordinality(of: component.calendarComponent, in: .era, for: date) {
                return Int64(end - start)
            }
        }
        return nil
    }

    // MARK: - Extracting components

    func component(_ component: DateComponentType) -> Int? {
        let components = Date.components(self)
        switch component {
        case .second:
            return components.second
        case .minute:
            return components.minute
        case .hour:
            return components.hour
        case .day:
            return components.day
        case .weekday:
            return components.weekday
        case .weekdayOrdinal:
            return components.weekdayOrdinal
        case .week:
            return components.weekOfYear
        case .month:
            return components.month
        case .year:
            return components.year
        }
    }

    func numberOfDaysInMonth() -> Int? {
        let day = Calendar.Component.day
        let month = Calendar.Component.month
        if let range = Calendar.current.range(of: day, in: month, for: self) {
            return range.upperBound - range.lowerBound
        }
        return nil
    }

    func firstDayOfWeek() -> Int? {
        guard let component = component(.weekday) else { return nil }
        let aDay = DateComponentType.day.inSeconds
        let startOfWeekOffset = aDay * Double(component - 1)
        let interval: TimeInterval = timeIntervalSinceReferenceDate - startOfWeekOffset
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)
    }

    func lastDayOfWeek() -> Int? {
        guard let component = component(.weekday) else { return nil }
        let aDay = DateComponentType.day.inSeconds
        let tartOfWeekOffset = aDay * Double(component - 1)
        let endOfWeekOffset = aDay * Double(7)
        let interval: TimeInterval = timeIntervalSinceReferenceDate - tartOfWeekOffset + endOfWeekOffset
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)
    }

    // MARK: - Internal Components

    internal static func componentFlags() -> Set<Calendar.Component> {
        [.year, .month, .day, .weekOfYear, .hour, .minute, .second, .weekday, .weekdayOrdinal, .weekOfYear]
    }
    internal static func components(_ fromDate: Date) -> DateComponents {
        Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }

    // MARK: Formatter

    private class ConcurrentFormatterCache {

        private static let cachedISODateFormattersQueue = DispatchQueue(
            label: "iso-date-formatter-queue",
            attributes: .concurrent
        )
        private static let cachedDateFormattersQueue = DispatchQueue(
            label: "date-formatter-queue",
            attributes: .concurrent
        )

        private static let cachedNumberFormatterQueue = DispatchQueue(
            label: "number-formatter-queue",
            attributes: .concurrent
        )

        private static var cachedISODateFormatters = [String: ISO8601DateFormatter]()
        private static var cachedDateFormatters = [String: DateFormatter]()
        private static var cachedNumberFormatter = NumberFormatter()

        private func register(hashKey: String, formatter: ISO8601DateFormatter) {
            ConcurrentFormatterCache.cachedISODateFormattersQueue.async(flags: .barrier) {
                ConcurrentFormatterCache.cachedISODateFormatters.updateValue(formatter, forKey: hashKey)
            }
        }

        private func register(hashKey: String, formatter: DateFormatter) {
            ConcurrentFormatterCache.cachedDateFormattersQueue.async(flags: .barrier) {
                ConcurrentFormatterCache.cachedDateFormatters.updateValue(formatter, forKey: hashKey)
            }
        }

        private func retrieve(hashKeyForISO hashKey: String) -> ISO8601DateFormatter? {
            let dateFormatter = ConcurrentFormatterCache.cachedISODateFormattersQueue.sync { () -> ISO8601DateFormatter? in
                guard let result = ConcurrentFormatterCache.cachedISODateFormatters[hashKey] else { return nil }
                return result.copy() as? ISO8601DateFormatter
            }
            return dateFormatter
        }

        private func retrieve(hashKey: String) -> DateFormatter? {
            let dateFormatter = ConcurrentFormatterCache.cachedDateFormattersQueue.sync { () -> DateFormatter? in
                guard let result = ConcurrentFormatterCache.cachedDateFormatters[hashKey] else { return nil }
                return result.copy() as? DateFormatter
            }
            return dateFormatter
        }

        private func retrieve() -> NumberFormatter? {
            let numberFormatter = ConcurrentFormatterCache.cachedNumberFormatterQueue.sync { () -> NumberFormatter? in
                if let formatter = ConcurrentFormatterCache.cachedNumberFormatter.copy() as? NumberFormatter {
                    return formatter
                }
                return nil
            }
            return numberFormatter
        }

        public func cachedISOFormatter(_ format: DateFormatType, timeZone: TimeZoneType, locale: Locale) -> ISO8601DateFormatter? {

            let hashKey = "\(format.stringFormat.hashValue)\(timeZone.timeZone.hashValue)\(locale.hashValue)"

            if Date.cachedDateFormatters.retrieve(hashKeyForISO: hashKey) == nil {
                let formatter = ISO8601DateFormatter()
                formatter.timeZone = timeZone.timeZone

                var options: ISO8601DateFormatter.Options = []
                switch format {
                case .isoYear:
                    options = [.withYear, .withFractionalSeconds]
                case .isoYearMonth:
                    options = [.withYear, .withMonth, .withDashSeparatorInDate]
                case .isoDate:
                    options = [.withFullDate]
                case .isoDateTime:
                    options = [.withInternetDateTime]
                case .isoDateTimeFull:
                    options = [.withInternetDateTime, .withFractionalSeconds]
                default:
                    fatalError("Unimplemented format \(format)")
                }
                formatter.formatOptions = options
                Date.cachedDateFormatters.register(hashKey: hashKey, formatter: formatter)
            }
            return Date.cachedDateFormatters.retrieve(hashKeyForISO: hashKey)
        }

        public func cachedFormatter(_ format: String = DateFormatType.standard.stringFormat,
                                    timeZone: Foundation.TimeZone = Foundation.TimeZone.current,
                                    locale: Locale = Locale.current, isLenient: Bool = true) -> DateFormatter? {

                let hashKey = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"

                if Date.cachedDateFormatters.retrieve(hashKey: hashKey) == nil {
                    let formatter = DateFormatter()
                    formatter.dateFormat = format
                    formatter.timeZone = timeZone
                    formatter.locale = locale
                    formatter.isLenient = isLenient
                    Date.cachedDateFormatters.register(hashKey: hashKey, formatter: formatter)
                }
                return Date.cachedDateFormatters.retrieve(hashKey: hashKey)
        }

        /// Generates a cached formatter based on the provided date style, time style and relative date.
        /// Formatters are cached in a singleton array using hashkeys.
        // swiftlint:disable:next line_length
        public func cachedFormatter(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, doesRelativeDateFormatting: Bool, timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local, locale: Locale = Locale.current, isLenient: Bool = true) -> DateFormatter? {
            let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
            if Date.cachedDateFormatters.retrieve(hashKey: hashKey) == nil {
                let formatter = DateFormatter()
                formatter.dateStyle = dateStyle
                formatter.timeStyle = timeStyle
                formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
                formatter.timeZone = timeZone
                formatter.locale = locale
                formatter.isLenient = isLenient
                Date.cachedDateFormatters.register(hashKey: hashKey, formatter: formatter)
            }
            return Date.cachedDateFormatters.retrieve(hashKey: hashKey)
        }

        public func cachedNumberFormatter() -> NumberFormatter? {
            Date.cachedDateFormatters.retrieve()
        }
    }

    /// A cached static array of DateFormatters so that thy are only created once.
    private static var cachedDateFormatters = Self.ConcurrentFormatterCache()

    // MARK: - Enums

    /// The date format type used for string conversion.
    enum DateFormatType {
        /// The ISO8601 formatted year "yyyy" i.e. 1997
        case isoYear
        /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
        case isoYearMonth
        /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
        case isoDate
        /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
        case isoDateTime
        /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
        case isoDateTimeFull
        /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
        case dotNet
        /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
        case rss
        /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
        case altRSS
        /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
        case httpHeader
        /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
        case standard
        /// A custom date format string
        case custom(String)
        var stringFormat: String {
            switch self {
            case .isoYear: return "yyyy"
            case .isoYearMonth: return "yyyy-MM"
            case .isoDate: return "yyyy-MM-dd"
            case .isoDateTime: return "yyyy-MM-dd'T'HH:mm:ssZ"
            case .isoDateTimeFull: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            case .dotNet: return "/Date(%d%f)/"
            case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
            case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
            case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
            case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
            case .custom(let customFormat): return customFormat
            }
        }
    }

    /// The time zone to be used for date conversion
    enum TimeZoneType {
        case local, `default`, utc, custom(Int)
        var timeZone: TimeZone? {
            switch self {
            case .local: return NSTimeZone.local
            case .default: return NSTimeZone.default
            case .utc: return TimeZone(secondsFromGMT: 0)
            case let .custom(gmt): return TimeZone(secondsFromGMT: gmt)
            }
        }
    }

    /// The string keys to modify the strings in relative format
    enum RelativeTimeType {
        // swiftlint:disable:next line_length
        /// A string representing the past tense of something recent in less than 10 seconds: "just now"
        case nowPast
        /// A string representing the future tense of something soon in less than 10 seconds: "in a few seconds"
        case nowFuture
        /// A formatted string representing the past tense of something less than a minute in seconds: "%.f seconds ago"
        case secondsPast
        /// A formatted string representing the future tense of something less than a minute in seconds: "in %.f seconds"
        case secondsFuture
        /// A string representing the past tense of less than 2 minutes: "one minute ago"
        case oneMinutePast
        /// A string representing the future tense of less than 2 minutes: "in one minute"
        case oneMinuteFuture
        /// A formatted string representing the past tense of something less than an hour: "%.f minutes ago"
        case minutesPast
        /// A formatted string representing the future tense of something in less than an hour: "in %.f minutes"
        case minutesFuture
        /// A string representing the past tense of less than 2 hours: "one hour ago"
        case oneHourPast
        /// A string representing the future tense of less than 2 hours: "in one hour"
        case oneHourFuture
        /// A formatted string representing the past tense of something less than a day: "%.f hours ago"
        case hoursPast
        /// A formatted string representing the future tense of something in less than a day: "in %.f hours"
        case hoursFuture
        /// A string representing the past tense of less than 2 days: "yesterday"
        case oneDayPast
        /// A string representing the future tense of less than 2 days: "tomorrow"
        case oneDayFuture
        /// A formatted string representing the past tense of something less than a week: "%.f days ago"
        case daysPast
        /// A formatted string representing the future tense of something in less than a week: "in %.f days"
        case daysFuture
        /// A string representing the past tense of less than 2 weeks: "last week"
        case oneWeekPast
        /// A string representing the future tense of less than 2 weeks: "next week"
        case oneWeekFuture
        /// A formatted string representing the past tense of something less than a month: "%.f weeks ago"
        case weeksPast
        /// A formatted string representing the future tense of something in less than a month: "in %.f weeks"
        case weeksFuture
        /// A string representing the past tense of less than 2 months: "last month"
        case oneMonthPast
        /// A string representing the future tense of less than 2 months: "next month"
        case oneMonthFuture
        /// A formatted string representing the past tense of something less than a year: "%.f months ago"
        case monthsPast
        /// A formatted string representing the future tense of something in less than a year: "in %.f months"
        case monthsFuture
        /// A string representing the past tense of less than 2 years: "last year"
        case oneYearPast
        /// A string representing the future tense of less than 2 years: "next year"
        case oneYearFuture
        /// A formatted string representing past tense of years: "%.f years ago"
        case yearsPast
        /// A formatted string representing the future tense of years: "in %.f years"
        case yearsFuture
        var defaultFormat: String {
            switch self {
            case .nowPast:
                return NSLocalizedString("just now", comment: "Date format")
            case .nowFuture:
                return NSLocalizedString("in a few seconds", comment: "Date format")
            case .secondsPast:
                return NSLocalizedString("%.f seconds ago", comment: "Date format")
            case .secondsFuture:
                return NSLocalizedString("in %.f seconds", comment: "Date format")
            case .oneMinutePast:
                return NSLocalizedString("1 minute ago", comment: "Date format")
            case .oneMinuteFuture:
                return NSLocalizedString("in 1 minute", comment: "Date format")
            case .minutesPast:
                return NSLocalizedString("%.f minutes ago", comment: "Date format")
            case .minutesFuture:
                return NSLocalizedString("in %.f minutes", comment: "Date format")
            case .oneHourPast:
                return NSLocalizedString("last hour", comment: "Date format")
            case .oneHourFuture:
                return NSLocalizedString("next hour", comment: "Date format")
            case .hoursPast:
                return NSLocalizedString("%.f hours ago", comment: "Date format")
            case .hoursFuture:
                return NSLocalizedString("in %.f hours", comment: "Date format")
            case .oneDayPast:
                return NSLocalizedString("yesterday", comment: "Date format")
            case .oneDayFuture:
                return NSLocalizedString("tomorrow", comment: "Date format")
            case .daysPast:
                return NSLocalizedString("%.f days ago", comment: "Date format")
            case .daysFuture:
                return NSLocalizedString("in %.f days", comment: "Date format")
            case .oneWeekPast:
                return NSLocalizedString("last week", comment: "Date format")
            case .oneWeekFuture:
                return NSLocalizedString("next week", comment: "Date format")
            case .weeksPast:
                return NSLocalizedString("%.f weeks ago", comment: "Date format")
            case .weeksFuture:
                return NSLocalizedString("in %.f weeks", comment: "Date format")
            case .oneMonthPast:
                return NSLocalizedString("last month", comment: "Date format")
            case .oneMonthFuture:
                return NSLocalizedString("next month", comment: "Date format")
            case .monthsPast:
                return NSLocalizedString("%.f months ago", comment: "Date format")
            case .monthsFuture:
                return NSLocalizedString("in %.f months", comment: "Date format")
            case .oneYearPast:
                return NSLocalizedString("last year", comment: "Date format")
            case .oneYearFuture:
                return NSLocalizedString("next year", comment: "Date format")
            case .yearsPast:
                return NSLocalizedString("%.f years ago", comment: "Date format")
            case .yearsFuture:
                return NSLocalizedString("in %.f years", comment: "Date format")
            }
        }
    }

    /// The type of comparison to do against today's date or with the suplied date.
    enum DateComparisonType {
        //  Days
        /// Checks if date today.
        case isToday
        /// Checks if date is tomorrow.
        case isTomorrow
        /// Checks if date is yesterday.
        case isYesterday
        /// Compares date days
        case isSameDay(as: Date)
        //  Weeks
        /// Checks if date is in this week.
        case isThisWeek
        /// Checks if date is in next week.
        case isNextWeek
        /// Checks if date is in last week.
        case isLastWeek
        /// Compares date weeks
        case isSameWeek(as: Date)
        //  Months
        /// Checks if date is in this month.
        case isThisMonth
        /// Checks if date is in next month.
        case isNextMonth
        /// Checks if date is in last month.
        case isLastMonth
        /// Compares date months
        case isSameMonth(as: Date)
        //  Years
        /// Checks if date is in this year.
        case isThisYear
        /// Checks if date is in next year.
        case isNextYear
        /// Checks if date is in last year.
        case isLastYear
        /// Compare date years
        case isSameYear(as: Date)
        //  Relative Time
        /// Checks if it's a future date
        case isInTheFuture
        /// Checks if the date has passed
        case isInThePast
        /// Checks if earlier than date
        case isEarlier(than: Date)
        /// Checks if later than date
        case isLater(than: Date)
        /// Checks if it's a weekday
        case isWeekday
        /// Checks if it's a weekend
        case isWeekend
    }

    /// The date components available to be retrieved or modifed
    enum DateComponentType {
        case second, minute, hour, day, weekday, weekdayOrdinal, week, month, year
        var inSeconds: Double {
            switch self {
            case .second: return 1
            case .minute: return 60
            case .hour: return 3600
            case .day: return 86400
            case .week: return 604800
            case .month: return 2419200 // 28 days
            case .year: return 31556926
            default: return 0
            }
        }
        var calendarComponent: Calendar.Component {
            switch self {
            case .second: return .second
            case .minute: return .minute
            case .hour: return .hour
            case .day: return .day
            case .weekday: return .weekday
            case .weekdayOrdinal: return .weekdayOrdinal
            case .week: return .weekOfYear
            case .month: return .month
            case .year: return .year
            }
        }
    }

    /// The type of date that can be used for the dateFor function
    enum DateAdjustmentType {
        // Adjusts the date to the begining of the day at 00:00:01
        case startOfDay
        // Adjusts the date to the end of the day at 11:59:59
        case endOfDay
        // Adjusts the day to the start of the week
        case startOfWeek
        // Adjusts the day to the end of the week
        case endOfWeek
        // Adjusts the day to the start of the month
        case startOfMonth
        // Adjusts the day to the end of the month
        case endOfMonth
        // Adjusts the day to tomorrow
        case tomorrow
        // Adjusts the day to yestersay
        case yesterday
        // Adjusts the date to the nearest minute. ie: with nearestMinute(minute: 30) 10:17 becomes 10:30 and 10:05 becomes 10:00
        case nearestMinute(minute: Int)
        // Adjusts the date to the nearest hours. ie: with nearestHour(hour: 6) 10:17 becomes 12:17 and 07:017 becomes 06:17
        case nearestHour(hour: Int)
        // Adjusts the day to the start of the year
        case startOfYear
        // Adjusts the day to the end of the year
        case endOfYear
    }

    /// Convenience types for date to string conversion
    enum DateStyleType: String {
        /// Short style: "2/27/17, 2:22 PM"
        case short
        /// Medium style: "Feb 27, 2017, 2:22:06 PM"
        case medium
        /// Long style: "February 27, 2017 at 2:22:06 PM EST"
        case long
        /// Full style: "Monday, February 27, 2017 at 2:22:06 PM Eastern Standard Time"
        case full
        /// Ordinal day: "27th"
        case ordinalDay
        /// Weekday: "Monday"
        case weekday
        /// Short week day: "Mon"
        case shortWeekday
        /// Very short weekday: "M"
        case veryShortWeekday
        /// Month: "February"
        case month
        /// Short month: "Feb"
        case shortMonth
        /// Very short month: "F"
        case veryShortMonth
        var formatterStyle: DateFormatter.Style {
            switch self {
            case .short: return .short
            case .medium: return .medium
            case .long: return .long
            case .full: return .full
            default: return .none
            }
        }
    }
}

extension Date.DateFormatType: Equatable {
    // swiftlint:disable:next operator_whitespace
    public static func ==(lhs: Date.DateFormatType, rhs: Date.DateFormatType) -> Bool {
        switch (lhs, rhs) {
        case (.custom(let lhsString), .custom(let rhsString)):
            return lhsString == rhsString
        default:
            return lhs == rhs
        }
    }
}

extension DateFormatter {
    fileprivate func symbols(for dateStyleType: Date.DateStyleType) -> [String] {
        switch dateStyleType {
        case .weekday: return weekdaySymbols
        case .shortWeekday: return shortWeekdaySymbols
        case .veryShortWeekday: return veryShortWeekdaySymbols
        case .month: return monthSymbols
        case .shortMonth: return shortMonthSymbols
        case .veryShortMonth: return veryShortMonthSymbols
        default: return [String]()
        }
    }
}
