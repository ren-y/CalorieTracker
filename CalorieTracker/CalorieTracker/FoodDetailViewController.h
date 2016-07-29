//
//  FoodDetailViewController.h
//  CalorieTracker
//
//  Created by reena on 28/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *calorieInFoodLabel;
@property(weak,nonatomic) NSString* foodDetailName;
@property (weak,nonatomic) NSString* foodCal;
@end
