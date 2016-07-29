//
//  SingleSelectionHeaderView.m
//  July.MyCalendar
//
//  Created by Asuka Nakagawa on 2016-07-27.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "SingleSelectionHeaderView.h"
#import "NSDate+DateAddition.h"


@interface SingleSelectionHeaderView()

@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, assign) NSInteger weekday;
@end

@implementation SingleSelectionHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.monthLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.monthLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.monthLabel.frame), 20);
    self.monthLabel.center = CGPointMake(25 * ((self.weekday - 1) * 2 + 1), CGRectGetHeight(self.frame) / 2);
}

#pragma mark - setters
- (void)setFirstDateOfMonth:(NSDate *)firstDateOfMonth {
    _firstDateOfMonth = firstDateOfMonth;
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday fromDate:firstDateOfMonth];
    self.weekday = components.weekday;
    
    
    NSInteger numOfMonth = components.month;
    int monthNumber = (int)numOfMonth;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSString *monthStr = [[df monthSymbols] objectAtIndex:(monthNumber - 1)];
    
//    NSLog(@"MonthStr--%@, components.month--%ld", monthStr, components.month);
    self.monthLabel.text = [NSString stringWithFormat:@"%@", monthStr];
    [self.monthLabel sizeToFit];
    [self layoutSubviews];
}


#pragma mark - getters
- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.font = [UIFont systemFontOfSize:17];
        _monthLabel.textColor = [UIColor darkTextColor];
    }
    return _monthLabel;
}


@end
