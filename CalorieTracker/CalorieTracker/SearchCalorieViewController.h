//
//  SearchCalorieViewController.h
//  CalorieTracker
//
//  Created by reena on 26/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@protocol myDelegate

-(void)passItem:(Food*)food;

@end

@interface SearchCalorieViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,weak)id<myDelegate>delegate;

@end
