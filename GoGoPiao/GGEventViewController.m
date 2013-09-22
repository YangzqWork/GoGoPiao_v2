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
#import "GGFilterViewController.h"
#import "GGAuthManager.h"
#import "CYTableDataSource.h"
#import "Constants.h"
#import "EventTitleView.h"
#import "UIBarButtonItem+ProjectButton.h"
#import "NSString+Encryption.h"

@interface GGEventViewController ()

@property (nonatomic, strong) NSArray *events;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) UITapGestureRecognizer *rightButtonTapped;
@property (nonatomic, strong) CYTableDataSource *cyTableDataSource;

@property (nonatomic, strong) GGEventSearchViewController *ggEventSearchVC;

@end

@implementation GGEventViewController


#pragma mark - Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        self.token = nil;
//BarButton
        self.navigationItem.title = @"票集网";
        
        self.tableView.hidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //自定义Nav
    [self customizeNavigationBar];
    
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
	}
    
    [self.segmentControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.segmentControl setDividerImage:[UIImage imageNamed:@"seg_bg_line.png"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.eventsArray = [NSMutableArray arrayWithCapacity:10];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"temp : %@", [defaults objectForKey:@"tempToken"]);
    
    [self setToken];
    if (self.token == nil)
        [self getTempToken];
    else
        [self loadEventsArrayWithCategoryTag:AllTag];
}

- (void)viewDidAppear:(BOOL)animated
{
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterTheChoice:) name:@"filtered" object:nil];
}

- (void)afterTheChoice:(NSNotification *)notification
{
    NSLog(@"temp : %@", [notification object]);
    NSLog(@"afterTheChoice");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setSegmentControl:nil];
    [self setTableView:nil];
    _refreshHeaderView=nil;
    [super viewDidUnload];
}

#pragma mark - 自定义UI
- (void)customizeTitleView
{
    EventTitleView *titleView = [EventTitleView eventTitleView];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleLabel.font = [UIFont fontWithName:@"GoodMobiPro-CondBold" size:24];
    titleView.titleLabel.text = @"票集网";
    titleView.subTitleLabel.font = [UIFont fontWithName:@"GoodMobiPro-CondBold" size:17];
    titleView.subTitleLabel.text = @"广州";
    titleView.titleLabel.textColor = [UIColor whiteColor];
    titleView.subTitleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleView;
    [titleView sizeToFit];
}

- (void)customizeNavigationBar
{
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem createEdgeButtonWithImage:[UIImage imageNamed:@"nav_loginBtn.png"] WithTarget:self action:@selector(searchButtonPressed)];
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem createEdgeButtonWithImage:[UIImage imageNamed:@"nav_searchBtn.png"] WithTarget:self action:@selector(searchButtonPressed)];
}

#pragma mark - UISegmentControl

