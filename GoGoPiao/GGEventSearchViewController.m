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
            urlString = [NSString stringWithFormat:@"%@?token=%@&title=%@", api_events_list, [GGAuthManager sharedManager].tempToken, _searchBar.text];
            break;
        case 1:
            catalog = @"ElseArea";
            urlString = [NSString stringWithFormat:@"%@?token=%@&region_id=%d&title=%@", api_events_list, [GGAuthManager sharedManager].tempToken, 1, _searchBar.text];
            break;
    }
    NSLog(@"check url : %@", urlString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:40.0f];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Content-Language"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.responseData = [[NSMutableData alloc] initWithData:data];
    
    [self dealWithData];
    
//    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://42.121.58.78/api/"]];
//    [client getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
//        
//        NSLog(@"check point 2");
//        //成功接收数据后
//        [self._searchBar resignFirstResponder];
//        self.tableResult.hidden = NO;
//        isLoading = NO;
//        NSString *response = operation.responseString;
//        NSLog(@"response string %@", response);
//     
//     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         
//        //接收数据失败后
//        NSLog(@"网络连接问题");
//     }];
    
//    [self.tableResult reloadData];
}

//解析JSON
#warning 需要重构的代码
- (void)dealWithData
{
    
    isLoading = NO;
    self.tableResult.hidden = NO;
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"search result %@", jsonObject);
    
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Not supposed to be a dictionary object!");
        }
        else if ([jsonObject isKindOfClass:[NSArray class]]) {
            self.eventsArray = [[NSMutableArray alloc] initWithArray:(NSArray *)jsonObject];
            NSLog(@"self.eventsArray -- %@", self.eventsArray);
            
        }
    }
    else {
        NSLog(@"Error message -- %@", error);
        NSLog(@"jsonObject -- %@", jsonObject);
    }
    
}

- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGEventSearchCell* cell, NSDictionary *event) {
        cell.titleLabel.text = [event objectForKey:@"title"];
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventSearchCell" configureCellBlock:configureCell];
    
    self.tableResult.delegate = self;
    self.tableResult.dataSource = self.cyTableDataSource;
    
    [self.tableResult registerNib:[GGEventSearchCell nib] forCellReuseIdentifier:@"GGEventSearchCell"];
}


-(void)clear
{
    [results removeAllObjects];
    [self.tableResult reloadData];
    isLoading = NO;
    isLoadOver = NO;
    allCount = 0;
}

@end
