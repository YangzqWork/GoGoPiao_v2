//
//  GGEventSearchViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGEventSearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSMutableArray * results;
    BOOL isLoading;
    BOOL isLoadOver;
    int allCount;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentSearch;
@property (strong, nonatomic) IBOutlet UITableView *tableResult;
@property (strong, nonatomic) IBOutlet UISearchBar *_searchBar;
- (IBAction)segmentChanged:(id)sender;

-(void)doSearch;
-(void)clear;

@end
