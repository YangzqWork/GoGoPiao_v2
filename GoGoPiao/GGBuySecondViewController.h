//
//  GGBuySecondViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 13/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"

@interface GGBuySecondViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, readonly, nonatomic) RETableViewManager *manager;
@property (strong, readwrite, nonatomic) RETableViewSection *creditCardSection;
@property (strong, readwrite, nonatomic) RETableViewSection *accessoriesSection;

@end
