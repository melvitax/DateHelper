//
//  NSDate+AFDateHelperObjC.m
//  AFDateHelperExtObjective-C
//
//  Created by Tassilo Lechner von Leheneck on 01/04/16.
//  Copyright © 2016 Tassilo Lechner von Leheneck. All rights reserved.
//

#import "NSDate+AFDateHelperObjC.h"


@implementation NSDate (AFDateHelperObjC)


NSString *DefaultFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
NSString *RSSFormat = @"EEE, d MMM yyyy HH:mm:ss ZZZ"; // "Fri, 09 Sep 2011 15:26:08 +0200"
NSString *AltRSSFormat = @"d MMM yyyy HH:mm:ss ZZZ"; // "09 Sep 2011 15:26:08 +0200"

// MARK: Intervals In Seconds

- (void)setTimezone:(TimeZone)timeZone {
    timezone = timeZone;
}

- (TimeZone) timezone {
    return timezone;
}

+ (NSNumber *) minuteInSeconds {
    NSNumber *result = [NSNumber numberWithInt:60];
    return result;
}
+ (NSNumber *) hourInSeconds {
    NSNumber *result = [NSNumber numberWithInt:3600];
    return result;
}
+ (NSNumber *) dayInSeconds {
    NSNumber *result = [NSNumber numberWithInt:86400];
    return result;
}
+ (NSNumber *) weekInSeconds {
    NSNumber *result = [NSNumber numberWithInt:604800];
    return result;
}
+ (NSNumber *) yearInSeconds {
    NSNumber *result = [NSNumber numberWithInt:31556926];
    return result;
}


// MARK: Components

+ (NSCalendarUnit) componentFlags {
    return NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear;
}


+ (NSDateComponents *) components: (NSDate *) fromDate {
    return [[NSCalendar currentCalendar] components:[NSDate componentFlags] fromDate:fromDate];
}


- (NSDateComponents *) components {
    return [NSDate components: self];
}

    
    // MARK: Date From String
    
    /**
     Creates a date based on a string and a formatter type. You can ise .ISO8601(nil) to for deducting an ISO8601Format automatically.
     
     - Parameter fromString Date string i.e. "16 July 1972 6:12:00".
     - Parameter format The Date Formatter type can be .ISO8601(ISO8601Format?), .DotNet, .RSS, .AltRSS or Custom(String).

     - Returns A new date
     */



