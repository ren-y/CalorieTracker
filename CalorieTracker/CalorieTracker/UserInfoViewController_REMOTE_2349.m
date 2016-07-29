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
@property (strong,nonatomic) User* user;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"screen5.jpg"]];
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
 
    __block User *user = nil;
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        user = [[User allObjects] firstObject];
        
    }];

    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        
        if (!user) {
            user = [[User alloc] init];
            [[RLMRealm defaultRealm] addObject:user];
        }
        
        user.name = self.nameTextField.text;
        
        int height = [self.heightTextField.text intValue];
        user.height = height;
        
        int weight = [self.weightTextField.text intValue];
        user.weight = weight;
        
        int age = [self.ageTextField.text intValue];
        user.age = age;
        
        user.gender = self.genderTextField.text;
        
        NSString *selectedLevel = [pickerExerciseLevel objectAtIndex:[self.levelPickerView selectedRowInComponent:0]];
        NSLog(@"%@", selectedLevel);
        
        user.exerciseLevel = selectedLevel;
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
        NSLog(@"multiplier--%.3f", multiplier);
        
        int preBMR = (10 * weight) + 6.25 * height - (5 * age);
        
        if ([user.gender isEqual:@"m"]||[user.gender isEqual:@"M"]) {
            
            int BMR = (preBMR + 5) * multiplier;
            self.resultBMILabel.text = [NSString stringWithFormat:@"%d", BMR];
            user.calorie=BMR;
            NSLog(@"BMR---%d", BMR);
            
            // if women
        } else if ([user.gender isEqual:@"f"]||[user.gender isEqual:@"F"]) {
            
            int BMR = (preBMR - 161) * multiplier;
            self.resultBMILabel.text = [NSString stringWithFormat:@"%d", BMR];
            user.calorie=BMR;
            NSLog(@"BMR---%d", BMR);
            
        } else {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                                message:@"InValid Input"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                  style:UIAlertActionStyleDestructive
                                                                handler:^(UIAlertAction *action) {
                                                                    NSLog(@"Dismiss button tapped!");
                                                                }];
            [controller addAction:alertAction];
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        //    RLMRealm *realm = [RLMRealm defaultRealm];
        
//        [[RLMRealm defaultRealm] addOrUpdateObject:user];
        //        [[RLMRealm defaultRealm] addObject:user];
        //        self.user=[[User alloc]init];
        self.user = user;
        
    }];
    
//    __block User *user = nil;
//        int weight = [self.weightTextField.text intValue];
//        int age = [self.ageTextField.text intValue];
//        user.age = age;
//        user.gender = self.genderTextField.text;
//    [[RLMRealm defaultRealm] transactionWithBlock:^{
//        NSString *selectedLevel = [pickerExerciseLevel objectAtIndex:[self.levelPickerView selectedRowInComponent:0]];
//        NSLog(@"%@", selectedLevel);
//    self.userArray = [User allObjects];
 
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
        //        UINavigationController *navController=(UINavigationController*)segue.destinationViewController;
        
        HomeViewController *homeViewController=(HomeViewController*)segue.destinationViewController;
        [homeViewController setCalorieLabel:self.user];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