- (void)segmentChanged:(UISegmentedControl *)paramSender
{
    if ([paramSender isEqual:self.segmentControl]){
        
        int selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        
        GGFilterViewController *filterVC = [[GGFilterViewController alloc] initWithNibName:@"GGFilterViewController" bundle:nil];
        switch (selectedSegmentIndex) {
            case 0:
            {
                filterVC.filterType = FilterTypeRegions;
                filterVC.filterTypeTitleString = @"选择地区";
            }
            break;
            case 1:
            {
                filterVC.filterType = FilterTypeEventTypes;
                filterVC.filterTypeTitleString = @"选择演出类别";
            }
            break;
            case 2:
            {
                filterVC.filterType = FilterTypePerformers;
                filterVC.filterTypeTitleString = @"选择艺术家";
            }
            break;
            default:
                break;
        }
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:filterVC];
        self.hidesBottomBarWhenPushed = YES;
        [self presentViewController:navController animated:YES completion:nil];
        self.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //加载Pagination
    if (indexPath.row == [self.eventsArray count]) {
        [self performSelectorInBackground:@selector(loadMore) withObject:nil];
        return;
    }
    
    NSDictionary *currentEvent = [self.eventsArray objectAtIndex:indexPath.row];
    
    GGChooseViewController *chooseVC = [[GGChooseViewController alloc] initWithNibName:@"GGChooseViewController" bundle:nil];
    chooseVC.idNumber = currentEvent[@"event"][@"id"];
    NSString *eventTitleString = [NSString stringWithFormat:@"  %@", currentEvent[@"event"][@"title"]];
    chooseVC.titleString = eventTitleString;
    NSString *eventTimeString = [NSString stringWithFormat:@"  %@", currentEvent[@"event"][@"start_time"]];
    chooseVC.subtitleString = eventTimeString;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chooseVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

#pragma mark - 处理按钮动作
- (void)searchButtonPressed
{
    NSLog(@"Search button pressed");
    self.ggEventSearchVC = [[GGEventSearchViewController alloc] initWithNibName:@"GGEventSearchViewController" bundle:nil];
    self.ggEventSearchVC.navigationItem.backBarButtonItem.title = nil;
    self.navigationItem.backBarButtonItem.title = nil;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.ggEventSearchVC animated:YES];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *uuid = [defaults objectForKey:@"UUID"];
    
//需要进行SHA1加密
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"platform"] = @"iphone";
    param[@"application"] = @"gogopiao_v1.0";
    param[@"client_uuid"] = [defaults objectForKey:@"UUID"];
    param[@"client_secret"] = [NSString sha1EncryptWithUnsortedString1:param];
    
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
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"api/v1/events.json" params:paramDict httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDictionary = (NSDictionary *)jsonObject;
            [self.eventsArray addObjectsFromArray:(NSArray *)responseDictionary[@"result"][@"events"]];
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
        
        [cell.eventsImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [cell.eventsImageView.layer setBorderWidth: 2.0];
        [cell.eventsImageView.layer setShadowOffset:CGSizeMake(-1.0, -1.0)];
        [cell.eventsImageView.layer setShadowOpacity:0.5];
        
        [cell showEventData:event[@"event"]];
    };
    
    [self.tableView registerNib:[GGEventsCell nib] forCellReuseIdentifier:@"GGEventsCell"];
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventsCell" configureCellBlock:configureCell tableViewType:TableViewTypeLoadMore];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.cyTableDataSource;
    
    [self.tableView reloadData];
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    paramDict[@"token"] = self.token;
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"api/v1/events.json" params:paramDict httpMethod:@"GET"];
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDictionary = (NSDictionary *)jsonObject;
            [self.eventsArray removeAllObjects];
            [self.eventsArray addObjectsFromArray:(NSArray *)responseDictionary[@"result"][@"events"]];
//            self.eventsArray = responseDictionary[@"result"][@"events"];
            
            [self.tableView reloadData];
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [ApplicationDelegate.networkEngine enqueueOperation:op];
}

- (void)doneLoadingTableViewData
{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _reloading; // should return if data source model is reloading	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed	
}

#pragma mark - loadMore

- (void)loadMore
{
    NSMutableArray *moreEvents = [NSMutableArray array];
    
    static NSInteger current_page = 1;
    current_page += 1;
    
#warning 继续拿pagination = 2，3，4...的信息
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    paramDict[@"token"] = self.token;
    paramDict[@"page"] = [NSString stringWithFormat:@"%ld", (long)current_page];
    
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"api/v1/events.json" params:paramDict httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDictionary = (NSDictionary *)jsonObject;
            NSLog(@"original responseDictionary : %@", responseDictionary);
            [moreEvents addObjectsFromArray:responseDictionary[@"result"][@"events"]];
            [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:moreEvents waitUntilDone:NO];
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [ApplicationDelegate.networkEngine enqueueOperation:op];
}

-(void) appendTableWith:(NSMutableArray *)data
{
    for (int i=0;i<[data count];i++) {
        [self.eventsArray addObject:[data objectAtIndex:i]];
    }
    
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
    for (int ind = 0; ind < [data count]; ind++) {
        NSLog(@"%lu", (unsigned long)[self.eventsArray indexOfObject:[data objectAtIndex:ind]]);
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:([self.eventsArray indexOfObject:[data objectAtIndex:ind]] - 1) inSection:0];
        [insertIndexPaths addObject:newPath];
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

@end