- (instancetype) initFromString: (NSString *) string withFormat: (DateFormat *) format {
    if (string.length == 0) {
        return [self init];
    }
    
    TimeZone timeZone;
    timeZone = kTimeZoneLocal;
    NSTimeZone *zone;
    
//    switch (timeZone) {
//        case kTimeZoneLocal:
//            zone = [NSTimeZone localTimeZone];
//        case kTimeZoneUTC:
//            zone = [NSTimeZone timeZoneForSecondsFromGMT: 0];
//    }
    zone = [NSTimeZone localTimeZone];
    
    if([format.dateFormatType compare: DotNetDateFormatType] == NSOrderedSame) {
        NSInteger startIndex = [string rangeOfString:@"("].location + 1;
        NSInteger endIndex = [string rangeOfString:@")"].location;
        NSRange range = NSMakeRange( startIndex, endIndex-startIndex);
        double miliseconds = [string substringWithRange: range].longLongValue;
        NSTimeInterval interval = miliseconds/1000;
        return [self initWithTimeIntervalSince1970: interval];
    }
    else if([format.dateFormatType compare: ISO8601DateFormatType] == NSOrderedSame) {
        NSString *isoFormat = format.formatDetails;
        NSString *dateFormat = (isoFormat != nil) ? isoFormat : ISO8601DateFormatType;
        NSDateFormatter *formatter = [NSDate formatterWithFormat: dateFormat andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
        formatter.locale = [NSLocale localeWithLocaleIdentifier: (@"en_US_POSIX")];
        formatter.timeZone = [NSTimeZone localTimeZone];
        formatter.dateFormat = dateFormat;
        NSDate *date = [formatter dateFromString:(string)];

        if (date != nil){
            return [self initWithTimeInterval: 0 sinceDate: date];
        }
        else {
            return [self init];
        }
    }
    else if([format.dateFormatType compare: RSSDateFormatType] == NSOrderedSame) {
        NSString *s = string;
        if ([string hasSuffix:(@"Z")]) {
            s = [NSString stringWithFormat:@"%@ GMT",[s substringToIndex:(s.length-1)]];
        }
        NSDateFormatter *formatter = [NSDate formatterWithFormat: RSSDateFormatType andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
        NSDate *date = [formatter dateFromString:(string)];

        if (date != nil){
            return [self initWithTimeInterval: 0 sinceDate: date];
        }
        else {
            return [self init];
        }
    }
    else if([format.dateFormatType compare: AltRSSDateFormatType] == NSOrderedSame) {
        NSString *s = string;
        if ([string hasSuffix:(@"Z")]) {
            s = [NSString stringWithFormat:@"%@ GMT",[s substringToIndex:(s.length-1)]];
        }
        NSDateFormatter *formatter = [NSDate formatterWithFormat: AltRSSDateFormatType andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
        NSDate *date = [formatter dateFromString:(string)];
        if (date != nil){
            return [self initWithTimeInterval: 0 sinceDate: date];
        }
        else {
            return [self init];
        }
    }
    else if([format.dateFormatType compare: CustomDateFormatType] == NSOrderedSame) {
        NSString *dateFormat = format.formatDetails;
        NSDateFormatter *formatter = [NSDate formatterWithFormat: dateFormat andTimeZone: zone andLocale: [NSLocale currentLocale]];
        NSDate *date = [formatter dateFromString:(string)];
        if (date != nil){
            return [self initWithTimeInterval: 0 sinceDate: date];
        }
        else {
            return [self init];
        }
    }
    return 0;
}

    
    // MARK: Comparing Dates
    
    /**
     Returns true if dates are equal while ignoring time.
     
     - Parameter date: The Date to compare.
     */

- (BOOL)isEqualToDateIgnoringTime:(NSDate *) date {
    NSDateComponents *comp1 = [NSDate components:(self)];
    NSDateComponents *comp2 = [NSDate components:(date)];
    return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day));
}
    
    /**
     Returns Returns true if date is today.
     */

- (BOOL) isToday {
    return [self isEqualToDateIgnoringTime:([[NSDate alloc]init])];
}

    /**
     Returns true if date is tomorrow.
     */


- (BOOL) isTomorrow {
    return [self isEqualToDateIgnoringTime:([[[NSDate alloc]init] dateByAddingTimeInterval:(60*60*24*1)])];
}
    
    /**
     Returns true if date is yesterday.
     */

- (BOOL) isYesterday {
    return [self isEqualToDateIgnoringTime:([[[NSDate alloc]init] dateByAddingTimeInterval:(60*60*24*-1)])];
}
    
    /**
     Returns true if date are in the same week.
     
     - Parameter date: The date to compare.
     */

- (BOOL) isSameWeekAsDate: (NSDate *) date {
    NSDateComponents *comp1 = [NSDate components:(self)];
    NSDateComponents *comp2 = [NSDate components:(date)];
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (comp1.weekOfYear != comp2.weekOfYear) {
        return false;
    }
    // Must have a time interval under 1 week
    double element1 = [self timeIntervalSinceDate: (date)];
    NSNumber *element = [NSNumber numberWithDouble: element1];
    return abs(element < [NSDate weekInSeconds]);
}
    /**
     Returns true if date is this week.
     */

- (BOOL) isThisWeek {
    return [self isSameWeekAsDate:[[NSDate alloc] init]];
}
    /**
     Returns true if date is next week.
     */

- (BOOL) isNextWeek {
    NSTimeInterval interval = [[NSDate alloc]init].timeIntervalSinceReferenceDate + [NSDate weekInSeconds].doubleValue;
    NSDate * date = [NSDate dateWithTimeIntervalSinceReferenceDate: interval];
    return [self isSameWeekAsDate:(date)];
}
    
    /**
     Returns true if date is last week.
     */

- (BOOL) isLastWeek {
    NSTimeInterval interval = [[NSDate alloc]init].timeIntervalSinceReferenceDate - [NSDate weekInSeconds].doubleValue;
    NSDate * date = [NSDate dateWithTimeIntervalSinceReferenceDate: interval];
    return [self isSameWeekAsDate:(date)];
}
    
    /**
     Returns true if dates are in the same year.
     
     - Parameter date: The date to compare.
     */

- (BOOL) isSameYearAsDate :(NSDate *) date {
    NSDateComponents *comp1 = [NSDate components:(self)];
    NSDateComponents *comp2 = [NSDate components:(date)];
    return (comp1.year == comp2.year);
}

    /**
     Returns true if date is this year.
     */

- (BOOL) isThisYear {
    return [self isSameYearAsDate: ([[NSDate alloc]init])];
}
    
    /**
     Returns true if date is next year.
     */

- (BOOL) isNextYear {
    NSDateComponents *comp1 = [NSDate components:(self)];
    NSDateComponents *comp2 = [NSDate components:([[NSDate alloc]init])];
    return (comp1.year == comp2.year + 1);
}

    /**
     Returns true if date is last year.
     */

- (BOOL) isLastYear {
    NSDateComponents *comp1 = [NSDate components:(self)];
    NSDateComponents *comp2 = [NSDate components:([[NSDate alloc]init])];
    return (comp1.year == comp2.year - 1);
}
    
    /**
     Returns true if date is earlier than date.
     
     - Parameter date: The date to compare.
     */
- (BOOL) isEarlierThanDate: (NSDate *) date {
    return [self earlierDate: date] == self;
}
    
    /**
     Returns true if date is later than date.
     
     - Parameter date: The date to compare.
     */

- (BOOL) isLaterThanDate: (NSDate *) date {
    return [self laterDate:date] == self;
}
    
    /**
     Returns true if date is in future.
     */

- (BOOL) isInFuture {
    return [self isLaterThanDate:[[NSDate alloc]init]];
}
    
    /**
     Returns true if date is in past.
     */

- (BOOL) isInPast {
    return [self isEarlierThanDate:[[NSDate alloc]init]];
}
    
    // MARK: Adjusting Dates
    
    /**
     Creates a new date by a adding days.
     
     - Parameter days: The number of days to add.
     - Returns A new date object.
     */

- (NSDate *) dateByAddingDays : (int) days {
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.day = days;
    return [[NSCalendar currentCalendar]dateByAddingComponents:dateComp toDate:self options: 0];
}
    
    /**
     Creates a new date by a substracting days.
     
     - Parameter days: The number of days to substract.
     - Returns A new date object.
     */

- (NSDate *) dateBySubtractingDays: (int) days {
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.day = (days * -1);
    return [[NSCalendar currentCalendar]dateByAddingComponents:dateComp toDate:self options: 0];
}
    
    /**
     Creates a new date by a adding hours.
     
     - Parameter days: The number of hours to add.
     - Returns A new date object.
     */

- (NSDate *) dateByAddingHours: (int) hours {
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.hour = hours;
    return [[NSCalendar currentCalendar]dateByAddingComponents:dateComp toDate:self options: 0];
}
    
    /**
     Creates a new date by substracting hours.
     
     - Parameter days: The number of hours to substract.
     - Returns A new date object.
     */

- (NSDate *) dateBySubtractingHours: (int) hours {
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.hour = (hours * -1);
    return [[NSCalendar currentCalendar]dateByAddingComponents:dateComp toDate:self options: 0];
}

    /**
     Creates a new date by adding minutes.
     
     - Parameter days: The number of minutes to add.
     - Returns A new date object.
     */

- (NSDate *) dateByAddingMinutes: (int) minutes {
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.minute = minutes;
    return [[NSCalendar currentCalendar]dateByAddingComponents:dateComp toDate:self options: 0];
}
    
    /**
     Creates a new date by substracting minutes.
     
     - Parameter days: The number of minutes to add.
     - Returns A new date object.
     */

- (NSDate *) dateBySubtractingMinutes: (int) minutes {
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.minute = (minutes * -1);
    return [[NSCalendar currentCalendar]dateByAddingComponents:dateComp toDate:self options: 0];
}

    /**
     Creates a new date by adding seconds.
     
     - Parameter seconds: The number of seconds to add.
     - Returns A new date object.
     */

- (NSDate *) dateByAddingSeconds: (int) seconds {
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.second = seconds;
    return [[NSCalendar currentCalendar]dateByAddingComponents:dateComp toDate:self options: 0];
}
    
    /**
     Creates a new date by substracting seconds.
     
     - Parameter days: The number of seconds to substract.
     - Returns A new date object.
     */

- (NSDate *) dateBySubtractingSeconds: (int) seconds {
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.second = (seconds * -1);
    return [[NSCalendar currentCalendar]dateByAddingComponents:dateComp toDate:self options: 0];
}

    /**
     Creates a new date from the start of the day.
     
     - Returns A new date object.
     */

- (NSDate *) dateAtStartOfDay {
    NSDateComponents *components = [self components];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
    
    /**
     Creates a new date from the end of the day.
     
     - Returns A new date object.
     */

- (NSDate *) dateAtEndOfDay {
    NSDateComponents *components = [self components];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
    
    /**
     Creates a new date from the start of the week.
     
     - Returns A new date object.
    
     */



- (NSDate *) dateAtStartOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale currentLocale];
    calendar.timeZone = [NSTimeZone defaultTimeZone];
    calendar.firstWeekday = 2;
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:flags fromDate:self];
    components.weekday = [calendar firstWeekday];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
    
    /**
     Creates a new date from the end of the week.
     
     - Returns A new date object.
     */

- (NSDate *) dateAtEndOfWeek {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale currentLocale];
    calendar.timeZone = [NSTimeZone defaultTimeZone];
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:flags fromDate: now];
    NSUInteger weekdayToday = [components weekday];
    NSInteger daysToSunday = (8 - weekdayToday) % 7;
    NSDate *nextSunday = [now dateByAddingTimeInterval:60*60*24*daysToSunday];
    NSDateComponents *components2 = [calendar components:flags fromDate: nextSunday];
    components2.hour = 23;
    components2.minute = 59;
    components2.second = 59;
    return [[NSCalendar currentCalendar] dateFromComponents:components2];
}
    
    /**
     Creates a new date from the first day of the month
     
     - Returns A new date object.
     */

