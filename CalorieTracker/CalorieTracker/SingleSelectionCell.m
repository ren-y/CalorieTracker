//
//  SingleSelectionCell.m
//  July.MyCalendar
//
//  Created by Asuka Nakagawa on 2016-07-27.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "SingleSelectionCell.h"
#import "NSDate+DateAddition.h"
#import "Day.h"

@interface SingleSelectionCell()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *indicator;

@property (nonatomic, strong) NSCalendar *calendar;

@property (nonatomic, strong) CALayer *topLine;

@end


@implementation SingleSelectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.dateLabel];
        [self.contentView.layer addSublayer:self.topLine];
        [self.contentView addSubview:self.indicator];

        self.calendar = [NSDate gregorianCalendar];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5);
    self.dateLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 - 13);
    self.indicator.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 + 5);

}


- (void)setDay:(Day *)day andDate:(NSDate *)date {
    _date = day.date;
    if (_date) {
        self.dateLabel.text = [NSString stringWithFormat:@"%ld", [self.calendar component:NSCalendarUnitDay fromDate:_date]];
        if ((day.targetCals - day.calorieConsumed) > 0) {
                    self.indicator.text = @"+";
        } else {
            self.indicator.text = @"-";
        }
        
    } else {
        self.dateLabel.text = nil;
        self.indicator.text = nil;

    }
}

- (void)setCellState:(CalendarCellState)cellState {
    _cellState = cellState;
    self.indicator.backgroundColor = [UIColor clearColor];

    switch (_cellState) {
        case ZBJCalendarCellStateEmpty: {
            self.dateLabel.text = nil;
            self.dateLabel.textColor = [UIColor whiteColor];
            self.dateLabel.backgroundColor = [UIColor whiteColor];
            self.dateLabel.layer.cornerRadius = 0;
            
            self.topLine.hidden = YES;
            break;
        }
        case ZBJCalendarCellStateNormal: {
            self.dateLabel.backgroundColor = [UIColor whiteColor];
            self.dateLabel.layer.cornerRadius = 0;
            
            if ([self.date isWeekend]) {
                self.dateLabel.textColor = [UIColor lightGrayColor];
            } else if ([self.date isToday]) {
                self.dateLabel.textColor = [UIColor  colorWithRed:255.0/255.0 green:60.0/255.0 blue:57.0/255.0 alpha:1.0];
            } else {
                self.dateLabel.textColor = [UIColor darkTextColor];
            }
            
            self.topLine.hidden = NO;
            break;
        }
        case ZBJCalendarCellStateSelected: {
            self.dateLabel.textColor = [UIColor whiteColor];
            self.dateLabel.layer.cornerRadius = 17;
            
            if ([self.date isToday]) {
                self.dateLabel.backgroundColor = [UIColor  colorWithRed:255.0/255.0 green:60.0/255.0 blue:57.0/255.0 alpha:1.0];
            } else {
                self.dateLabel.backgroundColor = [UIColor darkTextColor];
            }
            
            self.topLine.hidden = NO;
            break;
        }
        default:
            break;
    }
    
    [self layoutSubviews];
}

#pragma mark - getters
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:15];
        _dateLabel.textColor = [UIColor darkTextColor];
        _dateLabel.clipsToBounds = YES;
    }
    return _dateLabel;
}
- (UILabel *)indicator {
    if (!_indicator) {
        _indicator = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
        _indicator.textAlignment = NSTextAlignmentCenter;
        _indicator.font = [UIFont systemFontOfSize:20];
        _indicator.textColor = [UIColor orangeColor];
        _indicator.clipsToBounds = YES;
    }
    return _indicator;
}

- (CALayer *)topLine {
    if (!_topLine) {
        _topLine = [CALayer layer];
        _topLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5);
        _topLine.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor;
    }
    return _topLine;
}
@end
