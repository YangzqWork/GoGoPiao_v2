//
//  GGBuyFirstViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 13/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"

@interface GGBuyFirstViewController : UIViewController<RETableViewManagerDelegate>
{
    RETableViewManager *_manager;
}

//三个由Detail页面传递进来的字符串
@property (strong, nonatomic) NSString *thisTitle;
@property (strong, nonatomic) NSString *thisTime;
@property (strong, nonatomic) NSString *thisAddress;

@property (strong, nonatomic) NSString *listingID;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;


@property (strong, nonatomic) RETextItem *sectionTextItem;
@property (strong, nonatomic) RETextItem *rowTextItem;
@property (strong, nonatomic) RETextItem *seatsTextItem;
@property (strong, nonatomic) RETextItem *numOfTicketsTextItem;
@property (strong, nonatomic) RETextItem *transportWayTextItem;
@property (strong, nonatomic) RETextItem *priceTextItem;

@property (strong, nonatomic) RETableViewSection *listingDetailSection;

@end