- (NSDate*) dateAtStartOfMonth {
    NSDateComponents *components = [self components];
    components.day = 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSDate *firstDayOfMonthDate = [[NSCalendar currentCalendar] dateFromComponents: components];
    return firstDayOfMonthDate;
}

    /**
     Creates a new date from the last day of the month
     
     - Returns A new date object.
     */

- (NSDate *) dateAtEndOfMonth {
    NSDateComponents *components = [self components];
    components.month += 1;
    components.day = 0;
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    NSDate *lastDayOfMonthDate = [[NSCalendar currentCalendar] dateFromComponents: components];
    return lastDayOfMonthDate;
}

    /**
     Return a new NSDate object with the new hour, minute and seconds values
 
     :returns: NSDate
     */

- (NSDate *) setTimeOfDateWithHour: (int) hour andMinute: (int) minute andSecond: (int) second {
    NSDateComponents *components = [self components];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    return [[NSCalendar currentCalendar] dateFromComponents: components];
}

    /**
     Creates a new date based on tomorrow.
     
     - Returns A new date object.
     */

+ (NSDate *) tomorrow {
    return [[[[NSDate alloc] init] dateByAddingDays:1]dateAtStartOfDay];
}
    
    /**
     Creates a new date based on yesterdat.
     
     - Returns A new date object.
     */

