//
//  GGBuyFirstViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 13/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGBuyFirstViewController.h"
#import "GGBuySecondViewController.h"

@interface GGBuyFirstViewController ()

@end

@implementation GGBuyFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"购买详细";
        [self setupTableView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpLabels];
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
    GGBuySecondViewController *ggBuySecondVC = [[GGBuySecondViewController alloc] initWithNibName:@"GGBuySecondViewController" bundle:nil];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ggBuySecondVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


@end
