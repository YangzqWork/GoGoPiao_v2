//
//  GGLoginViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GGLoginViewController : UIViewController<UITextFieldDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate, NSURLAuthenticationChallengeSender>

@property (nonatomic) BOOL didRememberPw;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end
