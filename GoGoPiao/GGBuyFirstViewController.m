//
//  GGBuyFirstViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 13/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGBuyFirstViewController.h"
#import "GGBuySecondViewController.h"
#import "GGLoginViewController.h"

@interface GGBuyFirstViewController ()

@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray *ticketsArray;

@end

@implementation GGBuyFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"购买详细";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self setUpLabels];
    [self beginNetworking];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setTimeLabel:nil];
    [self setAddressLabel:nil];
    [self setTableView:nil];
    [self setImageView:nil];
    [self setNextButton:nil];
    [super viewDidUnload];
}

#pragma mark - 网络请求
- (void)beginNetworking
{
    NSString *urlString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"http://42.121.58.78/api/v1/listings/%@/tickets/unsold.json?id=%@&token=%@",self.listingID, self.listingID, [GGAuthManager sharedManager].tempToken]];
    
    NSLog(@"URLString: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:40.0f];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Content-Language"];
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.responseData = [[NSMutableData alloc] initWithData:data];
    NSLog(@"%@", self.responseData);
    
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
            self.ticketsArray = [[NSMutableArray alloc] initWithArray:(NSArray *)jsonObject];
            NSLog(@"self.listingArray -- %@", self.ticketsArray);
            
        }
    }
    else {
        NSLog(@"Error message -- %@", error);
        NSLog(@"jsonObject -- %@", jsonObject);
    }
    
}

#pragma mark - SELF

- (void)setUpLabels
{
    self.titleLabel.text = self.thisTitle;
    self.timeLabel.text = self.thisTime;
    self.addressLabel.text = self.thisAddress;
}

- (void)setupTableView
{
    // Create manager
    //
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    _manager.delegate = self;
    
    self.listingDetailSection = [RETableViewSection sectionWithHeaderTitle:@"您所选择的座位是："];
    [_manager addSection:self.listingDetailSection];
//座位分区
    self.sectionTextItem = [RETextItem itemWithTitle:@"座位分区：" value:nil placeholder:nil];
    [self.listingDetailSection addItem:self.sectionTextItem];
//座位行号
    self.rowTextItem = [RETextItem itemWithTitle:@"座位行号：" value:nil placeholder:nil];
    [self.listingDetailSection addItem:self.rowTextItem];
//座位号码
    self.seatsTextItem = [RETextItem itemWithTitle:@"座位号码" value:nil];
    [self.listingDetailSection addItem:self.seatsTextItem];
//请选择数量
    self.numOfTicketsTextItem = [RETextItem itemWithTitle:@"请选择数量" value:nil];
    [self.listingDetailSection addItem:self.numOfTicketsTextItem];
//配送方式
    self.transportWayTextItem = [RETextItem itemWithTitle:@"配送方式" value:nil];
    [self.listingDetailSection addItem:self.transportWayTextItem];
//价格
    self.priceTextItem = [RETextItem itemWithTitle:@"价格" value:nil];
    [self.listingDetailSection addItem:self.priceTextItem];

    
//含有ImageView的item
    RETableViewItem *titleAndImageItem = [RETableViewItem itemWithTitle:@"Text and image item" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    titleAndImageItem.image = [UIImage imageNamed:@"Heart"];
    titleAndImageItem.highlightedImage = [UIImage imageNamed:@"Heart_Highlighted"];
    [self.listingDetailSection addItem:titleAndImageItem];
}

#pragma mark - 处理按钮点击
- (IBAction)nextButtonPressed:(id)sender
{
#warning Unfinished - 判断是否已经登录了，决定是先Login还是进入第二步
    
    if ([GGAuthManager sharedManager].token != nil) {
        
    }
    else {
        GGLoginViewController *ggLoginViewController = [[GGLoginViewController alloc] initWithNibName:@"GGLoginViewController" bundle:nil];
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ggLoginViewController animated:YES];  
    }
    
    GGBuySecondViewController *ggBuySecondVC = [[GGBuySecondViewController alloc] initWithNibName:@"GGBuySecondViewController" bundle:nil];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ggBuySecondVC animated:YES];
}

@end