+ (NSDate *) yesterday {
    return [[[[NSDate alloc] init] dateByAddingDays:-1]dateAtStartOfDay];
}
    
    // MARK: Retrieving Intervals
    
    /**
     Gets the number of seconds after a date.
     
     - Parameter date: the date to compare.
     - Returns The number of seconds
     */

- (int) secondsAfterDate: (NSDate*) date {
    return [self timeIntervalSinceDate:(date)];
}

    
    /**
     Gets the number of seconds before a date.
     
     - Parameter date: The date to compare.
     - Returns The number of seconds
     */

- (int) secondsBeforeDate: (NSDate*) date {
    return [date timeIntervalSinceDate:(self)];
}
    
    /**
     Gets the number of minutes after a date.
     
     - Parameter date: the date to compare.
     - Returns The number of minutes
     */

- (int) minutesAfterDate: (NSDate*) date {
    NSTimeInterval interval = [self timeIntervalSinceDate:(date)];
    return (interval / [NSDate minuteInSeconds].doubleValue);
}
    
    /**
     Gets the number of minutes before a date.
     
     - Parameter date: The date to compare.
     - Returns The number of minutes
     */

- (int) minutesBeforeDate: (NSDate *) date {
    NSTimeInterval interval = [date timeIntervalSinceDate:(self)];
    return (interval / [NSDate minuteInSeconds].doubleValue);
}
    
    /**
     Gets the number of hours after a date.
     
     - Parameter date: The date to compare.
     - Returns The number of hours
     */

