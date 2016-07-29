//
//  NSDate+IndexPath.h
//  July.MyCalendar
//
//  Created by Asuka Nakagawa on 2016-07-27.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This category provide methods used to corresponding relations between indexpath and date.
 */
@interface NSDate (IndexPath)

+ (NSDate *)dateForFirstDayInSection:(NSInteger)section firstDate:(NSDate *)firstDate;
+ (NSDate *)dateAtIndexPath:(NSIndexPath *)indexPath firstDate:(NSDate *)firstDate;
+ (NSIndexPath *)indexPathAtDate:(NSDate *)date firstDate:(NSDate *)firstDate;

@end

