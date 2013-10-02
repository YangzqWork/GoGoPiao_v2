//
//  GGTicketViewController.m
//  GoGoPiao
//
//  Created by yzq on 13-10-2.
//  Copyright (c) 2013年 Cho-Yeung Lam. All rights reserved.
//

#import "GGTicketViewController.h"
#import "TicketTbCell.h"
#import "UIBarButtonItem+ProjectButton.h"
#import <QuartzCore/QuartzCore.h>

@interface GGTicketViewController ()

@end

@implementation GGTicketViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本
    if ([[UIDevice currentDevice] systemVersion].floatValue <7.0) {
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem createEdgeButtonWithImage:[UIImage imageNamed:@"nav_backBtn.png"] WithTarget:self action:@selector(didClickBackButton)];
    }
    self.tableView.rowHeight=98.0f;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]];
    
    [self requestTicketData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) requestTicketData{
    self.netEngine=[[RESTfulEngine alloc] initWithHostName:kBaseURL];
    [_netEngine ticketDataWithUrlPath:self.urlPath onSucceeded:^(NSMutableArray *listOfModelBaseObjects) {
        self.ticketDataArray=listOfModelBaseObjects;
        NSLog(@"获取ticket数据成功");
    } onError:^(RESTError *engineError) {
        NSLog(@"error %@",engineError);
    }];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyTicketTbCell";
    TicketTbCell *cell = (TicketTbCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=(TicketTbCell *)[[[NSBundle mainBundle] loadNibNamed:@"TicketTbCell" owner:self options:nil] lastObject];
        UIImageView *bgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyIMG.bundle/cell_normal"]];
        [cell setBackgroundView:bgView];
        
        UIImageView *selectedBgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyIMG.bundle/cell_selected"]];
        [cell setSelectedBackgroundView:selectedBgView];
        
        [cell.posterImageView.layer setBorderWidth:3.0];
        [cell.posterImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TicketTbCell *tCell=(TicketTbCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tCell.ticketNumLabel setBackgroundColor:[UIColor colorWithRed:1.0 green:.2 blue:.3 alpha:1.0]];
    
}


- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end






