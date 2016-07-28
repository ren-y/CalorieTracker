//
//  CalorieHistoryViewController.m
//  CalorieTracker
//
//  Created by reena on 26/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import "CalorieHistoryViewController.h"

#import "Calendar.h"
#import "CalendarView.h"
#import "SingleSelectionCell.h"
#import "SingleSelectionHeaderView.h"
#import "UINavigationBar+Addition.h"
#import "Day.h"

@interface CalorieHistoryViewController () <CalendarDataSource, CalendarDelegate>

@property (nonatomic, strong) CalendarView *calendarView;
@property (nonatomic, strong) NSDate *selectedDate;

@property RLMResults<Day *> *dayArray;

@end

@implementation CalorieHistoryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar hidenHairLine:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar hidenHairLine:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDate *today = [NSDate today];
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    
    NSDate *firstDate = [calendar dateFromComponents:components];
    
    components.month = components.month + 6 + 1;
    components.day = 0;
    NSDate *lastDate = [calendar dateFromComponents:components];
    
    self.calendarView.firstDate = firstDate;
    self.calendarView.lastDate = lastDate;
    
    [self.view addSubview:self.calendarView];
    
    self.selectedDate = firstDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - ZBJCalendarDataSource
- (void)calendarView:(CalendarView *)calendarView configureCell:(SingleSelectionCell *)cell forDate:(NSDate *)date {
    
    cell.date = date;
    if (date) {
        if ([date isEqualToDate:self.selectedDate]) {
            cell.cellState = ZBJCalendarCellStateSelected;
        } else {
            cell.cellState = ZBJCalendarCellStateNormal;
        }
    } else {
        cell.cellState = ZBJCalendarCellStateEmpty;
    }
}

- (void)calendarView:(CalendarView *)calendarView configureSectionHeaderView:(SingleSelectionHeaderView *)headerView firstDateOfMonth:(NSDate *)firstDateOfMonth {
    headerView.firstDateOfMonth = firstDateOfMonth;
}

- (void)calendarView:(CalendarView *)calendarView configureWeekDayLabel:(UILabel *)dayLabel atWeekDay:(NSInteger)weekDay {
    dayLabel.font = [UIFont systemFontOfSize:13];
    if (weekDay == 0 || weekDay == 6) {
        dayLabel.textColor = [UIColor lightGrayColor];
    }
}

#pragma mark - ZBJCalendarDelegate
- (void)calendarView:(CalendarView *)calendarView didSelectDate:(NSDate *)date ofCell:(SingleSelectionCell *)cell {
    
    NSDate *oldDate = [self.selectedDate copy];
    self.selectedDate = date;
    
    [calendarView reloadItemsAtDates:[NSMutableSet setWithObjects:oldDate, self.selectedDate, nil]];
    //    if (date) {
    NSLog(@"Selected date is : %@", self.selectedDate);
    
    
    
    
    
    
    
    self.dayArray = [Day allObjects];

//    day.date = self.selectedDate;
    
    
    //        cell.cellState = ZBJCalendarCellStateSelected;
    //    }
    
}


#pragma mark -
- (CalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        [_calendarView registerCellClass:[SingleSelectionCell class] withReuseIdentifier:@"singleCell"];
        [_calendarView registerSectionHeader:[SingleSelectionHeaderView class] withReuseIdentifier:@"singleSectionHeader"];
        _calendarView.selectionMode = ZBJSelectionModeSingle;
        _calendarView.dataSource = self;
        _calendarView.delegate = self;
        _calendarView.backgroundColor = [UIColor whiteColor];
        _calendarView.contentInsets = UIEdgeInsetsMake(0, 14, 0, 14);
        _calendarView.cellScale = 140.0 / 100.0;
        _calendarView.sectionHeaderHeight = 27;
        _calendarView.weekViewHeight = 20;
        _calendarView.weekView.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:249.0f/255.0f blue:249.0f/255.0f alpha:1.0];
    }
    return _calendarView;
}


@end
