//
//  Day.h
//  CalorieTracker
//
//  Created by Asuka Nakagawa on 2016-07-26.
//  Copyright © 2016 Reena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Day : RLMObject

//@property (nonatomic) NSString *day;
@property (nonatomic) NSDate *date;
@property (assign) int targetCals;

@property (nonatomic) NSString *indicator;

//@property (nonatomic) RLMArray<Food> *foodsArray;
//@property NSInteger userDate;

@end
RLM_ARRAY_TYPE(Day)
