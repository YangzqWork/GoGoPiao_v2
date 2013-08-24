//
//  GGMainViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGEventViewController;
@class GGAccountViewController;
@class GGMoreViewController;

@interface GGMainViewController : UITabBarController

@property (strong, nonatomic) GGEventViewController *ggEventVC;
@property (strong, nonatomic) GGAccountViewController *ggAccountVC;
@property (strong, nonatomic) GGMoreViewController *ggMoreVC;

@end
