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

@interface GGEventSearchViewController ()

@property (strong, nonatomic) NSMutableData *responseData;
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
      
        [self setCoreData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    allCount = 0;
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    results = [[NSMutableArray alloc] initWithCapacity:20];
    
//    self.navigationItem.titleView = self.segmentSearch;
//    [_searchBar becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    _searchBar.showsCancelButton = YES;
    [self fetchResult];
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

#pragma mark - 搜索以及搜索栏的Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_searchBar.text.length == 0) {
        return;
    }
    [searchBar resignFirstResponder];
    
    //清空
    [self clear];
    [self doSearch];
//    [self setTableView];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void)doSearch
{
//在Core Data中保存已经搜索过的Keyword
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
    TableViewConfigureCellBlock configureCell = ^(GGEventSearchCell* cell, EventSearched *keyword) {
        cell.titleLabel.text = [keyword valueForKey:@"title"];
    };
    
    NSArray *array = [self.fetchResultController fetchedObjects];
    self.cyTableDataSource = [[CYTableDataSource alloc] initWithDataArray:array cellIdentifier:@"GGEventSearchCell" configureCellBlock:configureCell];
    
    self.tableResult.delegate = self;
    self.tableResult.dataSource = self.cyTableDataSource;
    
    [self.tableResult registerNib:[GGEventSearchCell nib] forCellReuseIdentifier:@"GGEventSearchCell"];
}

#pragma mark - Core Data

- (void)setCoreData
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = [delegate managedObjectContext];
    self.entityDescription = [NSEntityDescription entityForName:@"EventSearched" inManagedObjectContext:self.managedObjectContext];
}

- (void)fetchResult
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    
    [request setEntity:self.entityDescription];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    self.fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError *fetchError = nil;
    BOOL success = [self.fetchResultController performFetch:&fetchError];
    if (success) {
        NSLog(@"fetched!");
    }
    else {
        NSLog(@"fetch fail!");
    }
    
    NSLog(@"EventSearchVC : %@", [self.fetchResultController fetchedObjects]);
}

- (void)createNewEventSearched
{

    EventSearched *newKeyWord = [NSEntityDescription insertNewObjectForEntityForName:@"EventSearched" inManagedObjectContext:self.managedObjectContext];
    if (newKeyWord  != nil) {
        newKeyWord.title = _searchBar.text;
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"Successfully saved the context.");
        }
        else {
            NSLog(@"Failed to save the context. Error = %@", savingError);
        }
    } else {
        NSLog(@"Failed to create the new person.");
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self.fetchResultController fetchedObjects];
    EventSearched *item = [array objectAtIndex:indexPath.row];
    NSString *keyword = [item valueForKey:@"title"];
    
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
