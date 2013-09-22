//
//  GGFilterViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGFilterViewController.h"
#import "UIBarButtonItem+ProjectButton.h"
#import "UISearchBar+ProjectSearchBar.h"
#import "AppDelegate.h"
#import "FilterDataSource.h"
#import "UIBarButtonItem+ProjectButton.h"

@interface GGFilterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *choiceListArray;
@property (nonatomic, strong) NSString *filterTypeObjectsString;
@property (nonatomic, strong) NSString *filterTypeObjectString;
@property (nonatomic, strong) FilterDataSource *filterDataSource;

@end

@implementation GGFilterViewController

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.filterTypeTitleString;
    self.choiceListArray = [NSMutableArray array];
    [self customizeTheme];
    [self beginNetworkingWithFilterType:self.filterType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Customization

- (void)customizeTheme
{
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem createEdgeButtonWithImage:[UIImage imageNamed:@"nav_backBtn.png"] WithTarget:self action:@selector(back)];
}

#pragma mark - back
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Networking

- (void)beginNetworkingWithFilterType:(FilterType)theFilterType
{
    NSMutableString *urlString = [NSMutableString string];
    switch (theFilterType) {
        case FilterTypeRegions:
        {
            [urlString appendString:@"api/v1/regions.json"];
            self.filterTypeObjectsString = @"regions";
            self.filterTypeObjectString = @"region";
        }
            break;
        case FilterTypeEventTypes:
        {
            [urlString appendString:@"api/v1/categories.json"];
            self.filterTypeObjectsString = @"categories";
            self.filterTypeObjectString = @"category";
        }
            break;
        case FilterTypePerformers:
        {
            [urlString appendString:@"api/v1/performers.json"];
            self.filterTypeObjectsString = @"performers";
            self.filterTypeObjectString = @"performer";
        }
            break;
        default:
            break;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *paramDict = @{@"token": [defaults objectForKey:@"tempToken"]};
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:urlString params:paramDict httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDictionary = (NSDictionary *)jsonObject;
            NSLog(@"temp json : %@", jsonObject);
            [self.choiceListArray addObjectsFromArray:responseDictionary[@"result"][self.filterTypeObjectsString]];
            NSLog(@"temp Array : %@", self.choiceListArray);
            [self setupTableView];
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#warning UIAlertView Appears Here
    }];
    
    [ApplicationDelegate.networkEngine enqueueOperation:op];
}

#pragma mark - TableView

- (void)setupTableView
{
    FilterCellConfigurationBlock configureCell = ^(UITableViewCell* cell, NSDictionary *item) {
        cell.textLabel.tag = 2;
        cell.textLabel.text = item[self.filterTypeObjectString][@"name"];
    };
    
    self.filterDataSource = [[FilterDataSource alloc] initWithDataArray:self.choiceListArray cellIdentifier:@"FilterCell" filterConfigurationBlock:configureCell filterTypeObjectString:self.filterTypeObjectString];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.filterDataSource;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *currentLabel = (UILabel *)[cell viewWithTag:2];
    NSLog(@"temp : %@", currentLabel.text);
    
    //发送通知
    NSDictionary *postDict = @{@"chosenValue": currentLabel.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"filtered" object:postDict];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
