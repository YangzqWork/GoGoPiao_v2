//
//  GGSellingFillingViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGSellingFillingViewController.h"

@interface GGSellingFillingViewController ()

@end

@implementation GGSellingFillingViewController

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
    
    self.tableViewManager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    self.firstTableViewSection = [[RETableViewSection alloc] initWithHeaderTitle:@"请输入票面信息"];
    [self.tableViewManager addSection:self.firstTableViewSection];
    [self.firstTableViewSection addItem:[RETextItem itemWithTitle:@"座位分区" value:nil placeholder:@"请输入座位分区"]];
    [self.firstTableViewSection addItem:[RETextItem itemWithTitle:@"排号" value:nil placeholder:@"请输入排号"]];
    [self.firstTableViewSection addItem:[RETextItem itemWithTitle:@"数量" value:nil placeholder:@"请输入数量"]];
    [self.firstTableViewSection addItem:[RETextItem itemWithTitle:@"座位号" value:nil placeholder:@"请输入座位"]];
    [self.firstTableViewSection addItem:[RETextItem itemWithTitle:@"每张价格" value:nil placeholder:@"请输入每张价格"]];
    [self.firstTableViewSection addItem:[RETextItem itemWithTitle:@"拆分方式" value:nil placeholder:@"请输入拆分方式"]];
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
@end
