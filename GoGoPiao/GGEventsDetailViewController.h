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

@property (strong, nonatomic) NSString *thisTitle;
@property (strong, nonatomic) NSString *thisTime;
@property (strong, nonatomic) NSString *thisAddress;
@property (strong, nonatomic) NSString *eventID;

@property (strong, nonatomic) IBOutlet UITableView *listingsTableView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithTitle:(NSString *)_title WithTime:(NSString *)_time WithAddress:(NSString *)_address;

@end
