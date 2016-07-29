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

@property (nonatomic) NSDate *date;
@property (assign) int targetCals;

@property (assign) int calorieConsumed;
@property (assign) int calorieBurnt;

//@property (nonatomic) RLMArray<Food> *foodsArray;
//@property NSInteger userDate;

-(BOOL) indicator;

@end
RLM_ARRAY_TYPE(Day)