- (int) hoursAfterDate : (NSDate *) date {
    NSTimeInterval interval = [self timeIntervalSinceDate:(date)];
    return (interval / [NSDate hourInSeconds].doubleValue);
}

    /**
     Gets the number of hours before a date.
     
     - Parameter date: The date to compare.
     - Returns The number of hours
     */

- (int) hoursBeforeDate : (NSDate *) date {
    NSTimeInterval interval = [date timeIntervalSinceDate:(self)];
    return (interval / [NSDate hourInSeconds].doubleValue);
}
    
    /**
     Gets the number of days after a date.
     
     - Parameter date: The date to compare.
     - Returns The number of days
     */

- (int) daysAfterDate:(NSDate *) date {
    NSTimeInterval interval = [self timeIntervalSinceDate:(date)];
    return (interval / [NSDate dayInSeconds].doubleValue);
}

    /**
     Gets the number of days before a date.
     
     - Parameter date: The date to compare.
     - Returns The number of days
     */

- (int) daysBeforeDate: (NSDate *) date {
    NSTimeInterval interval = [date timeIntervalSinceDate:(self)];
    return (interval / [NSDate dayInSeconds].doubleValue);
}

    // MARK: Decomposing Dates

    /**
     Returns the nearest hour.
     */

- (int) nearestHour {
    NSInteger halfHour = [NSDate minuteInSeconds].intValue * 30;
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate];
    if (interval < halfHour) {
        interval -= halfHour;
    }
    else {
        interval += halfHour;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate: interval];
    return [date hour];
}

    /**
     Returns the year component.
     */

- (int) year {
    return [self components].year;
}

    /**
     Returns the month component.
     */

- (int) month {
    return [self components].month;
}

    /**
     Returns the week of year component.
     */

- (int) week {
    return [self components].weekOfYear;
}

    /**
     Returns the day component.
     */

- (int) day {
    return [self components].day;
}

    /**
     Returns the hour component.
     */

