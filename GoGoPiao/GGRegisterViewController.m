//
//  GGRegisterViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 19/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGRegisterViewController.h"
#import "SVProgressHUD.h"

@interface GGRegisterViewController ()

@end

@implementation GGRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUsernameTextField:nil];
    [self setEmailTextField:nil];
    [self setPasswordFirstTextField:nil];
    [self setPasswordAgainTextField:nil];
    [self setSubmitButton:nil];
    [super viewDidUnload];
}

#pragma mark - Submit点击
- (IBAction)submitButtonPressed:(id)sender
{
//1. 拿到Placeholder里面的数据然后放进API里面PUSH
    
//2. pop重新登录/进入UICollection的界面
    [self dismissModalViewControllerAnimated:YES];
    [SVProgressHUD showWithStatus:@"注册成功"];
}


@end
