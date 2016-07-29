//
//  SearchCalorieViewController.m
//  CalorieTracker
//
//  Created by reena on 26/07/16.
//  Copyright © 2016 Reena. All rights reserved.
//

#import "SearchCalorieViewController.h"

@interface SearchCalorieViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property bool isFilered;
@property NSMutableArray *filteredArray;
@property (strong,nonatomic)Food *food;

@property (strong,nonatomic)NSMutableArray *totalItems; //final array for search
@end

@implementation SearchCalorieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lemon.jpg"]]];
    self.searchBar.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.totalItems=[[NSMutableArray alloc]init];
    //self.foodArray=[[NSMutableArray alloc]init];
    NSString *urlString =@"http://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=bkO3pFhNPS6QBIvfZkkRj4XUH1ILOQe8o5RukW0v&nutrients=205&nutrients=204&nutrients=208&nutrients=269";
    
    //Get a session Connection
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *totalJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSDictionary *report=totalJSON[@"report"]; //persist
            NSArray *foods=report[@"foods"];
            
            for(NSDictionary *food in foods){
                
                NSString *foodLabel=food[@"name"];
                
                Food *newFood = [[Food alloc] init];
                newFood.name=foodLabel;
                
                
                NSArray *nutrientsArray = food[@"nutrients"];
                
                NSMutableDictionary *innerDict = nutrientsArray.lastObject;
                newFood.unit = innerDict[@"unit"];
                newFood.calorie = innerDict[@"value"];
                
                [self.totalItems addObject:newFood];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
    }
        
    }];
    
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//searchBar method
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{//searchText is what user typing in search q...qu...queen
    if (searchText.length==0) {
        self.isFilered=NO;   //if there is nothing in the search bar
    }
    else
    {
        self.isFilered=YES;
        //lazy loading only alloc init when needed
        self.filteredArray=[[NSMutableArray alloc]init];
        for (Food *food in self.totalItems) {
            NSRange strRange=[food.name rangeOfString:searchText options:NSCaseInsensitiveSearch]; //range is enum location length
            
            if(strRange.location == 0)
            {
                [self.filteredArray addObject:food];
                
            }
        }
        
    }
    [self.tableView reloadData];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.tableView resignFirstResponder];
    
}

//Table view datasource and delegate method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isFilered)
    {
        return self.filteredArray.count;
    }
    else
    {
        return self.totalItems.count;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* CellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    if(!self.isFilered)
    {
        Food * food = [self.totalItems objectAtIndex:indexPath.row];
        cell.textLabel.text = food.name;
    }
    else
    {
        Food * food = [self.filteredArray objectAtIndex:indexPath.row];
        cell.textLabel.text = food.name;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(_filteredArray != nil){
    Food *food=self.filteredArray[indexPath.row];
        [self.delegate passItem:food];
    NSLog(@"calorie::%@  unit::%@ path::%ld",food.name,food.unit,indexPath.row);
    }
    else{
    Food *food=self.totalItems[indexPath.row];
         [self.delegate passItem:food];
    NSLog(@"calorie::%@  unit::%@ path::%ld",food.calorie,food.unit,indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
