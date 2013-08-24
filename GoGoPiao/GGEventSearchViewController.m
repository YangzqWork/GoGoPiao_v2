//
//  GGEventSearchViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventSearchViewController.h"
#import "GGEventSearchCell.h"

@interface GGEventSearchViewController ()

@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray *eventsArray;
@property (strong, nonatomic) CYTableDataSource *cyTableDataSource;

@end

@implementation GGEventSearchViewController

@synthesize segmentSearch;
@synthesize tableResult;
@synthesize _searchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"搜索";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    allCount = 0;
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    results = [[NSMutableArray alloc] initWithCapacity:20];
    
//    self.navigationItem.titleView = self.segmentSearch;
    [_searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSegmentSearch:nil];
    [self setTableResult:nil];
    [self set_searchBar:nil];
    [super viewDidUnload];
}

#pragma mark - 搜索功能

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_searchBar.text.length == 0) {
        return;
    }
    [searchBar resignFirstResponder];
    //清空
    [self clear];
    [self doSearch];
    [self setTableView];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (IBAction)segmentChanged:(id)sender
{
    if (_searchBar.text.length == 0) {
        return;
    }
    //清空
    [self clear];
    [self doSearch];
    [self setTableView];
}


- (void)doSearch
{
    isLoading = YES;
    NSString *catalog;
    NSString *urlString;
    NSLog(@"check searchBar : %@", _searchBar.text);
    switch (self.segmentSearch.selectedSegmentIndex) {
        case 0:
            catalog = @"Guangzhou";
#warning 先忽略了region_id
            urlString = [NSString stringWithFormat:@"%@?token=%@&title=%@", @"/events.json", [GGAuthManager sharedManager].tempToken, _searchBar.text];
            break;
        case 1:
            catalog = @"ElseArea";
            urlString = [NSString stringWithFormat:@"%@?token=%@&region_id=%d&title=%@", @"/events.json", [GGAuthManager sharedManager].tempToken, 1, _searchBar.text];
            break;
    }
    
    GGGETLinkFactory *getLinkFactory = [[GGGETLinkFactory alloc] init];
    GGGETLink *getLink = [getLinkFactory createLink:urlString];
    [getLink getResponseData];
    NSDictionary *dict = (NSDictionary *)[getLink getResponseJSON];
    NSArray *array = [[dict objectForKey:@"result"] objectForKey:@"events"];
    self.eventsArray = [[NSMutableArray alloc] initWithArray:nil];
    [self.eventsArray addObjectsFromArray:array];
    
    [self setTableView];
}

-(void)clear
{
    [results removeAllObjects];
    [self.tableResult reloadData];
    isLoading = NO;
    isLoadOver = NO;
    allCount = 0;
}


- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGEventSearchCell* cell, NSDictionary *event) {
        cell.titleLabel.text = [[event objectForKey:@"event"] objectForKey:@"title"];
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventSearchCell" configureCellBlock:configureCell];
    
    self.tableResult.delegate = self;
    self.tableResult.dataSource = self.cyTableDataSource;
    
    [self.tableResult registerNib:[GGEventSearchCell nib] forCellReuseIdentifier:@"GGEventSearchCell"];
}

@end
