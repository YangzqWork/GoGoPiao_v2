//
//  GGEventSearchResultsViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 24/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGEventSearchResultsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *searchKeyword;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
