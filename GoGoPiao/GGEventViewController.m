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
#import "EventTitleView.h"


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
//左上角
    UIImage* loginButtonImage = [UIImage imageNamed:@"nav_loginBtn.png"];
    CGRect frameimgleft = CGRectMake(0, 0, loginButtonImage.size.width, loginButtonImage.size.height);
    UIButton *loginButton = [[UIButton alloc] initWithFrame:frameimgleft];
    [loginButton setBackgroundImage:loginButtonImage forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *loginButtonItem =[[UIBarButtonItem alloc] initWithCustomView:loginButton];
    self.navigationItem.leftBarButtonItem = loginButtonItem;
    
//右上角
    UIImage* searchButtonImage = [UIImage imageNamed:@"nav_searchBtn.png"];
    CGRect frameimgright = CGRectMake(0, 0, searchButtonImage.size.width, searchButtonImage.size.height);
    UIButton *searchButton = [[UIButton alloc] initWithFrame:frameimgright];
    [searchButton setBackgroundImage:searchButtonImage forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchButtonItem =[[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchButtonItem;
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
    MKNetworkOperation *op = [ApplicationDelegate.networkEngine operationWithPath:@"api/v1/events.json" params:paramDict httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            NSDictionary *responseDictionary = (NSDictionary *)jsonObject;
            NSLog(@"GGEvent responseDictionary : %@", responseDictionary);
            
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

- (void)reloadTableViewDataSource{
	
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

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
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
    NSIndexPath *last = [NSIndexPath indexPathForRow:[self.eventsArray count] inSection:0];
    NSArray *toBeDeleted = [NSArray arrayWithObject:last];
    
    for (int i=0;i<[data count];i++) {
        [self.eventsArray addObject:[data objectAtIndex:i]];
    }
    
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
    for (int ind = 0; ind < [data count]; ind++) {
        NSLog(@"%lu", (unsigned long)[self.eventsArray indexOfObject:[data objectAtIndex:ind]]);
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:([self.eventsArray indexOfObject:[data objectAtIndex:ind]] - 1) inSection:0];
        [insertIndexPaths addObject:newPath];
    }
//
//    [self.tableView beginUpdates];
//    [self.tableView deleteRowsAtIndexPaths:toBeDeleted withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

@end