- (int) hour {
    return [self components].hour;
}

    /**
     Returns the minute component.
     */

- (int) minute {
    return [self components].minute;
}

    /**
     Returns the seconds component.
     */

- (int) seconds {
    return [self components].second;
}

    /**
     Returns the weekday component.
     */

- (int) weekday {
    if ([self components].weekday > 1) {
        return [self components].weekday - 1;
    }
    else {
        return [self components].weekday + 1;
    }
}

    /**
     Returns the nth days component. e.g. 2nd Tuesday of the month is 2.
     */

- (int) nthWeekday {
    return [self components].weekdayOrdinal;
}

    /**
     Returns the days of the month.
     */

- (int) monthDays {
    return [[NSCalendar currentCalendar] rangeOfUnit: NSCalendarUnitDay inUnit : NSCalendarUnitMonth forDate: self].length;
}

    /**
     Returns the first day of the week.
     */

- (int) firstDayOfWeek {
    double distanceToStartOfWeek = [NSDate dayInSeconds].doubleValue * ([self components].weekday - 2);
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] - distanceToStartOfWeek;
    return [[NSDate dateWithTimeIntervalSinceReferenceDate: interval] day];
}

    /**
     Returns the last day of the week.
     */

- (int) lastDayOfWeek {
    double distanceToStartOfWeek = [NSDate dayInSeconds].doubleValue * ([self components].weekday - 1);
    double distanceToEndOfWeek = [NSDate dayInSeconds].doubleValue * 7.0;
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] - distanceToStartOfWeek + distanceToEndOfWeek;
    return [[NSDate dateWithTimeIntervalSinceReferenceDate: interval] day];
}

    /**
     Returns true if a weekday.
     */

- (BOOL) isWeekday {
    return ![self isWeekend];
}

    /**
     Returns true if weekend.
     */

- (BOOL) isWeekend {
    NSRange range = [[NSCalendar currentCalendar] maximumRangeOfUnit: NSCalendarUnitWeekday];
    return [self weekday] == range.location || [self weekday] == range.length;
}
    
    // MARK: To String
    
    /**
     A string representation using short date and time style.
     */

- (NSString *) toString {
    return [self toStringWithDateStyle: NSDateFormatterShortStyle andTimeStyle : NSDateFormatterShortStyle andRelativeTime: false];
}

    /**
     A string representation based on a format.
     
     - Parameter format: The format of date can be .ISO8601(.ISO8601Format?), .DotNet, .RSS, .AltRSS or Custom(FormatString).
     - Returns The date string representation
     */


- (NSString *)toStringWithFormat:(DateFormat *)format {
    TimeZone timeZone;
    timeZone = kTimeZoneLocal;
    NSString *dateFormat;
    NSTimeZone *zone;
    if([format.dateFormatType compare: DotNetDateFormatType] == NSOrderedSame) {
        int offset = [[NSTimeZone defaultTimeZone] secondsFromGMT] / 3600;
        double nowMillis = 1000 * [self timeIntervalSince1970];
        return [NSString stringWithFormat:@"/Date(%f%d)/", nowMillis, offset];
    }
    else if([format.dateFormatType compare: ISO8601DateFormatType] == NSOrderedSame) {
        NSString *isoFormat = format.formatDetails;
        dateFormat =  (isoFormat != nil) ? isoFormat : ISOFormatDateTimeMilliSec;
        zone = [NSTimeZone localTimeZone];
    }
    else if([format.dateFormatType compare: RSSDateFormatType] == NSOrderedSame) {
        dateFormat = RSSDateFormatType;
        zone = [NSTimeZone localTimeZone];
    }
    else if([format.dateFormatType compare: AltRSSDateFormatType] == NSOrderedSame) {
        dateFormat = AltRSSDateFormatType;
        zone = [NSTimeZone localTimeZone];
    }
    else if([format.dateFormatType compare: CustomDateFormatType] == NSOrderedSame) {
        NSString *string = format.formatDetails;
//        switch (timeZone) {
//            case kTimeZoneLocal:
//                zone = [NSTimeZone localTimeZone];
//            case kTimeZoneUTC:
//                zone = [NSTimeZone timeZoneForSecondsFromGMT: 3600*2];
//            }
        zone = [NSTimeZone localTimeZone];
        dateFormat = string;
    }
    NSDateFormatter *formatter = [NSDate formatterWithFormat : dateFormat andTimeZone: zone andLocale: [NSLocale currentLocale]];
    return [formatter stringFromDate:(self)];
}
    
    /**
     A string representation based on custom style.
     
     - Parameter dateStyle: The date style to use.
     - Parameter timeStyle: The time style to use.
     - Parameter doesRelativeDateFormatting: Enables relative date formatting.
     - Returns A string representation of the date.
     
     */

