//
//  User.h
//  CalorieTracker
//
//  Created by Asuka Nakagawa on 2016-07-26.
//  Copyright © 2016 Reena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Day.h"

@interface User : RLMObject

@property (nonatomic) NSString *name;
@property (assign) int age;

@property (nonatomic) NSString *gender;

@property (assign) int weight;
@property (assign) int height;

@property (nonatomic) NSString *exerciseLevel;

@property (nonatomic) NSString *targetCals;

@property RLMArray<Day *><Day> *daysArray;

@end
