//
//  HealthKitManagerVC.m
//  CalorieTracker
//
//  Created by reena on 28/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import "HealthKitManagerVC.h"
#import "HomeViewController.h"
#import <HealthKit/HealthKit.h>

@interface HealthKitManagerVC ()

@property (nonatomic, retain) HKHealthStore *healthStore;
@property (strong,nonatomic)HomeViewController *homeVC;

@end

@implementation HealthKitManagerVC

//class method
+ (HealthKitManagerVC *)sharedManager {
    static dispatch_once_t pred = 0;
    static HealthKitManagerVC *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[HealthKitManagerVC alloc] init];
        instance.healthStore = [[HKHealthStore alloc] init];
    });
    return instance;
}

- (void)requestAuthorization {
    
    if ([HKHealthStore isHealthDataAvailable] == NO) {
        // If our device doesn't support HealthKit -> return.
        return;
    }
    
    NSArray *readTypes = @[[HKObjectType quantityTypeForIdentifier:HKWorkoutSortIdentifierTotalEnergyBurned]];
    
    //    NSArray *readTypes = @[[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth]];
//    @property (readonly, strong, nullable) HKQuantity *totalEnergyBurned;
//    NSArray *writeTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]];
    
  //  [self.healthStore requestAuthorizationToShareTypes:[NSSet setWithArray:readTypes] completion:nil];
    
    
}

    
    
   

//- (void)splitTotalEnergy:(HKQuantity *)totalEnergy
//               startDate:(NSDate *)startDate
//                 endDate:(NSDate *)endDate
//          resultsHandler:(void (^)(HKQuantity *restingEnergy, HKQuantity *activeEnergy, NSError *error))resultsHandler;{
//    
//    self.homeVC.calorieBurnt=   
//}


- (int)readCalorieBurnt{
    
    
//    NSError *error;
//    
//    HKQuantity *energyBurned =
//    [HKQuantity quantityWithUnit:[HKUnit kilocalorieUnit]
//                     doubleValue:425.0];
//  
//    [self.healthStore splitTotalEnergy:energyBurned startDate:current_task endDate:current_task resultsHandler:<#^(HKQuantity * _Nullable restingEnergy, HKQuantity * _Nullable activeEnergy, NSError * _Nullable error)resultsHandler#> :&error];
//    
//    
//        if (!) {
//        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.");
//    }
//    
    return 1;
}

@end
