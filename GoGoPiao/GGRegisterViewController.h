//
//  GGRegisterViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 19/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GGRegisterViewController : UIViewController<NSURLConnectionDataDelegate, NSURLConnectionDelegate, NSURLConnectionDownloadDelegate, NSURLAuthenticationChallengeSender, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordFirstTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;


@end
