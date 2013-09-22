//
//  GGChooseViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 29/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"

@interface GGChooseViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *eventImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *subtitleString;
@property (strong, nonatomic) NSString *idNumber;
@property (strong, nonatomic) UIImage *eventImage;

@end
