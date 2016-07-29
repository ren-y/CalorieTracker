//
//  ViewController.h
//  CalorieTracker
//
//  Created by reena on 26/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "User.h"
#import "Food.h"
#import "SearchCalorieViewController.h"

@interface HomeViewController : UIViewController<myDelegate>
@property (weak, nonatomic) IBOutlet UILabel *netResultLabel;


//@property (assign)int calorieBurnt;
-(void)passItem:(Food *)food;
-(void)setCalorieLabel:(User*)user;
@end

