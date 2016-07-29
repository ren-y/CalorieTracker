//
//  HealthKitManagerVC.h
//  CalorieTracker
//
//  Created by reena on 28/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthKitManagerVC : NSObject

+ (HealthKitManagerVC *)sharedManager;

- (void)requestAuthorization;

- (int)readCalorieBurnt;


@end
