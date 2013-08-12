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

@property (strong, nonatomic) NSMutableArray *listingArray;

@end

@implementation GGEventsDetailViewController

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


- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGListingsCell* cell, NSDictionary *listing) {
        cell.areaLabel.text = [listing objectForKey:@"title"];
        cell.rowLabel.text = [listing objectForKey:@"start_time"];
        cell.quantityLabel.text = [listing objectForKey:@"description"];
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
