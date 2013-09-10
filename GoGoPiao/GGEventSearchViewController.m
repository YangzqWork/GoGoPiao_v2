//
//  GGEventSearchViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventSearchViewController.h"
#import "GGEventSearchResultsViewController.h"
#import "GGEventSearchCell.h"
#import "AppDelegate.h"
#import "CYTableDataSource.h"
#import "GGAuthManager.h"

@interface GGEventSearchViewController ()

@property (strong, nonatomic) NSMutableArray *eventSearchedArray;
@property (strong, nonatomic) CYTableDataSource *cyTableDataSource;

@end

@implementation GGEventSearchViewController

@synthesize tableResult;
@synthesize _searchBar;

#pragma mark - Life-Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"搜索";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    allCount = 0;
    self.navigationItem.title = @"搜索";
    results = [[NSMutableArray alloc] initWithCapacity:20];

    [self customizeNavigationBar];
    [self customizeSearchBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.eventSearchedArray = [defaults objectForKey:@"EventSearched"];
    [self setTableView];
    [self.tableResult reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableResult:nil];
    [self set_searchBar:nil];
    [super viewDidUnload];
}

#pragma mark - Customize
- (void)customizeNavigationBar
{
    self.navigationItem.leftBarButtonItem.title = nil;
    self.navigationItem.leftBarButtonItem = nil;
    
    UIImage* backButtonImage = [UIImage imageNamed:@"nav_backBtn.png"];
    CGRect frameimgleft = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimgleft];
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)customizeSearchBar
{
    _searchBar.backgroundColor = [UIColor clearColor];
    //去掉搜索框背景
    UITextField *searchField;
    for (UIView *subview in _searchBar.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            searchField = (UITextField *)subview;
            break;
        }
    }
    if(!(searchField == nil)) {
        searchField.textColor = [UIColor blackColor];
        [searchField setBackground: [UIImage imageNamed:@"search_bar.png"] ];
        [searchField setBorderStyle:UITextBorderStyleNone];
    }
    //    //自定义背景
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_bg.png"]];
    //    [_searchBar insertSubview:imageView atIndex:0];
    
    [_searchBar becomeFirstResponder];

}

#pragma mark - BACK
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 搜索以及搜索栏的Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_searchBar.text.length == 0) {
        return;
    }
    [searchBar resignFirstResponder];
    
    //清空
    [self clear];
    [self doSearch];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = NO;
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
}

- (void)doSearch
{
    //NSUserDefaults保存已经搜索的数据
    [self createNewEventSearched];
    
    GGEventSearchResultsViewController *resultsVC = [[GGEventSearchResultsViewController alloc] initWithNibName:@"GGEventSearchResultsViewController" bundle:nil];
    
    resultsVC.searchKeyword = _searchBar.text;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resultsVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)clear
{
    [results removeAllObjects];
    [self.tableResult reloadData];
    isLoading = NO;
    isLoadOver = NO;
    allCount = 0;
}

#pragma mark - Set TableView

- (void)setTableView
{
    TableViewConfigureCellBlock configureCell = ^(UITableViewCell* cell, NSString *keyword) {
        cell.textLabel.text = keyword;
    };
    
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:self.eventSearchedArray cellIdentifier:@"DefaultCell" configureCellBlock:configureCell tableViewType:TableViewTypeNormal];
    
    self.tableResult.delegate = self;
    self.tableResult.dataSource = self.cyTableDataSource;
}

#pragma mark - 增加搜索数据

- (void)createNewEventSearched
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *eventsArray = [NSMutableArray arrayWithArray: [defaults objectForKey:@"EventSearched"]];
    if (eventsArray == nil) {
        [defaults setObject:[NSArray arrayWithObject:_searchBar.text] forKey:@"EventSearched"];
    }
    else {
        if (![eventsArray containsObject:_searchBar.text]) {
            [eventsArray addObject:_searchBar.text];
            [defaults setObject:eventsArray forKey:@"EventSearched"];
        }
    }
    [defaults synchronize];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"EventSearched"];
    NSString *keyword = [array objectAtIndex:indexPath.row];
    
    GGEventSearchResultsViewController *resultsVC = [[GGEventSearchResultsViewController alloc] initWithNibName:@"GGEventSearchResultsViewController" bundle:nil];
    resultsVC.searchKeyword = keyword;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resultsVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark - 点击背景的处理代码
- (IBAction)backgroundTap:(id)sender
{
    NSLog(@"test : did touch down");
    [_searchBar resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"test : did touch down");
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view) {
        [_searchBar resignFirstResponder];
    }
}

@end
