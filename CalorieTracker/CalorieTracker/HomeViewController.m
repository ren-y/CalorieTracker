//
//  ViewController.m
//  CalorieTracker
//
//  Created by reena on 26/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"

@interface HomeViewController ()

@property (nonatomic) RLMResults *usersArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usersArray = [User allObjects];
    if ([self.usersArray count] > 0) {
        
        // go to UserInfoVC
    } else {
       // Stay HomeVC
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
