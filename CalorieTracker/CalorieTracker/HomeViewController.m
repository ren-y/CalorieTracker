//
//  ViewController.m
//  CalorieTracker
//
//  Created by reena on 26/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *breakfastTextfield;
@property (weak, nonatomic) IBOutlet UITextField *lunchTextfield;
@property (weak, nonatomic) IBOutlet UITextField *snacksTextField;
@property (weak, nonatomic) IBOutlet UITextField *dinnerTextField;
@property (weak, nonatomic) IBOutlet UITextField *calConsumedTexfield;
@property (weak, nonatomic) IBOutlet UILabel *totalCalorieLabel;
@property (strong,nonatomic) NSString *label;


@property (strong,nonatomic)Meal *meal;

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
    self.meal=[[Meal alloc]init];
    self.totalCalorieLabel.text=self.label;
                                 
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
   }
    else if ([self.meal.type isEqualToString:@"lunch"]) {
        self.lunchTextfield.text=[food.calorie stringByAppendingString:food.unit];
    }
    else if([self.meal.type isEqualToString:@"snack"]) {
        self.snacksTextField.text=[food.calorie stringByAppendingString:food.unit];
    }
    
    else if([self.meal.type isEqualToString:@"dinner"]) {
        self.dinnerTextField.text=[food.calorie stringByAppendingString:food.unit];
    }
}
-(void)setCalorieLabel:(User*)user{
    
    NSString *myString =[NSString stringWithFormat:@"%d",user.calorie];
    NSLog(@"In label home::%@",myString);
   // [self createTemporaryLabelWithString:myString];
    
    //self.label=myString;
    self.label=[NSString stringWithFormat:@"Your Daily Target Calorie is  %@",myString];
//   NSString *label = self.totalCalorieLabel.text;
//    self.totalCalorieLabel.text=[label stringByAppendingString:myString];
//    self.totalCalorieLabel.backgroundColor=[UIColor yellowColor];
    //[self.view addSubview:_totalCalorieLabel];
    //[self.view bringSubviewToFront:_totalCalorieLabel];
    
}

//-(void)createTemporaryLabelWithString:(NSString *)string
//{
//    //    CGRect frame = CGRectMake(10, 10, 200, 40);
////    UILabel *tempLabel = [[UILabel alloc] initWithFrame:frame];
////    tempLabel.text = string;
////    tempLabel.backgroundColor = [UIColor orangeColor];
////    [self.view addSubview:tempLabel];
////    [self.view bringSubviewToFront:tempLabel];
//}
@end
