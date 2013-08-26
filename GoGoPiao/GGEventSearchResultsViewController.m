//
//  GGEventSearchResultsViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 24/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventSearchResultsViewController.h"

@interface GGEventSearchResultsViewController ()

@property (strong, nonatomic) NSMutableArray *eventsArray;
@property (strong, nonatomic) CYTableDataSource *cyTableDataSource;

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
    [self returnSearchResult];
    [self setTableView];
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
    NSString *urlString;
    NSLog(@"check searchBar : %@", self.searchKeyword);
    
    urlString = [NSString stringWithFormat:@"%@?token=%@&title=%@", @"/events.json", [GGAuthManager sharedManager].tempToken, self.searchKeyword];
    
    GGGETLinkFactory *getLinkFactory = [[GGGETLinkFactory alloc] init];
    GGGETLink *getLink = [getLinkFactory createLink:urlString];
    [getLink getResponseData];
    NSDictionary *dict = (NSDictionary *)[getLink getResponseJSON];
    NSArray *array = [[dict objectForKey:@"result"] objectForKey:@"events"];
    self.eventsArray = [[NSMutableArray alloc] initWithArray:nil];
    [self.eventsArray addObjectsFromArray:array];
}

#pragma mark - Set TableView
- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGEventsCell* cell, NSDictionary *event) {
        cell.eventsTitleLabel.text = [[event objectForKey:@"event"] objectForKey:@"title"];
        cell.eventsSubtitleLabel.text = [[event objectForKey:@"event"] objectForKey:@"start_time"];
        cell.eventsThirdLabel.text = [[event objectForKey:@"event"] objectForKey:@"description"];
        cell.idNumber = [[event objectForKey:@"event"] objectForKey:@"id"];
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventsCell" configureCellBlock:configureCell];
    
    self.tableView.dataSource = self.cyTableDataSource;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[GGEventsCell nib] forCellReuseIdentifier:@"GGEventsCell"];
}

@end
