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
@property (weak, nonatomic) IBOutlet UILabel *calorieBurntLabel;
@property int calorieConsumed;
@property int calorieBurnt;

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
     //[self initializeHealthStoreWithAuthorization];
    self.meal=[[Meal alloc]init];
    self.totalCalorieLabel.text=self.label;
    self.calorieBurnt=1250;
   
    
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
        self.calorieBurntLabel.text=[NSString stringWithFormat:@"Calories Burnt   %d",self.calorieBurnt];

    }
}

-(void)updateCaloriesConsumedWithFood:(Food *)food {
    self.calorieConsumed+=[food.calorie intValue];
    self.calConsumedTexfield.text=[NSString stringWithFormat:@"%i", self.calorieConsumed];
}

//From UserVC to Home ==>segue
-(void)setCalorieLabel:(User*)user{
    
    NSString *myString =[NSString stringWithFormat:@"%d",user.calorie];
    NSLog(@"In label home::%@",myString);
       self.label=[NSString stringWithFormat:@"  Your Target Calorie  %@",myString];
}
//

-(void)updateCalender{
//netResultLabel.text=targetCalories-COnsumedCal
}
- (void)initializeHealthStoreWithAuthorization {
    
    if([HKHealthStore isHealthDataAvailable]) {
        
        self.healthStore = [[HKHealthStore alloc] init];
        
        NSSet *writeDataTypes = [self dataTypesToWrite];
        
        NSSet *readDataTypes = [self dataTypesToRead];
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            
            if(error) {
                
                NSLog(@"%@", error);
                
            } else {
                
                NSLog(@"Success is %d", success);
            }
        }];
    }
}

- (NSSet *)dataTypesToRead {
    
        HKCharacteristicType * workoutType = [HKObjectType characteristicTypeForIdentifier:HKWorkoutTypeIdentifier];
    return [NSSet setWithObjects:workoutType, nil];
}

- (NSSet *)dataTypesToWrite {
    HKCharacteristicType * workoutType = [HKObjectType characteristicTypeForIdentifier:HKWorkoutTypeIdentifier];
    return [NSSet setWithObjects:workoutType, nil];
}
@end
