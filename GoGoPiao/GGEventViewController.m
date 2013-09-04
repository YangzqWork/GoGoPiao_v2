//
//  GGEventViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "AppDelegate.h"
#import "GGEventViewController.h"
#import "GGEventsCell.h"
#import "GGEventSearchViewController.h"
//#import "GGEventsDetailViewController.h"
#import "GGAuthManager.h"
#import "CYTableDataSource.h"
#import "Constants.h"


@interface GGEventViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *events;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableArray *eventsArray;

@property (nonatomic, strong) CYTableDataSource *cyTableDataSource; 

@end

@implementation GGEventViewController

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
#warning Unfinished - 拿Token只是简单地用CFUUID
//拿Token
        self.token = [GGAuthManager sharedManager].tempToken;
//BarButton
        self.concertTableView.hidden = NO;
        self.title = @"场次";
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonPressed:)];
        self.navigationItem.rightBarButtonItem = barButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.segmentControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.eventsArray = [NSMutableArray array];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSDictionary *paramDict = @{@"token": [GGAuthManager sharedManager].tempToken};

    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"/api/v1/events.json" params:paramDict httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDictionary = (NSDictionary *)jsonObject;
            [self.eventsArray addObjectsFromArray:responseDictionary[@"result"][@"events"]];
            
            [self setTableView];
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@", error);
    }];

    [ApplicationDelegate.networkEngine enqueueOperation:op];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setConcertTableView:nil];
    [self setSegmentControl:nil];
    [super viewDidUnload];
}

- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGEventsCell* cell, NSDictionary *event) {
        [cell showEventData:event[@"event"]];
    };
    
    [self.concertTableView registerNib:[GGEventsCell nib] forCellReuseIdentifier:@"GGEventsCell"];
    
#warning 修改为self.events
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventsCell" configureCellBlock:configureCell];
    
    self.concertTableView.delegate = self;
    self.concertTableView.dataSource = self.cyTableDataSource;
    
    [self.concertTableView reloadData];
}

#pragma mark - UISegmentControl
- (void)segmentChanged:(UISegmentedControl *)paramSender
{
    if ([paramSender isEqual:self.segmentControl]){
        int selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        
        switch (selectedSegmentIndex) {
            case 0:
                break;
            case 1:
                self.navigationItem.title = @"体育比赛";
                break;
            case 2:
                self.navigationItem.title = @"音乐会/戏剧";
                break;
            case 3:
                self.navigationItem.title = @"其他";
                break;
            default:
                break;
        }
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *currentEvent = [self.eventsArray objectAtIndex:indexPath.row];
    NSString *idNumber = [currentEvent objectForKey:@"id"];   
    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:self.ggEventsDetailVC animated:YES];
    //    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 处理按钮动作
- (void)searchButtonPressed:(id)sender
{
    NSLog(@"Search button pressed");
    GGEventSearchViewController *ggEventSearchVC = [[GGEventSearchViewController alloc] initWithNibName:@"GGEventSearchViewController" bundle:nil];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ggEventSearchVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


@end
