//
//  GGBuySecondViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 13/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGBuySecondViewController.h"
#import "RECreditCardItem.h"

@interface GGBuySecondViewController ()

@property (strong, readwrite, nonatomic) RECreditCardItem *creditCardItem;

@end

@implementation GGBuySecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"购票信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Controls";
    
    self.manager[@"RECreditCardItem"] = @"RETableViewCreditCardCell";
    // Create manager
    //
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    self.creditCardSection = [self addCreditCard];
    self.accessoriesSection = [self addAccessories];
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

#pragma mark -
#pragma mark Credit Card Example

- (RETableViewSection *)addCreditCard
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Credit card"];
    [_manager addSection:section];
    self.creditCardItem = [RECreditCardItem item];
    [section addItem:self.creditCardItem];
    [section addItem:self.creditCardItem];
    
    return section;
}

#pragma mark -
#pragma mark Accessories Example

- (RETableViewSection *)addAccessories
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Accessories"];
    [_manager addSection:section];
    
    // Add items to this section
    //
    [section addItem:[RETableViewItem itemWithTitle:@"Accessory 1" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Accessory 2" accessoryType:UITableViewCellAccessoryDetailDisclosureButton selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    } accessoryButtonTapHandler:^(RETableViewItem *item) {
        NSLog(@"Accessory button in accessoryItem2 was tapped");
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Accessory 2" accessoryType:UITableViewCellAccessoryCheckmark selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }]];
    
    return section;
}


@end
