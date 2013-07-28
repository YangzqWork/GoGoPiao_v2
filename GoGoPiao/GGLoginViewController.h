//
//  GGLoginViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class GGAccountViewController;
@class GGEventViewController;
@class GGSettingsViewController;

@interface GGLoginViewController : UIViewController<UITextFieldDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate, NSURLAuthenticationChallengeSender>

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) GGAccountViewController* ggAcountVC;
@property (strong, nonatomic) GGSettingsViewController *ggSettingsVC;

@property (nonatomic) BOOL didRememberPw;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIButton *rememberPwButton;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end
