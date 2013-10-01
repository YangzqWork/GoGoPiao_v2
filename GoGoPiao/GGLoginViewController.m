//
//  GGLoginViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGLoginViewController.h"
#import "GGRegisterViewController.h"
#import "GGAccountViewController.h"
#import "GGEventViewController.h"
#import "GGMainViewController.h"
#import "SVProgressHUD.h"

@interface GGLoginViewController ()

@property (strong, nonatomic) NSMutableData *responseData;

@end

@implementation GGLoginViewController


@synthesize didRememberPw;
@synthesize userTextField;
@synthesize passwordTextField;

@synthesize responseData;

#pragma mark - Life-Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.didRememberPw = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录/注册";
    
    //设置两个输入框的颜色
    self.userTextField.layer.cornerRadius = 6.0f;
    self.userTextField.layer.masksToBounds = YES;
    self.userTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.userTextField.layer.borderWidth = 3.0f;
    
    self.passwordTextField.layer.cornerRadius = 6.0f;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.passwordTextField.layer.borderWidth = 3.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLoginButton:nil];
    [self setRegisterButton:nil];
    [self setUserTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
}

#pragma mark - 按钮处理
- (IBAction)loginButtonPressed:(id)sender
{
    GGMainViewController *ggMainVC = [[GGMainViewController alloc] initWithNibName:@"GGMainViewController" bundle:nil];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:ggMainVC];
    [self presentViewController:mainNav animated:YES completion:nil];
}

- (IBAction)registerButtonPressed:(id)sender
{
    GGRegisterViewController *ggRegisterVC = [[GGRegisterViewController alloc] initWithNibName:@"GGRegisterViewController" bundle:nil];
    
    //    [self.navigationController pushViewController:ggRegisterVC animated:YES];
    [self presentViewController:ggRegisterVC animated:YES completion:nil];
}


#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //输入的时候变色
    textField.layer.borderColor=[[UIColor orangeColor] CGColor];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.layer.borderColor=[[UIColor grayColor] CGColor];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //点击Return按钮时候触发此method
    if (textField == self.userTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField) {
        //进行登录操作
#warning unfinished - 应该判断是ipad还是iphone来登录
        
        [self.passwordTextField resignFirstResponder];
        [SVProgressHUD showWithStatus:@"正在登录"];
        NSLog(@"%@ -- %@", self.userTextField.text, self.passwordTextField.text);
        
        [self login];
    }
    return YES;
}

#pragma mark - 登录method
- (void)login
{
    
}

@end
