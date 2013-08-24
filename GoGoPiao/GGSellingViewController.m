//
//  GGSellingViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGSellingViewController.h"
#import "GGSellingFillingViewController.h"

@interface GGSellingViewController ()

@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) CYTableDataSource *cyTableDataSource;

@end

@implementation GGSellingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我要转让";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //先隐藏TableView
    self.tableResult.hidden = YES;
    self.searchBar.backgroundColor = [UIColor clearColor];
    
    //去掉搜索框背景
    for (UIView *subview in self.searchBar.subviews)
    {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
            break;  
        }  
    }
    
    //自定义背景
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2-red-menu-bar.png"]];
    [self.searchBar insertSubview:imageView atIndex:1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setTableResult:nil];
    [self setLogoImageView:nil];
    [super viewDidUnload];
}

#pragma mark - UISearchbarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [UIView animateWithDuration:0.5 animations:^{
        int newCenterHeight = self.searchBar.frame.size.height / 2;
        int newCenterWidth = self.searchBar.frame.size.width / 2;
        self.searchBar.center = CGPointMake(newCenterWidth, newCenterHeight);
    }];
    
    self.logoImageView.hidden = YES;
    self.tableResult.hidden = NO;
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_searchBar.text.length == 0) {
        return;
    }
    [searchBar resignFirstResponder];
    //清空
    [self clear];
    [self doSearch];
    [self setTableView];
    
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
#warning Unfinished
    [self.searchBar resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        int newCenterHeight = self.view.frame.size.height / 2;
        int newCenterWidth = self.view.frame.size.width / 2;
        self.searchBar.center = CGPointMake(newCenterWidth, newCenterHeight);
    }];
    
    self.logoImageView.hidden = NO;
    self.tableResult.hidden = YES;
    self.searchBar.showsCancelButton = NO;
}

#pragma mark - 搜索功能

- (void)doSearch
{
    isLoading = YES;
    NSString *urlString;
    NSLog(@"check searchBar : %@", self.searchBar.text);
    
    urlString = [NSString stringWithFormat:@"%@?token=%@&title=%@", @"/events.json", [GGAuthManager sharedManager].tempToken, _searchBar.text];
           
    
    GGGETLinkFactory *getLinkFactory = [[GGGETLinkFactory alloc] init];
    GGGETLink *getLink = [getLinkFactory createLink:urlString];
    [getLink getResponseData];
    self.eventsArray = [[NSMutableArray alloc] initWithArray:nil];
    [self.eventsArray addObjectsFromArray:[getLink getResponseJSON]];
}

-(void)clear
{
    [results removeAllObjects];
    [self.tableResult reloadData];
    isLoading = NO;
    isLoadOver = NO;
    allCount = 0;
}

- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(GGEventSearchCell* cell, NSDictionary *event) {
        cell.titleLabel.text = [event objectForKey:@"title"];
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventsArray cellIdentifier:@"GGEventSearchCell" configureCellBlock:configureCell];
    
    self.tableResult.delegate = self;
    self.tableResult.dataSource = self.cyTableDataSource;
    
    [self.tableResult registerNib:[GGEventSearchCell nib] forCellReuseIdentifier:@"GGEventSearchCell"];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGSellingFillingViewController *fillingVC = [[GGSellingFillingViewController alloc] initWithNibName:@"GGSellingFillingViewController" bundle:nil];
}

@end
