//
//  GGLoginViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGAccountViewController;
@class GGEventViewController;
@class GGSettingsViewController;

@interface GGLoginViewController : UIViewController

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) GGAccountViewController* ggAcountVC;
@property (strong, nonatomic) GGEventViewController* ggEventVC;
@property (strong, nonatomic) GGSettingsViewController *ggSettingsVC;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@end
