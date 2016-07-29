//
//  SingleSelectionCell.h
//  July.MyCalendar
//
//  Created by Asuka Nakagawa on 2016-07-27.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CF_ENUM(NSInteger, CalendarCellState) {
    ZBJCalendarCellStateEmpty,
    ZBJCalendarCellStateNormal,
    ZBJCalendarCellStateSelected,
};

@class Day;

@interface SingleSelectionCell : UICollectionViewCell


- (void)setDay:(Day *)day;
    
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) CalendarCellState cellState;

@end
