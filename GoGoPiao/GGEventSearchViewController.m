//
//  GGEventSearchViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventSearchViewController.h"

@interface GGEventSearchViewController ()

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
}

- (void)doSearch
{
    isLoading = YES;
    NSString *catalog;
    NSString *url;
    switch (self.segmentSearch.selectedSegmentIndex) {
        case 0:
            catalog = @"Guangzhou";
            url = [NSString stringWithFormat:@"?token=%@&region_id=%d&title=%@", [GGAuthManager sharedManager].tempToken, 3, _searchBar.text];
            break;
        case 1:
            catalog = @"ElseArea";
            url = [NSString stringWithFormat:@"%@?token=%@&region_id=%d&title=%@", api_events_list, [GGAuthManager sharedManager].tempToken, 1, _searchBar.text];
            break;
    }

    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://42.121.58.78/api/v1/events.json"]];
    [client getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"check point 2");
        //成功接收数据后
        [self._searchBar resignFirstResponder];
        self.tableResult.hidden = NO;
        isLoading = NO;
        NSString *response = operation.responseString;
        NSLog(@"response string %@", response);
     
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
        //接收数据失败后
        NSLog(@"网络连接问题");
     }];
    
    [self.tableResult reloadData];
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
