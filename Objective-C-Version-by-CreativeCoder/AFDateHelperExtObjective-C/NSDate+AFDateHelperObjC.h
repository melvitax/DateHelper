//
//  NSDate+AFDateHelperObjC.h
//  AFDateHelperExtObjective-C
//
//  Created by Tassilo Lechner von Leheneck on 01/04/16.
//  Copyright © 2016 Tassilo Lechner von Leheneck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateFormat.h"

typedef NS_ENUM(NSInteger, TimeZone) {
    kTimeZoneLocal = 0,
    kTimeZoneUTC
};

@interface NSDate (AFDateHelperObjC)

@property (nonatomic) TimeZone timezone;

//MARK : private funcs

//+ (NSNumber *) minuteInSeconds;
//+ (NSNumber *) hourInSeconds;
//+ (NSNumber *) dayInSeconds;
//+ (NSNumber *) weekInSeconds;
//+ (NSNumber *) yearInSeconds;

//+ (NSDateComponents *) components: (NSDate *) fromDate;
//+ (NSCalendarUnit) componentFlags;
//+ (NSDateComponents *) components: (NSDate *) fromDate;
//- (NSDateComponents *) components;
//
//+ (NSMutableDictionary<NSString *, NSDateFormatter *>*)sharedDateFormatters;
//+ (NSDateFormatter *)formatter : (NSString *) format  : (NSTimeZone*) timeZone  : (NSLocale *) locale;
//+ (NSDateFormatter *)formatter:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle relativeDateFormatting:(BOOL)doesRelativeDateFormatting timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;

- (instancetype) initFromString: (NSString *) string withFormat: (DateFormat *) format;

- (BOOL)isEqualToDateIgnoringTime:(NSDate *) date;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) date;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate :(NSDate *) date;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) date;
- (BOOL) isLaterThanDate: (NSDate *) date;
- (BOOL) isInFuture;
- (BOOL) isInPast;

- (NSDate *) dateByAddingDays : (int) days;
- (NSDate *) dateBySubtractingDays: (int) days;
- (NSDate *) dateByAddingHours: (int) hours;
- (NSDate *) dateBySubtractingHours: (int) hours;
- (NSDate *) dateByAddingMinutes: (int) minutes;
- (NSDate *) dateBySubtractingMinutes: (int) minutes;
- (NSDate *) dateByAddingSeconds: (int) seconds;
- (NSDate *) dateBySubtractingSeconds: (int) seconds;

- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;
- (NSDate *) dateAtStartOfWeek;
- (NSDate *) dateAtEndOfWeek;
- (NSDate*) dateAtStartOfMonth;
- (NSDate *) dateAtEndOfMonth;
- (NSDate *) setTimeOfDateWithHour: (int) hour andMinute: (int) minute andSecond: (int) second;
+ (NSDate *) tomorrow;
+ (NSDate *) yesterday;

- (int) secondsAfterDate: (NSDate*) date;
- (int) secondsBeforeDate: (NSDate*) date;
- (int) minutesAfterDate: (NSDate*) date;
- (int) minutesBeforeDate: (NSDate *) date;
- (int) hoursAfterDate : (NSDate *) date;
- (int) hoursBeforeDate : (NSDate *) date;
- (int) daysAfterDate:(NSDate *) date;
- (int) daysBeforeDate: (NSDate *) date;

- (int) nearestHour;
- (int) year;
- (int) month;
- (int) week;
- (int) day;
- (int) hour;
- (int) minute;
- (int) seconds;
- (int) weekday;
- (int) nthWeekday;
- (int) monthDays;
- (int) firstDayOfWeek;
- (int) lastDayOfWeek;

- (BOOL) isWeekday;
- (BOOL) isWeekend;

- (NSString *) toString;
- (NSString *) toStringWithFormat:(DateFormat *)format;
- (NSString *) toStringWithDateStyle: (NSDateFormatterStyle) dateStyle andTimeStyle: (NSDateFormatterStyle) timeStyle andRelativeTime: (BOOL) doesRelativeDateFormatting;
- (NSString *) relativeTimeToString;
- (NSString *) weekdayToString;
- (NSString *) shortWeekdayToString;
- (NSString *) veryShortWeekdayToString;
- (NSString *) monthToString;
- (NSString *) shortMonthToString;
- (NSString *) veryShortMonthToString;


@end
