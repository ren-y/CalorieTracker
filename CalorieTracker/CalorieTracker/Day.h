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

@property (nonatomic) NSString *day;

@end
RLM_ARRAY_TYPE(Day)
