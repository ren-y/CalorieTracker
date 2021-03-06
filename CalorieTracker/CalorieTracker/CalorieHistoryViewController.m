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
//label.text = [label.text stringByAppendingString:@"your text"];
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
    
    self.dayArray = [[Day allObjects] sortedResultsUsingProperty:@"date" ascending:NO];
    
    if ([self.dayArray count] < 3) {
        
        for (int i = 1; i < 100; i++) {
            
            Day *day = [[Day alloc] init];
            
            
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*i];
            
            NSCalendar *calendar = [NSDate gregorianCalendar];
                NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
            NSDate *firstDate = [calendar dateFromComponents:components];
            
            day.date = firstDate;
            day.targetCals = arc4random_uniform(2000);
            day.calorieBurnt = arc4random_uniform(2000);
            day.calorieConsumed = arc4random_uniform(2000);
            
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [[RLMRealm defaultRealm] addObject:day];
            }];
        }
    }
    
    
//    NSDate *today = [NSDate today];
//    NSCalendar *calendar = [NSDate gregorianCalendar];
//    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
//    
//    NSDate *firstDate = [calendar dateFromComponents:components];
//    
//    components.month = components.month + 6 + 1;
//    components.day = 0;
//    NSDate *lastDate = [calendar dateFromComponents:components];
    
    self.calendarView.lastDate = [[self.dayArray firstObject] date];
    self.calendarView.firstDate = [[self.dayArray lastObject] date];
    
    [self.view addSubview:self.calendarView];
    
    self.selectedDate = [NSDate today];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - ZBJCalendarDataSource
- (void)calendarView:(CalendarView *)calendarView configureCell:(SingleSelectionCell *)cell forDate:(NSDate *)date {
    
    // get a day object for a given date
    
    RLMResults<Day *> *days = [self.dayArray objectsWithPredicate:[NSPredicate predicateWithFormat:@"date >= %@ AND date < %@", date, [date dateByAddingTimeInterval:60*60*24]]];
    
    Day *aDay = [days firstObject];
//    if (aDay) {
        [cell setDay:aDay];
//    }
    
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
    if (firstDateOfMonth) {
        headerView.firstDateOfMonth = firstDateOfMonth;
    }
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
    
    
    
    RLMResults<Day *> *days = [self.dayArray objectsWithPredicate:[NSPredicate predicateWithFormat:@"date >= %@ AND date < %@", date, [date dateByAddingTimeInterval:60*60*24]]];
    
    Day *aDay = [days firstObject];
    
    NSString *message = [NSString stringWithFormat:@"Calories consumed %i, target %i", aDay.calorieConsumed, aDay.targetCals];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:[date description]
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Done"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            NSLog(@"Dismiss button tapped!");
                                                        }];
    [controller addAction:alertAction];
    [self presentViewController:controller animated:YES completion:nil];

    
    
    
//    self.dayArray = [Day allObjects];

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
