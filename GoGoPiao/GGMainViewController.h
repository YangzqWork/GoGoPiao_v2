//
//  GGMainViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGCategoryViewController;
@class GGEventViewController;
@class GGOrderViewController;
@class GGSellingViewController;
@class GGAccountViewController;

@interface GGMainViewController : UITabBarController

@property (strong, nonatomic) GGCategoryViewController *ggCategoryVC;
@property (strong, nonatomic) GGEventViewController *ggEventVC;
@property (strong, nonatomic) GGOrderViewController *ggOrderVC;
@property (strong, nonatomic) GGSellingViewController *ggSellingVC;
@property (strong, nonatomic) GGAccountViewController *ggAccountVC;

@end
