//
//  GGChooseViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 29/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"

@interface GGChooseViewController : UIViewController<RETableViewManagerDelegate> {
    RETableViewManager *_manager;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *subtitleString;
@property (strong, nonatomic) NSString *idNumber;

@end
