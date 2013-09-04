//
//  GGChooseViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 29/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGChooseViewController.h"
#import "GGListingsViewController.h"
#import "GGSellFirstViewController.h"
#import "EventTitleView.h"

@interface GGChooseViewController ()

@end

@implementation GGChooseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    EventTitleView *eventTitleView = [[EventTitleView alloc] initWithFrame:CGRectMake(0, 0, 210, 44)];
//    eventTitleView.titleLabel.text = self.titleString;
//    eventTitleView.subtitleLabel.text = self.subtitleString;
    self.navigationItem.title = @"选择";
    
    __typeof (&*self) __weak weakSelf = self;
    
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    _manager.delegate = self;
    
    RETableViewSection *section = [RETableViewSection section];
    [_manager addSection:section];
    
    [section addItem:[RETableViewItem itemWithTitle:@"我要购买"
        accessoryType:UITableViewCellAccessoryDisclosureIndicator
        selectionHandler:^(RETableViewItem *item) {
        
            GGListingsViewController *listingsVC = [[GGListingsViewController alloc] initWithNibName:@"GGListingsViewController" bundle:nil];
            listingsVC.idNumber = weakSelf.idNumber;
            
            [item deselectRowAnimated:YES];
            [weakSelf.navigationController pushViewController:listingsVC animated:YES];
    }]];
    [section addItem:[RETableViewItem itemWithTitle:@"我要转让"
        accessoryType:UITableViewCellAccessoryDisclosureIndicator
        selectionHandler:^(RETableViewItem *item) {
            
            GGSellFirstViewController *sellFirstVC = [[GGSellFirstViewController alloc] initWithNibName:@"GGSellFirstViewController" bundle:nil];
            
            [item deselectRowAnimated:YES];
            [weakSelf.navigationController pushViewController:sellFirstVC animated:YES];
    }]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
