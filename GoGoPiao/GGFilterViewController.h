//
//  GGFilterViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterDataSource.h"


@interface GGFilterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *filterTypeTitleString;
@property FilterType filterType;

@end
