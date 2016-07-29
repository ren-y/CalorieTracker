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

@property (weak, nonatomic) IBOutlet UITextField *breakfastTextfield;
@property (weak, nonatomic) IBOutlet UITextField *lunchTextfield;
@property (weak, nonatomic) IBOutlet UITextField *snacksTextField;
@property (weak, nonatomic) IBOutlet UITextField *dinnerTextField;
@property (weak, nonatomic) IBOutlet UITextField *calConsumedTexfield;
@property (weak, nonatomic) IBOutlet UILabel *totalCalorieLabel;
@property (weak, nonatomic) IBOutlet UILabel *calorieBurntLabel;

@property (strong,nonatomic) NSString *label;

@property (nonatomic) Day *day;
@property (nonatomic) User *user;

@property (strong,nonatomic) Meal *meal;


@end

@implementation HomeViewController

//-(void)mealButtonPressed{
// 
//}

- (IBAction)brkFastButtonPressed:(id)sender {
      self.meal.type=@"breakfast";
}
- (IBAction)lunchButtonPressed:(id)sender {
  
    self.meal.type=@"lunch";
}
- (IBAction)snacksButtonPressed:(id)sender {
    self.meal.type=@"snack";
}
- (IBAction)dinnerButtonPressed:(id)sender {
    self.meal.type=@"dinner";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.day = [[Day alloc] init];
//    self.user = [User allObjects];
    
//    User *user = self.user;
    
    self.meal = [[Meal alloc]init];
    self.totalCalorieLabel.text = self.label;
    self.day.calorieBurnt = 1250;

//    self.day.calorieBurnt = self.calorieBurnt;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
   if([segue.identifier isEqualToString:@"bfSegue"]){
      SearchCalorieViewController *searchViewController=(SearchCalorieViewController*)segue.destinationViewController;
        searchViewController.delegate=self;
     }
    if ([segue.identifier isEqualToString:@"lunchSegue"]) {
        SearchCalorieViewController *searchViewController=(SearchCalorieViewController*)segue.destinationViewController;
        searchViewController.delegate=self;
        
    }else if ([segue.identifier isEqualToString:@"snackSegue"]){
        SearchCalorieViewController *searchViewController=(SearchCalorieViewController*)segue.destinationViewController;
        searchViewController.delegate=self;
    }
    else if ([segue.identifier isEqualToString:@"dinnerSegue"]){
        SearchCalorieViewController *searchViewController=(SearchCalorieViewController*)segue.destinationViewController;
        searchViewController.delegate=self;
    }
   
}
-(void)passItem:(Food *)food{
    
   if ([self.meal.type isEqualToString:@"breakfast"]) {
        self.breakfastTextfield.text=[food.calorie stringByAppendingString:food.unit];
       [self updateCaloriesConsumedWithFood:food];

   }
    else if ([self.meal.type isEqualToString:@"lunch"]) {
        self.lunchTextfield.text=[food.calorie stringByAppendingString:food.unit];
        [self updateCaloriesConsumedWithFood:food];

    }
    else if([self.meal.type isEqualToString:@"snack"]) {
        self.snacksTextField.text=[food.calorie stringByAppendingString:food.unit];
        [self updateCaloriesConsumedWithFood:food];

    }
    
    else if([self.meal.type isEqualToString:@"dinner"]) {
        self.dinnerTextField.text=[food.calorie stringByAppendingString:food.unit];
        [self updateCaloriesConsumedWithFood:food];
        
        //hard coading Pedometer value
//        self.calorieBurntLabel.text=[NSString stringWithFormat:@"Calories Burnt   %d", self.calorieBurnt];
        self.calorieBurntLabel.text=[NSString stringWithFormat:@"Calories Burnt   %d", self.day.calorieBurnt];
        
        int netResult = self.user.calorie - self.day.calorieConsumed - self.day.calorieBurnt;
        NSLog(@"user.calorie: %d - calorieConsumed:%d - burnCal:%d = NetResult: %d", self.user.calorie, self.day.calorieConsumed, self.day.calorieBurnt, netResult);
        self.netResultLabel.text = [NSString stringWithFormat:@"%d", netResult];
//        NSLog(@"Day.calorieBurnt--%d", self.day.calorieBurnt);
    }
}

-(void)updateCaloriesConsumedWithFood:(Food *)food {
//    self.calorieConsumed += [food.calorie intValue];
//    self.calConsumedTexfield.text = [NSString stringWithFormat:@"%i", self.calorieConsumed];
    
    self.day.calorieConsumed += [food.calorie intValue];
    self.calConsumedTexfield.text = [NSString stringWithFormat:@"%i", self.day.calorieConsumed];

    NSLog(@"self.calorieConsumed--%d", self.day.calorieConsumed);
}

//From UserVC to Home ==>segue
-(void)setCalorieLabel:(User*)user {
    
    NSString *myString = [NSString stringWithFormat:@"%d", user.calorie];
    NSLog(@"In label home::%@",myString);
    self.label = [NSString stringWithFormat:@"  Your Target Calorie  %@", myString];
//    self.user = user;
}

-(void)updateCalender: (User *)user {
//    int netResult = user.calorie - self.calorieConsumed;
//    NSLog(@"netResult--%d", netResult);
//    self.netResultLabel.text = [NSString stringWithFormat:@"%d", netResult];
    
    
//    self.netResultLabel.text = (user.calorie - self.calorieConsumed);
//netResultLabel.text=targetCalories-ConsumedCal
}

@end
