//
//  GGEventsDetailViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 28/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTableDataSource;

@interface GGEventsDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *eventID;
@property (strong, nonatomic) IBOutlet UITableView *listingsTableView;



@end