- (NSString *) toStringWithDateStyle: (NSDateFormatterStyle) dateStyle andTimeStyle: (NSDateFormatterStyle) timeStyle andRelativeTime : (BOOL) doesRelativeDateFormatting {
    NSDateFormatter *formatter = [NSDate formatterWithDateStyle: dateStyle andTimeStyle:timeStyle andRelativeTime: doesRelativeDateFormatting andTimeZone:[NSTimeZone localTimeZone] andLocale: [NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

    /**
     A string representation based on a relative time language. i.e. just now, 1 minute ago etc..
     */

- (NSString *) relativeTimeToString {
    NSInteger time = self.timeIntervalSince1970;
    NSInteger now = [[NSDate alloc]init].timeIntervalSince1970;
    
    NSInteger seconds = now - time;
    NSInteger minutes = round(seconds/60);
    NSInteger hours = round(minutes/60);
    NSInteger days = round(hours/24);
    
    if (seconds < 10) {
        return NSLocalizedString(@"just now", comment: @"Show the relative time from a date");
    }
    else if (seconds < 60) {
        NSString *relativeTime = NSLocalizedString(@"%.f seconds ago", comment: @"Show the relative time from a date");
        return [NSString stringWithFormat:@"%@%ld", relativeTime, (long)seconds];
    }
    
    if (hours < 24) {
        if (hours == 1){
            return NSLocalizedString(@"1 hour ago", comment: @"Show the relative time from a date");
        }
        else {
            NSString *relativeTime = NSLocalizedString(@"%.f hours ago", comment: @"Show the relative time from a date");
            return [NSString stringWithFormat:@"%@%ld", relativeTime, (long)hours];
        }
    }
    
    if (days < 7) {
        if (days == 1) {
            return NSLocalizedString(@"1 day ago", comment: @"Show the relative time from a date");
        }
        else {
            NSString *relativeTime = NSLocalizedString(@"%.f days ago", comment: @"Show the relative time from a date");
            return [NSString stringWithFormat:@"%@%ld", relativeTime, (long)days];

        }
    }
    return [self toString];
}
    
    /**
     A string representation of the weekday.
     */

- (NSString *) weekdayToString {
    NSDateFormatter *formatter = [NSDate formatterWithFormat: DefaultFormat andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
    NSString *result = formatter.weekdaySymbols[[self weekday]];
    return result;
}
    
    /**
     A short string representation of the weekday.
     */

- (NSString *) shortWeekdayToString {
    NSDateFormatter *formatter = [NSDate formatterWithFormat: DefaultFormat andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
    NSString *result = formatter.shortWeekdaySymbols[[self weekday]];
    return result;
}
    
    /**
     A very short string representation of the weekday.
     
     - Returns String
     */

- (NSString *) veryShortWeekdayToString {
    NSDateFormatter *formatter = [NSDate formatterWithFormat: DefaultFormat andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
    NSString *result = formatter.veryShortWeekdaySymbols[[self weekday]];
    return result;
}
    
    /**
     A string representation of the month.
     
     - Returns String
     */

- (NSString *) monthToString {
    NSDateFormatter *formatter = [NSDate formatterWithFormat: DefaultFormat andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
    NSString *result = formatter.monthSymbols[[self month] -1];
    return result;
}
    
    /**
     A short string representation of the month.
     
     - Returns String
     */

- (NSString *) shortMonthToString {
    NSDateFormatter *formatter = [NSDate formatterWithFormat: DefaultFormat andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
    NSString *result = formatter.shortMonthSymbols[[self month] -1];
    return result;
}

    /**
     A very short string representation of the month.
     
     - Returns String
     */

- (NSString *) veryShortMonthToString {
    NSDateFormatter *formatter = [NSDate formatterWithFormat: DefaultFormat andTimeZone: [NSTimeZone localTimeZone ] andLocale: [NSLocale currentLocale]];
    NSString *result = formatter.veryShortMonthSymbols[[self month] -1];
    return result;
}
    
    // MARK: Static Cached Formatters
    
    /**
     Returns a cached static array of NSDateFormatters so that thy are only created once.
     */

+ (NSMutableDictionary<NSString *, NSDateFormatter *>*)sharedDateFormatters {
    static NSMutableDictionary *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = [NSMutableDictionary new];
    });
    return dict;
}
    
    /**
     Returns a cached formatter based on the format, timeZone and locale. Formatters are cached in a singleton array using hashkeys generated by format, timeZone and locale.
     
     - Parameter format: The format to use.
     - Parameter timeZone: The time zone to use, defaults to the local time zone.
     - Parameter locale: The locale to use, defaults to the current locale
     - Returns The date formatter.
     */

+ (NSDateFormatter *) formatterWithFormat : (NSString *) format andTimeZone : (NSTimeZone*) timeZone  andLocale : (NSLocale *) locale {
    NSString *hashKey = [NSString stringWithFormat:@"%lu%lu%lu", (unsigned long)format.hash, (unsigned long)timeZone.hash, (unsigned long)locale.hash];
    NSMutableDictionary *formatters = [NSDate sharedDateFormatters];
    NSDateFormatter *cachedDateFormatter = formatters[hashKey];
    if (cachedDateFormatter != nil) {
        return cachedDateFormatter;
    }
    else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = format;
        formatter.timeZone = timeZone;
        formatter.locale = locale;
        formatters[hashKey] = formatter;
        return formatter;
    }
}
    
    /**
     Returns a cached formatter based on date style, time style and relative date. Formatters are cached in a singleton array using hashkeys generated by date style, time style, relative date, timeZone and locale.
     
     - Parameter dateStyle: The date style to use.
     - Parameter timeStyle: The time style to use.
     - Parameter doesRelativeDateFormatting: Enables relative date formatting.
     - Parameter timeZone: The time zone to use.
     - Parameter locale: The locale to use.
     - Returns The date formatter.
     */

+ (NSDateFormatter *)formatterWithDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle andRelativeTime:(BOOL)doesRelativeDateFormatting andTimeZone:(NSTimeZone *)timeZone andLocale:(NSLocale *)locale {
    NSString *hashKey = [NSString stringWithFormat:@"%lu%lu%lu%lu%lu", (unsigned long)dateStyle, (unsigned long)timeStyle, (unsigned long)doesRelativeDateFormatting, (unsigned long)timeZone.hash, (unsigned long)locale.hash];
    NSMutableDictionary *formatters = [NSDate sharedDateFormatters];
    NSDateFormatter *cachedDateFormatter = formatters[hashKey];
    if (cachedDateFormatter != nil) {
        return cachedDateFormatter;
    }
    else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateStyle = dateStyle;
        formatter.timeStyle = timeStyle;
        formatter.doesRelativeDateFormatting = doesRelativeDateFormatting;
        formatter.timeZone = timeZone;
        formatter.locale = locale;
        formatters[hashKey] = formatter;
        return formatter;
    }
}


@end
