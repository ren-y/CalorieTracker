//
//  NSDate+DateAddition.h
//  July.MyCalendar
//
//  Created by Asuka Nakagawa on 2016-07-27.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateAddition)

/**
 *  This category provide utility methods for `NSDate`.
 */

+ (NSCalendar *)gregorianCalendar;
+ (NSLocale *)locale;

+ (NSDate *)today;
+ (NSInteger)numberOfMonthsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSInteger)numberOfDaysFromMonth:(NSDate *)fromMonth toMonth:(NSDate *)toMonth;
+ (NSInteger)numberOfDaysInMonth:(NSDate *)date;
+ (NSInteger)numberOfNightsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

- (NSDate *)firstDateOfMonth;
- (NSDate *)firstDateOfWeek;
- (NSDate *)lastDateOfMonth;

- (NSInteger)weekday;

- (BOOL)isToday;
- (BOOL)isWeekend;


@end
