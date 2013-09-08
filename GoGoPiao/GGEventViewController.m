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
#import "GGChooseViewController.h"
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
    
        self.token = nil;
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
    
    [self setToken];
    if (self.token == nil)
        [self getTempToken];
    else
        [self loadEventsArrayWithCategoryTag:AllTag];
}

- (void)viewDidAppear:(BOOL)animated
{
    
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

#pragma mark - UISegmentControl
- (void)segmentChanged:(UISegmentedControl *)paramSender
{
    if ([paramSender isEqual:self.segmentControl]){
        int selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        
        switch (selectedSegmentIndex) {
            case 0:
            {
                self.navigationItem.title = @"体育比赛";
                [self loadEventsArrayWithCategoryTag:SportsTag];
                
            }
            break;
            case 1:
            {
                self.navigationItem.title = @"音乐会/戏剧";
                [self loadEventsArrayWithCategoryTag:ConcertsTag];
            }
            break;
            case 2:
            {
                self.navigationItem.title = @"其他";
                [self loadEventsArrayWithCategoryTag:ElseTag];
            }
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
    NSString *idNumber = currentEvent[@"event"][@"id"];
    
    GGChooseViewController *chooseVC = [[GGChooseViewController alloc] initWithNibName:@"GGChooseViewController" bundle:nil];
    chooseVC.idNumber = idNumber;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chooseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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

#pragma mark - 业务逻辑

- (void)setToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.token = [defaults objectForKey:@"token"];
    if (self.token == nil) {
        self.token = [defaults objectForKey:@"tempToken"];
    }
}

//Root of the logic
- (void)getTempToken
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"platform"] = @"iphone";
    param[@"application"] = @"gogopiao_v1.0";
    param[@"client_uuid"] = @"1234567890";
    param[@"client_secret"] = @"515104200a02f596fea7c2f298aa621084c5985b";
    
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"api/v1/auth/xapp_auth.json" params:param httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            self.token = ((NSDictionary *)jsonObject)[@"token"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.token forKey:@"tempToken"];
            [defaults synchronize];
            
            [self loadEventsArrayWithCategoryTag:AllTag];
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#warning UIAlertView
        
    }];
    
    [ApplicationDelegate.networkEngine enqueueOperation:op];
}

//Caller : getTempToken
- (void)loadEventsArrayWithCategoryTag:(EventCategoryTag)theCategoryTag
{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    
    
    switch (theCategoryTag) {
        case SportsTag:
            paramDict[@"category_id"] = @"374";
            break;
        case ConcertsTag:
            paramDict[@"category_id"] = @"375";
            break;
        case ElseTag:
            paramDict[@"category_id"] = @"376";
            break;
        case AllTag:
            //No setting
            break;
            
        default:
            break;
    }
    
    paramDict[@"token"] = self.token;
    NSLog(@"paramDict : %@", paramDict);
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"api/v1/events.json" params:paramDict httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDictionary = (NSDictionary *)jsonObject;
            self.eventsArray = responseDictionary[@"result"][@"events"];
            
            [self setTableView];
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [ApplicationDelegate.networkEngine enqueueOperation:op];
}

//Caller : loadEventsArray
- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGEventsCell* cell, NSDictionary *event) {
        [cell showEventData:event[@"event"]];
    };
    
    [self.concertTableView registerNib:[GGEventsCell nib] forCellReuseIdentifier:@"GGEventsCell"];
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventsCell" configureCellBlock:configureCell];
    
    NSLog(@"self.eventsArray : %@", self.eventsArray);
    self.concertTableView.delegate = self;
    self.concertTableView.dataSource = self.cyTableDataSource;
    
    [self.concertTableView reloadData];
}

@end
