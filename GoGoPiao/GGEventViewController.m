//
//  GGEventViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventViewController.h"
#import "GGEventsCell.h"
#import "GGAuthManager.h"
#import "CYTableDataSource.h"

@interface GGEventViewController ()

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableArray *eventsArray;

@property (nonatomic, strong) CYTableDataSource *cyTableDataSource;

@end

@implementation GGEventViewController

@synthesize segmentControl;
@synthesize token;
@synthesize responseData;
@synthesize eventsArray;
@synthesize cyTableDataSource;

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//拿Token
        self.token = [GGAuthManager sharedManager].token;
        
//BarButton
        self.concertTableView.hidden = NO;
        self.title = @"演唱会";
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(test)];
        self.navigationItem.rightBarButtonItem = barButton;
        
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
    
    
    [self beginNetworking];
    [self setUpList];
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

#pragma mark - SELF

- (void)beginNetworking
{
    NSString *urlString = @"http://42.121.58.78/api/v1/events.json?token=";
    [urlString stringByAppendingString:self.token];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:40.0f];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Content-Language"];

//这个是异步    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.responseData = [[NSMutableData alloc] initWithData:data];
    
    
//Afterwards
    [self dealWithData];
}

- (void)dealWithData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&error];
    
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Not supposed to be a dictionary object!");
        }
        else if ([jsonObject isKindOfClass:[NSArray class]]) {
            self.eventsArray = [[NSMutableArray alloc] initWithArray:(NSArray *)jsonObject];
            NSLog(@"self.eventsArray -- %@", eventsArray);
            
        }
    }
    else {
            NSLog(@"Error message -- %@", error);
            NSLog(@"jsonObject -- %@", jsonObject);
    }

}

- (void)setUpList
{
    TableViewConfigureCellBlock configureCell = ^(GGEventsCell* cell, NSDictionary *event) {
        cell.eventsTitleLabel.text = [event objectForKey:@"title"];
        cell.eventsSubtitleLabel.text = [event objectForKey:@"start_time"];
        cell.eventsThirdLabel.text = [event objectForKey:@"description"];
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventsCell" configureCellBlock:configureCell];
//    self.concertTableView.delegate = self.cyTableDataSource;
    
    self.concertTableView.dataSource = self.cyTableDataSource;
    [self.concertTableView registerNib:[GGEventsCell nib] forCellReuseIdentifier:@"GGEventsCell"];
}


#pragma mark - UISegmentControl
- (void)segmentChanged:(UISegmentedControl *)paramSender
{
    if ([paramSender isEqual:self.segmentControl]){
        int selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        NSLog(@"Segment %d with %@ text is selected", selectedSegmentIndex, selectedSegmentText);
        if (selectedSegmentIndex == 0) {
            self.navigationItem.title = @"演唱会";
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
    
}

@end
