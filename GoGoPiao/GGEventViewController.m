//
//  GGEventViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventViewController.h"
#import "GGEventTitleView.h"
#import "GGEventsCell.h"
#import "GGEventSearchViewController.h"
#import "GGEventsDetailViewController.h"
#import "GGAuthManager.h"
#import "CYTableDataSource.h"

@interface GGEventViewController ()

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableArray *eventsArray;

@property (nonatomic, strong) CYTableDataSource *cyTableDataSource;
@property (nonatomic, strong) GGEventsDetailViewController *ggEventsDetailVC;

@end

@implementation GGEventViewController

@synthesize segmentControl;
@synthesize token;
@synthesize responseData;
@synthesize eventsArray;
@synthesize cyTableDataSource;
@synthesize ggEventsDetailVC;

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
        self.navigationItem.titleView = [[GGEventTitleView alloc] init];
        
        
//UISearchBar
        UISearchDisplayController *displaySearch = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        displaySearch.searchResultsDataSource = self;
        displaySearch.searchResultsDelegate = self;
//        displaySearch.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.segmentControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    GGGETLinkFactory *getLinkFactory = [[GGGETLinkFactory alloc] init];
    GGGETLink *getLink = [getLinkFactory createLink:[NSString stringWithFormat:@"/events.json?token=%@", [GGAuthManager sharedManager].tempToken]];
    [getLink getResponseData];
    self.eventsArray = [[NSMutableArray alloc] initWithArray:nil];
    NSDictionary *dict = (NSDictionary *)[getLink getResponseJSON];
    NSArray *array = [[dict objectForKey:@"result"] objectForKey:@"events"];
    
    [self.eventsArray addObjectsFromArray:array];
    

    [self setTableView];
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
    [self setSearchBar:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
}

- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGEventsCell* cell, NSDictionary *event) {
        cell.eventsTitleLabel.text = [[event objectForKey:@"event"] objectForKey:@"title"];
        cell.eventsSubtitleLabel.text = [[event objectForKey:@"event"] objectForKey:@"start_time"];
        cell.eventsThirdLabel.text = [[event objectForKey:@"event"] objectForKey:@"description"];
        cell.idNumber = [[event objectForKey:@"event"] objectForKey:@"id"];
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventsCell" configureCellBlock:configureCell];
    
    self.concertTableView.delegate = self;
    self.concertTableView.dataSource = self.cyTableDataSource;
    
    [self.concertTableView registerNib:[GGEventsCell nib] forCellReuseIdentifier:@"GGEventsCell"];
}


#pragma mark - UISegmentControl
- (void)segmentChanged:(UISegmentedControl *)paramSender
{
    if ([paramSender isEqual:self.segmentControl]){
        int selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        
        
        if (selectedSegmentIndex == 0) {
//            self.navigationItem.title = @"演唱会";
            
        }
        else if (selectedSegmentIndex == 1) {
            self.navigationItem.title = @"体育比赛";
        }
        else if (selectedSegmentIndex == 2){
            self.navigationItem.title = @"音乐会/戏剧";
        }
        else if (selectedSegmentIndex == 3){
            self.navigationItem.title = @"其他";
        }
    }
    
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *currentEvent = [self.eventsArray objectAtIndex:indexPath.row];
    NSString *idNumber = [currentEvent objectForKey:@"id"];
    
    
    self.ggEventsDetailVC = [[GGEventsDetailViewController alloc] initWithNibName:@"GGEventsDetailViewController" bundle:nil];
    self.ggEventsDetailVC.thisTitle = [currentEvent objectForKey:@"title"];
    self.ggEventsDetailVC.thisTime = [currentEvent objectForKey:@"start_time"];
    self.ggEventsDetailVC.thisAddress = [currentEvent objectForKey:@"description"];
    self.ggEventsDetailVC.eventID = idNumber;
//    NSLog(@"title %@", [currentEvent objectForKey:@"title"]);
//    [ggEventsDetailVC.titleLabel.text stringByAppendingString:[currentEvent objectForKey:@"title"]];
//    NSLog(@"title2 %@", ggEventsDetailVC.titleLabel.text);
//    ggEventsDetailVC.timeLabel.text = [currentEvent objectForKey:@"start_time"];
//    ggEventsDetailVC.addressLabel.text = [currentEvent objectForKey:@"description"];
    
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.ggEventsDetailVC animated:YES];
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
