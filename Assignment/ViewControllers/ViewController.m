//
//  ViewController.m
//  Assignment
//
//  Created by Admin on 19/04/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import "ViewController.h"
#import "JSONParser.h"
#import "AllAbout.h"
#import "CountryDetails.h"
#import "CountryDetailsCell.h"
#import "NetworkManager.h"

#define fileJSON @"https://dl.dropboxusercontent.com/u/746330/facts.json"
#define LOADING @"Loading.png"
#define NOIMAGE @"NoImage.png"

@interface ViewController ()
@property (nonatomic, strong) AllAbout *tableViewData;
@property(nonatomic, strong) NetworkManager *imageHelper;
@property(nonatomic, strong) JSONParser *jsonParser;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Allocate required components
    self.jsonParser = [[JSONParser alloc] init];
    self.imageHelper = [[NetworkManager alloc] init];
    self.tableViewData = [[AllAbout alloc] init];
    
    self.tableViewData = [self.jsonParser fetchAndParseJSON:fileJSON];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = self.tableViewData.countryDetails.count;
    
    return count!=0?count:1;
}


-(void) reloadData
{
    //Reload table view and stop the refreshing
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Calculate height by creating a temporary Text View to simulate description. Get height from this text view
    CGSize size;
    CountryDetails *currObject = [self.tableViewData.countryDetails objectAtIndex:indexPath.row];
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
    [calculationView setTextAlignment:NSTextAlignmentLeft];
    if (currObject.itemDetail)
        [calculationView setText:currObject.itemDetail];
    else
        [calculationView setText:@"No Text"];
    size = [calculationView sizeThatFits:CGSizeMake(tableView.bounds.size.width-80.f, FLT_MAX)];
    
    //Take into account Image View height
    if (size.height<80.f) {
        size.height = 80.f;
    }
    
    //Take into account any space requirements
    return size.height+40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextAlignment:NSTextAlignmentCenter];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    NSString *sectionName=self.tableViewData.countryTitle;
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell) {
        cell = [[CountryDetailsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    
    if (self.tableViewData.countryDetails.count > 0)
    {
        //Get the details for the corresponding row
        CountryDetails *row = [self.tableViewData.countryDetails objectAtIndex:indexPath.row];
    
        //Set the row values in UI
        if (![row.itemTitle isKindOfClass:[NSNull class]])
            cell.textLabel.text = (NSString *)row.itemTitle;
        if (![row.itemDetail isKindOfClass:[NSNull class]])
            cell.detailTextLabel.text = (NSString *)row.itemDetail;
        
        //Load Images. Load only once and after that wait till user does a refresh.
        if (!row.itemImage)
        {
            cell.imageView.image = [UIImage imageNamed:LOADING];
            row.itemImage = [UIImage imageNamed:LOADING];
            [self.imageHelper fetchImageWithURLString:row.imageUrl completionHandler:^(UIImage *image) {
                if (image == nil) {
                    cell.imageView.image = [UIImage imageNamed:NOIMAGE];
                    row.itemImage = [UIImage imageNamed:NOIMAGE];
                } else {
                    cell.imageView.image = image;
                    row.itemImage = image;
                }
            }
             ];
        }
        else
        {
            cell.imageView.image = row.itemImage;
        }
    } else NSLog(@"Error retrieving data");
    
    
    //Do not give any selection style
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

@end