//
//  GGEventSearchResultsViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 24/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "AppDelegate.h"
#import "GGEventSearchResultsViewController.h"
#import "CYTableDataSource.h"
#import "GGChooseViewController.h"
#import "GGEventsCell.h"
#import "MKNetworkOperation.h"

@interface GGEventSearchResultsViewController ()

@property (strong, nonatomic) NSMutableArray *eventsArray;
@property (strong, nonatomic) CYTableDataSource *cyTableDataSource;
@property (strong, nonatomic) GGChooseViewController *chooseVC;

@end

@implementation GGEventSearchResultsViewController

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
    [self customizeNavigationBar];
    [self setExtraTableViewCellHidden:self.tableView];
    
    self.title = @"搜索结果";
    [self.eventsArray removeAllObjects];
    self.eventsArray = [NSMutableArray array];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self returnSearchResult];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Customize Appearance
- (void)customizeNavigationBar
{
    self.navigationItem.leftBarButtonItem.title = nil;
    self.navigationItem.leftBarButtonItem = nil;
    
    UIImage* backButtonImage = [UIImage imageNamed:@"nav_backBtn.png"];
    CGRect frameimgleft = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimgleft];
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)setExtraTableViewCellHidden:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Back Button
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 搜索结果返回
- (void)returnSearchResult
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"temp keyword : %@", self.searchKeyword);
    
    NSDictionary *paramDict = @{@"token":[defaults objectForKey:@"tempToken"], @"title":self.searchKeyword};
    
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"api/v1/events.json" params:paramDict httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDict = (NSDictionary *)jsonObject;
            NSLog(@"temp : %@", jsonObject);
            [self.eventsArray addObjectsFromArray:responseDict[@"result"][@"events"]];
            [self setTableView];
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Search Result VC : %@", error);
    }];
    [ApplicationDelegate.networkEngine enqueueOperation:op];
}

#pragma mark - Set TableView
- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGEventsCell* cell, NSDictionary *event) {
        cell.eventsImageView.tag = 1;
        [cell showEventData:event[@"event"]];
    };
    
    NSLog(@"temp : %@", self.eventsArray);
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventsCell" configureCellBlock:configureCell tableViewType:TableViewTypeNormal];
    
    self.tableView.dataSource = self.cyTableDataSource;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[GGEventsCell nib] forCellReuseIdentifier:@"GGEventsCell"];
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGEventsCell *cell = (GGEventsCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIImageView *thumbNailImageView = (UIImageView *)[cell viewWithTag:1];
    UIImage *thumbNailImage = [thumbNailImageView image];
    
    NSDictionary *currentEvent = [self.eventsArray objectAtIndex:indexPath.row];
    
#warning 重构：转移业务逻辑
    GGChooseViewController *chooseVC = [[GGChooseViewController alloc] initWithNibName:@"GGChooseViewController" bundle:nil];
    chooseVC.idNumber = currentEvent[@"event"][@"id"];
    NSString *eventTitleString = [NSString stringWithFormat:@"  %@", currentEvent[@"event"][@"title"]];
    chooseVC.titleString = eventTitleString;
    NSString *eventTimeString = [NSString stringWithFormat:@"  %@", currentEvent[@"event"][@"start_time"]];
    chooseVC.subtitleString = eventTimeString;
    chooseVC.eventImage = thumbNailImage;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chooseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
