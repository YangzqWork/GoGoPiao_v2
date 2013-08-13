//
//  GGEventsDetailViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 28/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventsDetailViewController.h"
#import "GGListingsCell.h"
#import "CYTableDataSource.h"

@interface GGEventsDetailViewController ()

@property (strong, nonatomic) IBOutlet UIButton *transferButton;
@property (strong, nonatomic) IBOutlet UIButton *filterButton;
@property (strong, nonatomic) IBOutlet UIButton *checkSeatButton;
@property (strong, nonatomic) IBOutlet UIButton *surroundingsButton;

@property (strong, nonatomic) CYTableDataSource *cyTableDataSource;

@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray *listingArray;

@end

@implementation GGEventsDetailViewController

@synthesize eventID;
@synthesize responseData;
@synthesize listingArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"票集信息";
        UIBarButtonItem *backToMainButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(backToMainButtonPressed:)];
        self.navigationItem.rightBarButtonItem = backToMainButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self beginNetworking];
    [self setTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTransferButton:nil];
    [self setFilterButton:nil];
    [self setCheckSeatButton:nil];
    [self setSurroundingsButton:nil];
    [self setListingsTableView:nil];
    [super viewDidUnload];
}

#pragma mark - SELF

#pragma mark - SELF

- (void)beginNetworking
{
    //设置缓存
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1 * 1024 * 1024];
    
    
    NSMutableString *urlStrin = [[NSMutableString alloc] initWithString:@"http://42.121.58.78/api/v1/events/97/listings.json"];
    NSString *urlString = [urlStrin stringByAppendingString:[NSString stringWithFormat:@"?token=%@&id=%@", [GGAuthManager sharedManager].tempToken, self.eventID]];
    NSLog(@"URLString: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:40.0f];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Content-Language"];
    
    
    //请求从缓存中读取数据
    NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
    if (response != nil) {
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    
    
    //这个是异步    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.responseData = [[NSMutableData alloc] initWithData:data];
    
    
    //Afterwards
    [self dealWithData];
}

//解析JSON
- (void)dealWithData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"jsonObject %@", jsonObject);
    
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Not supposed to be a dictionary object!");
        }
        else if ([jsonObject isKindOfClass:[NSArray class]]) {
            self.listingArray = [[NSMutableArray alloc] initWithArray:(NSArray *)jsonObject];
            NSLog(@"self.listingArray -- %@", listingArray);
            
        }
    }
    else {
        NSLog(@"Error message -- %@", error);
        NSLog(@"jsonObject -- %@", jsonObject);
    }
    
}

- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGListingsCell* cell, NSDictionary *listing) {
        cell.areaLabel.text = [listing objectForKey:@"section"];
        cell.rowLabel.text = [listing objectForKey:@"row"];
        NSString *ticketsCount = [listing objectForKey:@"tickets_count"];
        NSLog(@"ticketCount : %@", ticketsCount);
        [cell.quantityLabel.text stringByAppendingFormat:@"%@", ticketsCount];
        cell.priceLabel.text = [listing objectForKey:@"list_price"];
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.listingArray cellIdentifier:@"GGListingsCell" configureCellBlock:configureCell];
    
    self.listingsTableView.delegate = self;
    self.listingsTableView.dataSource = self.cyTableDataSource;
    
    [self.listingsTableView registerNib:[GGListingsCell nib] forCellReuseIdentifier:@"GGListingsCell"];
}

#pragma mark - 按钮处理

- (void)backToMainButtonPressed:(id)sender
{
#warning Maybe Problem - 返回主页的跳转
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
