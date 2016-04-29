//
//  ViewController.m
//  AFDateHelperExtObjective-C
//
//  Created by Tassilo Lechner von Leheneck on 01/04/16.
//  Copyright © 2016 Tassilo Lechner von Leheneck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) NSMutableArray<NSString *> *sections;
@property (strong,nonatomic) NSMutableArray<NSMutableArray<TableItem *> *> *items;
@property (strong,nonatomic) NSMutableArray<TableItem *> *sectionItems;

@end



@implementation ViewController: UITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *now = [[NSDate alloc] init];
    NSDate *date = [[NSDate alloc] init];
    
    self.sections =  [[NSMutableArray<NSString *> alloc]init];
    self.items = [[NSMutableArray<NSMutableArray<TableItem *> *> alloc]init];
    self.sectionItems = [[NSMutableArray<TableItem *> alloc]init];
    

    
    
        // MARK: **** DATE FROM STRING ******************************************************

    [_sections addObject:@"Date From String"];
    
    
        
        // MARK: Date from string with custom format
    
    date = [[NSDate alloc] initFromString: @"16 July 1972 6:12:00" withFormat: [DateFormat CustomDateFormat: @"dd MMM yyyy HH:mm:ss"]];
    TableItem *anItem = [[TableItem alloc ]initWithTitle: @"Custom Format" theDescription:[NSString stringWithFormat:@"dd MMM yyyy HH:mm:ss = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
    
        // MARK: Date from ISO8601(Year) String
    
    date = [[NSDate alloc] initFromString: @"2009" withFormat: [DateFormat ISODateFormat: ISOFormatYear]];
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Year)" theDescription: [NSString stringWithFormat:@"2009 = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
    
    
        
        // MARK: Date from ISO8601(Year & Month) String
    
    date = [[NSDate alloc] initFromString: @"2009-08" withFormat: [DateFormat ISODateFormat: ISOFormatYearMonth]];
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Year & Month)" theDescription: [NSString stringWithFormat:@"2009-08 = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
    
        
        // MARK: Date from ISO8601(Date) String
    
    date = [[NSDate alloc] initFromString: @"2009-08-11" withFormat: [DateFormat ISODateFormat: ISOFormatDate]];
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Date)" theDescription: [NSString stringWithFormat:@"2009-08-11 = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
        
        // MARK: Date from ISO8601(Date & Time) String
    
    date = [[NSDate alloc] initFromString: @"2009-08-11T06:00-07:00" withFormat: [DateFormat ISODateFormat: ISOFormatDateTime]];
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Date & Time)" theDescription: [NSString stringWithFormat:@"2009-08-11T06:00-07:00 = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
        
        // MARK: Date from ISO8601(Date & Time & Sec) String
    
    date = [[NSDate alloc] initFromString: @"2009-08-11T06:00:00-07:00" withFormat: [DateFormat ISODateFormat: ISOFormatDateTimeSec]];
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Date & Time & Sec)" theDescription: [NSString stringWithFormat:@"2009-08-11T06:00:00-07:00 = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
        
        // MARK: Date from ISO8601(Date & Time & MilliSec) String
    
    date = [[NSDate alloc] initFromString: @"2009-08-11T06:00:00.000-07:00" withFormat: [DateFormat ISODateFormat: ISOFormatDateTimeMilliSec]];
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Date & Time & MilliSec)" theDescription: [NSString stringWithFormat:@"2009-08-11T06:00:00.000-07:00 = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
        
        // MARK: Date from DotNetJSON String
    
    date = [[NSDate alloc] initFromString: @"/Date(1260123281843)/" withFormat: [DateFormat DotNetDateFormat]];
    anItem = [[TableItem alloc ]initWithTitle: @"DotNetJSON" theDescription: [NSString stringWithFormat:@"Date(1260123281843) = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];

        // MARK: Date from RSS String
    
    date = [[NSDate alloc] initFromString: @"Fri, 09 Sep 2011 15:26:08 +0200" withFormat: [DateFormat RSSDateFormat]];
    anItem = [[TableItem alloc ]initWithTitle: @"RSS" theDescription: [NSString stringWithFormat:@"Fri, 09 Sep 2011 15:26:08 +0200 = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
        
        // MARK: Date from AltRSS String
    
    date = [[NSDate alloc] initFromString: @"09 Sep 2011 15:26:08 +0200" withFormat: [DateFormat AltRSSDateFormat]];
    anItem = [[TableItem alloc ]initWithTitle: @"Alt RSS" theDescription: [NSString stringWithFormat:@"09 Sep 2011 15:26:08 +0200 = %@", [date toString]]];
    [_sectionItems addObject:(anItem)];
        
    [_items addObject: _sectionItems];
    
    
    
    
        // MARK: **** CREATING DATES ******************************************************
    
    [_sections addObject:(@"Creating Dates")];
    _sectionItems = [[NSMutableArray<TableItem *> alloc]init];
    
    
    
    
    anItem = [[TableItem alloc ]initWithTitle: @"Tomorrow" theDescription: [NSString stringWithFormat:@"%@", [NSDate tomorrow]]];
    [_sectionItems addObject: anItem];
    
    anItem = [[TableItem alloc ]initWithTitle: @"Yesterday" theDescription: [NSString stringWithFormat:@"%@", [NSDate yesterday]]];
    [_sectionItems addObject: anItem];
    
     [_items addObject:(_sectionItems)];
    
    
    
    
        // MARK: **** COMPARING DATES ******************************************************
    
    [_sections addObject: @"Comparing Dates"];
    _sectionItems = [[NSMutableArray<TableItem *> alloc]init];
    
    
    
    
        // MARK: isEqual
    NSString *equality = [NSString stringWithFormat: @"%s", [now isEqualToDateIgnoringTime: date ] ? "is equal to" : "is not equal to"];
    anItem = [[TableItem alloc ]initWithTitle: @"Is Equal To Date Ignoring Time" theDescription: [NSString stringWithFormat:@"%@ %@ %@", [now toString], equality, [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: isToday
    
    equality = [NSString stringWithFormat: @"%s", [now isToday] ? "is today" : "is not today"];
    anItem = [[TableItem alloc ]initWithTitle: @"Today" theDescription: [NSString stringWithFormat:@"%@ %@", [now toString], equality]];
    [_sectionItems addObject: anItem];
    
        // MARK: isTomorrow
    
    date = [now dateByAddingDays: 1];
    equality = [NSString stringWithFormat: @"%s", [date isTomorrow] ? "is tomorrow" : "is not tomorrow"];
    anItem = [[TableItem alloc ]initWithTitle: @"Tomorrow" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
    
        
        // MARK: isYesterday
    
    date = [now dateBySubtractingDays: 1];
    equality = [NSString stringWithFormat: @"%s", [date isYesterday] ? "is yesterday" : "is not yesterday"];
    anItem = [[TableItem alloc ]initWithTitle: @"Yesterday" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];

        // MARK: isSameWeekAsDate
    
    equality = [NSString stringWithFormat: @"%s", [now isSameWeekAsDate: date] ? "is same week as" : "is not same week as"];
    anItem = [[TableItem alloc ]initWithTitle: @"Same Week" theDescription: [NSString stringWithFormat:@"%@ %@ %@", [date toString], equality, [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: isThisWeek
    
    equality = [NSString stringWithFormat: @"%s", [date isThisWeek] ? "is this week" : "is not this week"];
    anItem = [[TableItem alloc ]initWithTitle: @"This Week" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
        
        // MARK: isNextWeek
    
    date = [now dateByAddingDays: 7];
    equality = [NSString stringWithFormat: @"%s", [date isNextWeek] ? "is next week" : "is not next week"];
    anItem = [[TableItem alloc ]initWithTitle: @"Next Week" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
        
        // MARK: isLastWeek
    
    date = [now dateBySubtractingDays: 7];
    equality = [NSString stringWithFormat: @"%s", [date isLastWeek] ? "is last week" : "is not last week"];
    anItem = [[TableItem alloc ]initWithTitle: @"Last Week" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
    
        // MARK: isSameYearAsDate
    
    equality = [NSString stringWithFormat: @"%s", [now isSameYearAsDate: date] ? "is same year as" : "is not same year as"];
    anItem = [[TableItem alloc ]initWithTitle: @"Same Year" theDescription: [NSString stringWithFormat:@"%@ %@ %@", [date toString], equality, [date toString]]];
    [_sectionItems addObject: anItem];
    
        // MARK: dateByAddingDays
    
    date = [now dateByAddingDays: 365];
    equality = [NSString stringWithFormat: @"%s", [date isNextYear] ? "is next year" : "is not next year"];
    anItem = [[TableItem alloc ]initWithTitle: @"Next Year" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateBySubstractingDays
    
    date = [now dateBySubtractingDays: 365];
    equality = [NSString stringWithFormat: @"%s", [date isLastYear] ? "is last year" : "is not last year"];
    anItem = [[TableItem alloc ]initWithTitle: @"Last Year" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
        
        // MARK: isEarlierThanDate
    
    equality = [NSString stringWithFormat: @"%s", [date isEarlierThanDate: now] ? "is earlier than now" : "is not earlier than now"];
    anItem = [[TableItem alloc ]initWithTitle: @"Earlier Than" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
        
        // MARK: isLaterThanDate
    
    equality = [NSString stringWithFormat: @"%s", [date isLaterThanDate: now] ? "is later than now" : "is not later than now"];
    anItem = [[TableItem alloc ]initWithTitle: @"Later Than" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
    
        
        // MARK: isInFuture
    
    date = [now dateByAddingDays: 1];
    equality = [NSString stringWithFormat: @"%s", [date isInFuture] ? "is in future" : "is not the future"];
    anItem = [[TableItem alloc ]initWithTitle: @"Future" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];

        // MARK: isInPast
    
    date = [now dateBySubtractingDays: 1];
    equality = [NSString stringWithFormat: @"%s", [date isInPast] ? "is in the past" : "is not the past"];
    anItem = [[TableItem alloc ]initWithTitle: @"Past" theDescription: [NSString stringWithFormat:@"%@ %@", [date toString], equality]];
    [_sectionItems addObject: anItem];
    
    [_items addObject:(_sectionItems)];
    
    
    
        
        // MARK: **** ADJUSTING DATES ******************************************************
    
    [_sections addObject:(@"Adjusting Dates")];
    _sectionItems = [[NSMutableArray<TableItem *> alloc]init];
    
    
    
        
        // MARK: dateByAddingDays
    
    date = [now dateByAddingDays: 2];
    anItem = [[TableItem alloc ]initWithTitle: @"Adding Days" theDescription: [NSString stringWithFormat:@"+ 2 Days: %@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateBySubstractingDays
    
    date = [now dateBySubtractingDays: 4];
    anItem = [[TableItem alloc ]initWithTitle: @"Subtracing Days" theDescription: [NSString stringWithFormat:@"- 4 Days: %@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateByAddingHours
    
    date = [now dateByAddingHours: 2];
    anItem = [[TableItem alloc ]initWithTitle: @"Adding Hours" theDescription: [NSString stringWithFormat:@"+ 2 Hours: %@", [date toString]]];
    [_sectionItems addObject: anItem];
    
        
        // MARK: dateBySubstractingHours
    
    date = [now dateBySubtractingHours: 4];
    anItem = [[TableItem alloc ]initWithTitle: @"Substracting Hours" theDescription: [NSString stringWithFormat:@"- 4 Hours: %@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateByAddingMinutes
    
    date = [now dateByAddingMinutes: 2];
    anItem = [[TableItem alloc ]initWithTitle: @"Adding Minutes" theDescription: [NSString stringWithFormat:@"+ 2 Minutes: %@", [date toString]]];
    [_sectionItems addObject: anItem];
    
        // MARK: dateBySubstractingMinutes
    
    date = [now dateBySubtractingMinutes: 4];
    anItem = [[TableItem alloc ]initWithTitle: @"Substracting Minutes" theDescription: [NSString stringWithFormat:@"- 4 Minutes: %@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateByAddingSeconds
    
    date = [now dateByAddingSeconds: 90];
    anItem = [[TableItem alloc ]initWithTitle: @"Adding Seconds" theDescription: [NSString stringWithFormat:@"+ 90 Seconds: %@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateBySubstractingSeconds
    
    date = [now dateBySubtractingSeconds: 90];
    anItem = [[TableItem alloc ]initWithTitle: @"Subtracting Seconds" theDescription: [NSString stringWithFormat:@"- 90 Seconds: %@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateAtStartOfDay
    
    date = [now dateAtStartOfDay];
    anItem = [[TableItem alloc ]initWithTitle: @"Start of Day" theDescription: [NSString stringWithFormat:@"%@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateAtEndOfDay
    
    date = [now dateAtEndOfDay];
    anItem = [[TableItem alloc ]initWithTitle: @"End of Day" theDescription: [NSString stringWithFormat:@"%@", [date toString]]];
    [_sectionItems addObject: anItem];

        
        // MARK: sateAtStartOfWeek
    
    date = [now dateAtStartOfWeek];
    anItem = [[TableItem alloc ]initWithTitle: @"Start of Week" theDescription: [NSString stringWithFormat:@"%@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateAtEndOfWeek
    
    date = [now dateAtEndOfWeek];
    anItem = [[TableItem alloc ]initWithTitle: @"End of Week" theDescription: [NSString stringWithFormat:@"%@", [date toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: dateAtStartOfMonth
    
    date = [now dateAtStartOfMonth];
    anItem = [[TableItem alloc ]initWithTitle: @"Start of Month" theDescription: [NSString stringWithFormat:@"%@", [date toString]]];
    [_sectionItems addObject: anItem];

        // MARK: dateAtEndOfMonth
    
    date = [now dateAtEndOfMonth];
    anItem = [[TableItem alloc ]initWithTitle: @"End of Month" theDescription: [NSString stringWithFormat:@"%@", [date toString]]];
    [_sectionItems addObject: anItem];
    
    // MARK: setTimeOfDate

    date = [now setTimeOfDateWithHour: 6 andMinute: 30 andSecond: 15];
    anItem = [[TableItem alloc ]initWithTitle: @"Set Time of Date" theDescription: [NSString stringWithFormat:@"%@", [date toString]]];
    [_sectionItems addObject: anItem];
    
    
    [_items addObject:(_sectionItems)];
    
    
    
    
        
        // MARK: **** TIME INTERVAL BETWEEN DATES ******************************************************
    
    [_sections addObject:(@"Time Intervals")];
    _sectionItems = [[NSMutableArray<TableItem *> alloc]init];
    
    
    
        // MARK: secondsAfterDate
    
    int num = [date secondsAfterDate: now];
    anItem = [[TableItem alloc ]initWithTitle: @"Seconds After" theDescription: [NSString stringWithFormat:@"Interval from %@: %d", [date toString], num]];
    [_sectionItems addObject: anItem];
        
        // MARK: secondsBeforeDate
    
    num = [date secondsBeforeDate: now];
    anItem = [[TableItem alloc ]initWithTitle: @"Seconds Before" theDescription: [NSString stringWithFormat:@"Interval from %@: %d", [date toString], num]];
    [_sectionItems addObject: anItem];
        
        // MARK: minutesAfterDate
    
    num = [date minutesAfterDate: now];
    anItem = [[TableItem alloc ]initWithTitle: @"Minutes After" theDescription: [NSString stringWithFormat:@"Interval from %@: %d", [date toString], num]];
    [_sectionItems addObject: anItem];
        
        // MARK: minutesBeforeDate
    
    num = [date minutesBeforeDate: now];
    anItem = [[TableItem alloc ]initWithTitle: @"Minutes Before" theDescription: [NSString stringWithFormat:@"Interval from %@: %d", [date toString], num]];
    [_sectionItems addObject: anItem];
        
        // MARK: hoursAfterDate
    
    num = [date hoursAfterDate: now];
    anItem = [[TableItem alloc ]initWithTitle: @"Hours After" theDescription: [NSString stringWithFormat:@"Interval from %@: %d", [date toString], num]];
    [_sectionItems addObject: anItem];
        
        // MARK: hoursBeforeDate
    
    num = [date hoursBeforeDate: now];
    anItem = [[TableItem alloc ]initWithTitle: @"Hours Before" theDescription: [NSString stringWithFormat:@"Interval from %@: %d", [date toString], num]];
    [_sectionItems addObject: anItem];
        
        // MARK: daysAfterDate
    
    num = [date daysAfterDate: now];
    anItem = [[TableItem alloc ]initWithTitle: @"Days After" theDescription: [NSString stringWithFormat:@"Interval from %@: %d", [date toString], num]];
    [_sectionItems addObject: anItem];
    
        // MARK: daysBeforeDate
    
    num = [date daysBeforeDate: now];
    anItem = [[TableItem alloc ]initWithTitle: @"Days Before" theDescription: [NSString stringWithFormat:@"Interval from %@: %d", [date toString], num]];
    [_sectionItems addObject: anItem];
    
    [_items addObject:(_sectionItems)];
    
    
    
        
        // MARK: **** DECOMPOSING DATES ******************************************************
    
    [_sections addObject:(@"Decomposing Dates")];
    _sectionItems = [[NSMutableArray<TableItem *> alloc]init];
    
    
    
        // MARK: Nearest Hour
    
    anItem = [[TableItem alloc ]initWithTitle: @"Nearest Hour" theDescription: [NSString stringWithFormat:@"%d ", [now nearestHour]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Year
    
    anItem = [[TableItem alloc ]initWithTitle: @"Year" theDescription: [NSString stringWithFormat:@"%d", [now year]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Month
    
    anItem = [[TableItem alloc ]initWithTitle: @"Month" theDescription: [NSString stringWithFormat:@"%d", [now month]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Week
    
    anItem = [[TableItem alloc ]initWithTitle: @"Week" theDescription: [NSString stringWithFormat:@"%d", [now week]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Day
    
    anItem = [[TableItem alloc ]initWithTitle: @"Day" theDescription: [NSString stringWithFormat:@"%d", [now day]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Hour
    
    anItem = [[TableItem alloc ]initWithTitle: @"Hour" theDescription: [NSString stringWithFormat:@"%d", [now hour]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Minute
    
    anItem = [[TableItem alloc ]initWithTitle: @"Minute" theDescription: [NSString stringWithFormat:@"%d", [now minute]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Seconds
    
    anItem = [[TableItem alloc ]initWithTitle: @"Seconds" theDescription: [NSString stringWithFormat:@"%d", [now seconds]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Weekday
    
    anItem = [[TableItem alloc ]initWithTitle: @"Weekday" theDescription: [NSString stringWithFormat:@"%d", [now weekday]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Nth Weekday
    
    anItem = [[TableItem alloc ]initWithTitle: @"Nth Weekday" theDescription: [NSString stringWithFormat:@"%d", [now nthWeekday]]];
    [_sectionItems addObject: anItem];

        // MARK: Month Days
    
    anItem = [[TableItem alloc ]initWithTitle: @"Month Days" theDescription: [NSString stringWithFormat:@"%d", [now monthDays]]];
    [_sectionItems addObject: anItem];
    
        // MARK: First Day Of Week
    
    anItem = [[TableItem alloc ]initWithTitle: @"First Day Of Week" theDescription: [NSString stringWithFormat:@"%d", [now firstDayOfWeek]]];
    [_sectionItems addObject: anItem];

        // MARK: Last Day Of Week
    
    anItem = [[TableItem alloc ]initWithTitle: @"Last Day of Week" theDescription: [NSString stringWithFormat:@"%d", [now lastDayOfWeek]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Is Weekday
    
    anItem = [[TableItem alloc ]initWithTitle: @"Is Weekday" theDescription: [NSString stringWithFormat:@" %s",[now isWeekday]? "true" : "false"]];
    [_sectionItems addObject: anItem];
    
        // MARK: Is Weekend
    
    anItem = [[TableItem alloc ]initWithTitle: @"Is Weekend" theDescription: [NSString stringWithFormat:@" %s",[now isWeekend]? "true" : "false"]];
    [_sectionItems addObject: anItem];
    
    [_items addObject:(_sectionItems)];
    
    
    
    
    
        // MARK: **** DATE TO STRING ******************************************************
    
    [_sections addObject:@"Date To String"];
    _sectionItems = [[NSMutableArray<TableItem *> alloc]init];
    
    
        
        // MARK: toString
    
    anItem = [[TableItem alloc ]initWithTitle: @"toString()" theDescription: [NSString stringWithFormat:@"%@", [now toString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString Custom Format
    
    anItem = [[TableItem alloc ]initWithTitle: @"Custom: dd MMM yyyy HH:mm:ss" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat CustomDateFormat:@"dd MMM yyyy HH:mm:ss"]]]];
    [_sectionItems addObject: anItem];

    
        // MARK: toString ISO8601(Year)
    
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Year)" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat ISODateFormat: ISOFormatYear]]]];
    [_sectionItems addObject: anItem];
    
        // MARK: toString ISO8601(Year & Month)
    
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Year & Month)" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat ISODateFormat: ISOFormatYearMonth]]]];
    [_sectionItems addObject: anItem];
    
        // MARK: toString ISO8601(Date)
    
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Date)" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat ISODateFormat: ISOFormatDate]]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString ISO8601(Date & Time)
    
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Date & Time)" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat ISODateFormat: ISOFormatDateTime]]]];
    [_sectionItems addObject: anItem];
    
        // MARK: toString ISO8601(Date & Time & Sec)
    
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Year & Time & Sec)" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat ISODateFormat: ISOFormatDateTimeSec]]]];
    [_sectionItems addObject: anItem];
    
        // MARK: toString ISO8601(Date & Time & MilliSec)
    
    anItem = [[TableItem alloc ]initWithTitle: @"ISO8601(Year & Time & MilliSec)" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat ISODateFormat: ISOFormatDateTimeMilliSec]]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString DotNet JSON
    
    anItem = [[TableItem alloc ]initWithTitle: @"DotNet JSON" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat DotNetDateFormat] ]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString RSS
    
    anItem = [[TableItem alloc ]initWithTitle: @"RSS" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat RSSDateFormat]]]];
    [_sectionItems addObject: anItem];
    
        // MARK: toString AltRSS
    
    anItem = [[TableItem alloc ]initWithTitle: @"AltRSS" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithFormat: [DateFormat AltRSSDateFormat]]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString Short Date, No Time, Relative
    
    anItem = [[TableItem alloc ]initWithTitle: @"Short Date, No Time, Relative" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithDateStyle : NSDateFormatterShortStyle andTimeStyle: NSDateFormatterNoStyle andRelativeTime: true]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString Short Date, Short Time, Not Relative
    
    anItem = [[TableItem alloc ]initWithTitle: @"Short Date, Short Time, Not Relative" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithDateStyle : NSDateFormatterShortStyle andTimeStyle: NSDateFormatterShortStyle andRelativeTime: false]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString Medium Date, Medium Time, Not Relative
    
    anItem = [[TableItem alloc ]initWithTitle: @"Medium Date, Medium Time, Not Relative" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithDateStyle : NSDateFormatterMediumStyle andTimeStyle: NSDateFormatterMediumStyle andRelativeTime: false]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString Long Date, Long Time, Not Relative
    
    anItem = [[TableItem alloc ]initWithTitle: @"Long Date, Long Time, Not Relative" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithDateStyle : NSDateFormatterLongStyle andTimeStyle: NSDateFormatterLongStyle andRelativeTime: false]]];
    [_sectionItems addObject: anItem];
        
        // MARK: toString Full Date, Full Time, Not Relative
    
    anItem = [[TableItem alloc ]initWithTitle: @"Full Date, Full Time, Not Relative" theDescription: [NSString stringWithFormat:@"%@", [now toStringWithDateStyle : NSDateFormatterFullStyle andTimeStyle: NSDateFormatterFullStyle andRelativeTime: false]]];
    [_sectionItems addObject: anItem];
        
        // MARK: Relative Time
    
    anItem = [[TableItem alloc ]initWithTitle: @"Relative Time" theDescription: [NSString stringWithFormat:@"%@", [now relativeTimeToString]]];
    [_sectionItems addObject: anItem];

    [_items addObject:(_sectionItems)];
    
    
    
    
        // MARK: **** DATE COMPONENTS TO STRING ******************************************************
        
    [_sections addObject:@"Date Components"];
    _sectionItems = [[NSMutableArray<TableItem *> alloc]init];
    
    
    
    
        // MARK: Weekday
    
    anItem = [[TableItem alloc ]initWithTitle: @"Weekday" theDescription: [NSString stringWithFormat:@"%@", [now weekdayToString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: Short Weekday
    
    anItem = [[TableItem alloc ]initWithTitle: @"Short Weekday" theDescription: [NSString stringWithFormat:@"%@", [now shortWeekdayToString]]];
    [_sectionItems addObject: anItem];
    
        // MARK: Very Short Weekday
    
    anItem = [[TableItem alloc ]initWithTitle: @"Very Short Weekday" theDescription: [NSString stringWithFormat:@"%@", [now veryShortWeekdayToString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: Month
    
    anItem = [[TableItem alloc ]initWithTitle: @"Month" theDescription: [NSString stringWithFormat:@"%@", [now monthToString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: Short Month
    
    anItem = [[TableItem alloc ]initWithTitle: @"Short Month" theDescription: [NSString stringWithFormat:@"%@", [now shortMonthToString]]];
    [_sectionItems addObject: anItem];
        
        // MARK: Very Short Month
    
    anItem = [[TableItem alloc ]initWithTitle: @"Very Short Month" theDescription: [NSString stringWithFormat:@"%@", [now veryShortMonthToString]]];
    [_sectionItems addObject: anItem];
        
    [_items addObject:(_sectionItems)];
    
    }

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return _items.count;
}

- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
   
    return _sections[section];
}

-(NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    return _items[section].count;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath ];
    TableItem *item = _items[indexPath.section][indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.theDescription;
    return cell;
}

@end