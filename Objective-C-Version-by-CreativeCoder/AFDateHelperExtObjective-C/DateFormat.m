//
//  DateFormat.m
//  AFDateHelperExtObjective-C
//
//  Created by Tassilo Lechner von Leheneck on 10/04/16.
//  Copyright © 2016 Tassilo Lechner von Leheneck. All rights reserved.
//

#import "DateFormat.h"

@implementation DateFormat

NSString * const ISO8601DateFormatType = @"ISO8601";
NSString * const DotNetDateFormatType = @"DotNet";
NSString * const RSSDateFormatType = @"EEE, d MMM yyyy HH:mm:ss ZZZ";
NSString * const AltRSSDateFormatType = @"d MMM yyyy HH:mm:ss ZZZ";
NSString * const CustomDateFormatType = @"Custom";

NSString * const ISOFormatYear = @"yyyy";
NSString * const ISOFormatYearMonth = @"yyyy-MM"; // 1997-07
NSString * const ISOFormatDate = @"yyyy-MM-dd"; // 1997-07-16
NSString * const ISOFormatDateTime = @"yyyy-MM-dd'T'HH:mmZ"; // 1997-07-16T19:20+01:00
NSString * const ISOFormatDateTimeSec = @"yyyy-MM-dd'T'HH:mm:ssZ"; // 1997-07-16T19:20:30+01:00
NSString * const ISOFormatDateTimeMilliSec = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"; // 1997-07-16T19:20:30.45+01:00

- (instancetype) initWithType: (NSString *) formatType details: (NSString *) details {
    
    if(self = [super init]) {
        _dateFormatType = formatType;
        _formatDetails = details;
    }
    
    return self;
}

+ (instancetype) ISODateFormat: (NSString *) isoFormat
{
    return [[DateFormat alloc] initWithType: ISO8601DateFormatType details: isoFormat];
}

+ (instancetype) DotNetDateFormat
{
    return [[DateFormat alloc] initWithType: DotNetDateFormatType details: nil];
}

+ (instancetype) RSSDateFormat
{
    return [[DateFormat alloc] initWithType: RSSDateFormatType details: nil];
}

+ (instancetype) AltRSSDateFormat
{
    return [[DateFormat alloc] initWithType: AltRSSDateFormatType details: nil];
}

+ (instancetype) CustomDateFormat: (NSString *) formatString
{
    return [[DateFormat alloc] initWithType: CustomDateFormatType details: formatString];
}

@end