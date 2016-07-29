//
//  UserInfoViewController.m
//  CalorieTracker
//
//  Created by reena on 26/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import "UserInfoViewController.h"
#import "HomeViewController.h"
#import "NSDate+DateAddition.h"
#import "User.h"

//#import "CalorieHistoryViewController.h"

@interface UserInfoViewController () {
    NSArray *pickerExerciseLevel;
}

@property RLMResults<User *> *userArray;
@property (strong,nonatomic) User *user;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"config is %@", [[RLMRealm defaultRealm] configuration]);
    self.userArray = [User allObjects];
    
    pickerExerciseLevel = @[@"Sedentary", @"Lightly active", @"Moderately active", @"Very active", @"Extra active"];
    
    
//    pickerDate = @[@"Sedentary", @"Lightly active", @"Moderately active", @"Very active", @"Extra active"];


    self.levelPickerView.delegate = self;
    self.levelPickerView.dataSource = self;
    
}

#pragma mark - PickerView Delegates
// the number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// the number of rows data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerExerciseLevel count];
}

// The data to return for the row and component (column) that's being passed in
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerExerciseLevel[row];
}

//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSString *level = [pickerExerciseLevel objectAtIndex:row];
//    
//}

#pragma mark - Calculate BMR
- (IBAction)calculatePressed:(UIButton *)sender {
    
//    User *user = [[User alloc] init];
    self.user = [[User alloc] init];
    self.user.name = self.nameTextField.text;
    
    
//    NSDate *date = [NSDate today];
//    NSLog(@"user.daysArray--%@, date--%@", user.daysArray, (Day*)date);
//    NSString *str = [NSString stringWithFormat:@"%@", (Day*)date];
//    [user.daysArray addObject:(Day*)str];
    
    int height = [self.heightTextField.text intValue];
    self.user.height = height;

    int weight = [self.weightTextField.text intValue];
    self.user.weight = weight;
    
    int age = [self.ageTextField.text intValue];
    self.user.age = age;
    
    self.user.gender = self.genderTextField.text;
    
    NSString *selectedLevel = [pickerExerciseLevel objectAtIndex:[self.levelPickerView selectedRowInComponent:0]];
//    NSLog(@"%@", selectedLevel);
    
    self.user.exerciseLevel = selectedLevel;
    double multiplier = 0;
    
    if ([selectedLevel isEqualToString:@"Sedentary"]) {
        multiplier = 1.2;
        
    } else if ([selectedLevel isEqualToString:@"Lightly active"]) {
        multiplier = 1.375;
        
    } else if ([selectedLevel isEqualToString:@"Moderately active"]) {
        multiplier = 1.55;
        
    } else if ([selectedLevel isEqualToString:@"Very active"]) {
        multiplier = 1.725;
        
    } else {
        multiplier = 1.9;
    }
    
    int preBMR = (10 * weight) + 6.25 * height - (5 * age);
    
    if ([self.user.gender isEqual:@"m"]||[self.user.gender isEqual:@"M"]) {
        
        int BMR = (preBMR + 5) * multiplier;
        self.resultBMILabel.text = [NSString stringWithFormat:@"%d", BMR];
        self.user.calorie=BMR;
        NSLog(@"BMR---%d", BMR);
        
    // if women
    } else if ([self.user.gender isEqual:@"f"]||[self.user.gender isEqual:@"F"]) {
        
        int BMR = (preBMR - 161) * multiplier;
        self.resultBMILabel.text = [NSString stringWithFormat:@"%d", BMR];
        self.user.calorie=BMR;
        NSLog(@"BMR---%d", BMR);

    } else {
        NSLog(@"Nothing Happen");
    }
//    RLMRealm *realm = [RLMRealm defaultRealm];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addObject:self.user];
//        self.user=[[User alloc]init];
//       self.user=user;
        
    }];
    
    self.userArray = [User allObjects];
    
}

#pragma mark - TextField Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"segueToCalorieTracker"]){
        UINavigationController *navController = (UINavigationController*)segue.destinationViewController;
        HomeViewController *homeViewController = (HomeViewController*)[navController.viewControllers firstObject];
        
        [homeViewController setCalorieLabel:self.user];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
