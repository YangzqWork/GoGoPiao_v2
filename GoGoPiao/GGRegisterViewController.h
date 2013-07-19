//
//  GGRegisterViewController.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 19/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGRegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordFirstTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;


@end
