//
//  GGSellingFillingViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGSellingFillingViewController : UIViewController<RETableViewManagerDelegate>

@property (strong, nonatomic) RETableViewManager *tableViewManager;
@property (strong, nonatomic) RETableViewSection *firstTableViewSection;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
