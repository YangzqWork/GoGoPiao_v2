//
//  GGEventSearchResultsViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 24/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "AppDelegate.h"
#import "GGEventSearchResultsViewController.h"
#import "GGAuthManager.h"
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
    
    
    self.title = self.searchKeyword;
    self.eventsArray = [NSMutableArray array];
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

#pragma mark - 搜索结果返回
- (void)returnSearchResult
{
//    NSString *urlString;
//    NSLog(@"check searchBar : %@", self.searchKeyword);
//    
//    urlString = [NSString stringWithFormat:@"%@?token=%@&title=%@", @"/events.json", [GGAuthManager sharedManager].tempToken, self.searchKeyword];
//    NSLog(@"%@", urlString);
//    
//    GGGETLinkFactory *getLinkFactory = [[GGGETLinkFactory alloc] init];
//    GGGETLink *getLink = [getLinkFactory createLink:urlString];
//    [getLink getResponseData];
//    NSDictionary *dict = (NSDictionary *)[getLink getResponseJSON];
//    NSArray *array = [[dict objectForKey:@"result"] objectForKey:@"events"];
//    self.eventsArray = [[NSMutableArray alloc] initWithArray:nil];
//    [self.eventsArray addObjectsFromArray:array];
//    
    NSDictionary *paramDict = @{@"token":[GGAuthManager sharedManager].tempToken, @"title":self.searchKeyword};
    
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"/api/v1/events.json" params:paramDict httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDict = (NSDictionary *)jsonObject;
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
//        cell.eventsTitleLabel.text = [[event objectForKey:@"event"] objectForKey:@"title"];
//        cell.eventsSubtitleLabel.text = [[event objectForKey:@"event"] objectForKey:@"start_time"];
//        cell.eventsThirdLabel.text = [[event objectForKey:@"event"] objectForKey:@"description"];
//        cell.idNumber = [[event objectForKey:@"event"] objectForKey:@"id"];
        
        [cell showEventData:event[@"event"]];
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventsCell" configureCellBlock:configureCell];
    
    self.tableView.dataSource = self.cyTableDataSource;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[GGEventsCell nib] forCellReuseIdentifier:@"GGEventsCell"];
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = [self.eventsArray objectAtIndex:indexPath.row];
    NSString *eventTitle = [[event objectForKey:@"event"] objectForKey:@"title"];
    NSString *eventTime = [[event objectForKey:@"event"] objectForKey:@"start_time"];
    NSString *eventIDNumber = [[event objectForKey:@"event"] objectForKey:@"id"];
    
    self.chooseVC = [[GGChooseViewController alloc] initWithNibName:@"GGChooseViewController" bundle:nil];
    self.chooseVC.titleString = eventTitle;
    self.chooseVC.subtitleString = eventTime;
    self.chooseVC.idNumber = eventIDNumber;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.chooseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
