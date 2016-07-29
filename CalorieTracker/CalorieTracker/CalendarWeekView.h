//
//  CalendarWeekView.h
//  July.MyCalendar
//
//  Created by Asuka Nakagawa on 2016-07-27.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarWeekViewDelegate;

/**
 *  `ZBJCalendarWeekView` is the default view for display week days.
 *  By default, is contains 7 labels present monday to sunday.
 *  You can custom weekView style by the public property `weekView` of `ZBJCalendarView`.
 *  If you want to change each week day's style, you can conform the `ZBJCalendarWeekViewDelegate` and implement `- (void)calendarWeekView:(ZBJCalendarWeekView *)weekView configureWeekDayLabel:(UILabel *)dayLabel atWeekDay:(NSInteger)weekDay;` method.
 */
@interface CalendarWeekView : UIView

/**
 *  A reference of `ZBJCalendarWeekViewDelegate` which can custom week day label.
 */
@property (nonatomic, weak) id<CalendarWeekViewDelegate> delegate;

/**
 *  The inner padding of week view.
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;   // the inner padding

/**
 *  Default line at the bottom of week view.
 */
@property (nonatomic, strong) CALayer *bottomLine;
@end

@protocol CalendarWeekViewDelegate <NSObject>

@optional
/**
 *  Used to configure the weekday label with the `weekDay`
 *
 *  @param weekView  self
 *  @param dayLabel  weekday label
 *  @param weekDay   integer of the weekday
 */
- (void)calendarWeekView:(CalendarWeekView *)weekView configureWeekDayLabel:(UILabel *)dayLabel atWeekDay:(NSInteger)weekDay;

@end
