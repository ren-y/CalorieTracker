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
@property NSMutableArray *fileteredArray;
//@property NSMutableArray *totalArray;
//@property NSMutableArray *foodArray;
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
    
    //URL string
    NSString *urlString =@"http://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=KEpxbaVzTsisfAvEzBj0ijXhsbvisnTP61rCwXYx&nutrients=208";
    
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
                
                NSMutableDictionary *innerDict = nutrientsArray.firstObject;
                newFood.unit = innerDict[@"unit"];
                newFood.calorie = innerDict[@"value"];
                
                [self.totalItems addObject:newFood];
            }
            
            NSLog(@"Food Object::%lu",self.totalItems.count);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
            //            for (Food *food in self.totalItems) {
            //                NSLog(@"name::%@ unit:: %@ cal::%@",food.name,food.unit,food.calorie);
            //
            //            }
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
        self.fileteredArray=[[NSMutableArray alloc]init];
        for (Food *food in self.totalItems) {
            NSRange strRange=[food.name rangeOfString:searchText options:NSCaseInsensitiveSearch]; //range is enum location length
            
            if(strRange.location == 0)
            {
                [self.fileteredArray addObject:food];
                
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
        return self.fileteredArray.count;
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
        Food * food = [self.fileteredArray objectAtIndex:indexPath.row];
        cell.textLabel.text = food.name;
    }
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
